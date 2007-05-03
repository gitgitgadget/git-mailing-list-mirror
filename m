From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: FFmpeg considering GIT
Date: Thu, 3 May 2007 20:00:16 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070503180016.GB21333@informatik.uni-freiburg.de>
References: <loom.20070502T111026-882@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
X-From: git-owner@vger.kernel.org Thu May 03 20:00:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjfbX-0003Pb-Da
	for gcvg-git@gmane.org; Thu, 03 May 2007 20:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767649AbXECSAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767662AbXECSAY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 14:00:24 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:41199 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767649AbXECSAV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 14:00:21 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HjfbH-0001Ea-Ut; Thu, 03 May 2007 20:00:20 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l43I0GJ7026676;
	Thu, 3 May 2007 20:00:16 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l43I0GnT026674;
	Thu, 3 May 2007 20:00:16 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Panagiotis Issaris <takis.issaris@uhasselt.be>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20070502T111026-882@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46092>

Hello,

Panagiotis Issaris wrote:
> There are some other things the FFmpeg maintainer mentions, namely:
> * He wants to be able to revert a commit in some way without "wiping"=
 history.
> That is without committing a patch which reverses the broken commit, =
as this
> would pollute "git blame". The maintainer sees this as critical featu=
re for
> switching to git as it apparently can be doing using Subversion:
> "in svn we can do this with svn cp from a specific
> revission git and mercurial lack proper copy support"
To add more context, Michael Niedermayer (=3DFFmpeg maintainer) wrote (=
in
[1]):

	let me explain a little bit why this is critically needed
	think of someone misstakely commiting the whole ffmpeg
	reindented or mistakely commiting a old ffmpeg version over the
	new or another total messup, these things do happen, and
	especially if they cannot be corrected and at the time where
	none of the developers is around

=46or me this sounds like:  I don't want people with commit access doin=
g
this, and if they do, I want to be able to revert it.

If FFmpeg used a development scheme similar to the linux kernel, there
should be no need for revert:  The upstream maintainer only needs to pa=
y
attention to the things he does directly (he probably does in any case)
and check the patches he applies and the trees he pulls.  As git gives =
a
diffstat on pull and he reviews patches before applying the problem is
maybe gone?

Commit access is simply different in a distributed environment, see
http://thread.gmane.org/gmane.comp.version-control.git/45849/focus=3D45=
956

Best regards
Uwe

> [1]
> http://article.gmane.org/gmane.comp.video.ffmpeg.devel/49673

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
