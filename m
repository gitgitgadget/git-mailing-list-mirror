From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: How to use git-svnimport without trunk, tags and branches?
Date: Sun, 11 Mar 2007 15:36:38 +0100
Message-ID: <20070311143638.GA7822@diana.vm.bytemark.co.uk>
References: <45F3EA37.2080502@tropezien.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Georg Lohrer <pacco@tropezien.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 15:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQPAS-0005hm-CV
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 15:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933679AbXCKOg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Mar 2007 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933685AbXCKOg5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 10:36:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2634 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933679AbXCKOg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 10:36:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HQPA6-0002Ty-00; Sun, 11 Mar 2007 14:36:38 +0000
Content-Disposition: inline
In-Reply-To: <45F3EA37.2080502@tropezien.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41928>

On 2007-03-11 12:38:31 +0100, Georg Lohrer wrote:

> But times ago I have had the idea of not using the traditional
> structure of subversion for some of my repositories but using the
> repository directly as single directory - no trunk, no tags, no
> branches. That was because I thought only a geek would have the
> "complicated" way for only a few files without any need for tags and
> branches. And now the git-svnimport does not seem to be able to
> handle a SVN-repos structure like mine:
>
> ~/svnrepos/
>      |------- projectA
>                  |---- foo.cpp
>                  |---- foo.h
>
> I want to import projectA into git _with_ the commit-history (there
> are of course no tags and no branches). Is there a way to do that
> with git-svnimport? Or do I have to throw away all the details,
> checkout projectA and reimport it as initial version with git?

You could try something like this:

  trunk: svnrepos/projectA
  tags: svnrepos/dummytags
  branches: svnrepos/dummybranches

I haven't tested, but I think that kind of maneouver should work.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
