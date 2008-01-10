From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STG PATCH] add a --index option to refresh which takes the contents of the index as the new commit
Date: Thu, 10 Jan 2008 01:08:54 +0100
Message-ID: <20080110000854.GA13111@diana.vm.bytemark.co.uk>
References: <200712302003.33478.kumbayo84@arcor.de> <200801022039.27611.kumbayo84@arcor.de> <20080107105612.GA20981@diana.vm.bytemark.co.uk> <200801082142.47060.kumbayo84@arcor.de> <20080109072358.GB28839@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 02:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCmDx-0006M6-3Y
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 02:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbYAJB2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2008 20:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755119AbYAJB2U
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 20:28:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2018 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310AbYAJB2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 20:28:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JCkyc-0003Ql-00; Thu, 10 Jan 2008 00:08:54 +0000
Content-Disposition: inline
In-Reply-To: <20080109072358.GB28839@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70031>

On 2008-01-09 08:23:58 +0100, Karl Hasselstr=F6m wrote:

> On 2008-01-08 21:42:46 +0100, Peter Oberndorfer wrote:
>
> > Patch now comes with a Signed-off-by and a log message that
> > explains how this feature could be used. It was tested with the
> > testcase, used during development of this patch and on another
> > repo, but still take care when using it :-)
>
> I may be promising too much now, but hopefully I'll get to this
> tonight.

I've rebased my patch stack on top of Catalin's master now, and put
your two patches on top. The --index patch is only in experimental and
not stable, since you recommend further testing.

I massaged the commit messages slightly, mainly to get a reasonably
short first line and end all sentences with a period (except on the
first line, of course!).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
