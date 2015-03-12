From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 0/2] [git-gui] "Open existing repository" with submodules
Date: Thu, 12 Mar 2015 21:57:52 +0000
Message-ID: <87k2yl7uan.fsf@red.patthoyts.tk>
References: <1425658913-2721-1-git-send-email-remirampin@gmail.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Remi Rampin <remirampin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 23:06:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWBFE-0004O5-6J
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbCLWGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:06:15 -0400
Received: from know-smtprelay-omc-3.server.virginmedia.net ([80.0.253.67]:51790
	"EHLO know-smtprelay-omc-3.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbCLWGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:06:14 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2015 18:06:13 EDT
Received: from red.patthoyts.tk ([82.45.42.101])
	by know-smtprelay-3-imp with bizsmtp
	id 2lxt1q01N2AxhvW01lxuFH; Thu, 12 Mar 2015 21:57:54 +0000
X-Originating-IP: [82.45.42.101]
X-Spam: 0
X-Authority: v=2.1 cv=UrbtNoAB c=1 sm=1 tr=0 a=FEdcR8KTC/yDun0iFnNZnw==:117
 a=FEdcR8KTC/yDun0iFnNZnw==:17 a=6gpmbu8EOFEA:10 a=xqWC_Br6kY4A:10
 a=1oJP67jkp3AA:10 a=FP58Ms26AAAA:8 a=emO1SXQWCLwA:10 a=pGLkceISAAAA:8
 a=TSbVqHtbAAAA:8 a=Rf460ibiAAAA:8 a=mRh5qn6UenvnjJ86KT4A:9 a=AkUkIWUyXwcA:10
 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id 4D12E196139B;
	Thu, 12 Mar 2015 21:57:53 +0000 (GMT)
Cc: Chris Packham <judge.packham@gmail.com>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <1425658913-2721-1-git-send-email-remirampin@gmail.com> (Remi
	Rampin's message of "Fri, 6 Mar 2015 11:21:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265375>

Remi Rampin <remirampin@gmail.com> writes:

>I'm resubmitting this patch series, hopefully someone takes notice
>this time.
>
>The GUI cannot currently open a submodule because it fails to recognize
>the git link file (regular .git file with content "gitdir: ...").
>
>Previous thread:
>http://thread.gmane.org/gmane.comp.version-control.git/263199
>
>I'm really not sure if/how git-gui is maintained but I do hope somebody
>cares about this component, that is still AFAIK distributed with Git.
>
>Remi Rampin (2):
>  Fixes chooser not accepting gitfiles
>  Makes chooser set 'gitdir' to the resolved path
>
> lib/choose_repository.tcl | 21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)

Thanks. I've applied these onto git-gui's upstream repository with minor
changes to the commit comment to clarify where this becomes useful.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
