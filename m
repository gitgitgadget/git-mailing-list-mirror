From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Split a subversion repo into several git repos
Date: Thu, 11 Oct 2007 16:50:19 +0200
Message-ID: <20071011145019.GA5315@diana.vm.bytemark.co.uk>
References: <op.tz09zaizjwclfx@ichi> <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com> <e2a1d0aa0710110702o359d6cd9yaa213be6a43924e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Eivind LM <eivliste@online.no>, git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:51:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfzNi-0002IX-BJ
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098AbXJKOuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 10:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbXJKOuu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:50:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4341 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbXJKOut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:50:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IfzMi-0001Ph-00; Thu, 11 Oct 2007 15:50:20 +0100
Content-Disposition: inline
In-Reply-To: <e2a1d0aa0710110702o359d6cd9yaa213be6a43924e4@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60605>

On 2007-10-11 10:02:21 -0400, Patrick Doyle wrote:

> Just be aware that, if you follow this approach, the commit logs
> created by git-svn will be rewritten (relative to the original SVN
> logs) with the SVN repository revision and ID information. I believe
> you can disable this behavior by passing the --no-metadata option to
> "git-svn init", but I haven't tried this yet.

Just to clarify: this is true for all git-svn use, and has nothing to
do with this particular case.

> I also believe that this approach will leave your git repository in
> such as state as to recognize that there is a remote repository from
> which this repository was fetched. I have no idea what implications
> and long term repercussions (if any) this has. It just dawned on me
> as I was rereading the git-svn man page to look for the --no-metdata
> option and read that it will "Set the noMetadata option in the
> [svn-remote] config". Most of that is still Greek to me.

Apart from the metadata appended to the commit messages (which you can
turn off with --no-metadata), all the extra data saved by git-svn is
purely local. Meaning that you can always get rid of it by cloning the
repository, if you can't think of a cleverer way to do it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
