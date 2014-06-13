From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: show staged submodules regardless of ignore config
Date: Fri, 13 Jun 2014 18:36:32 +0100
Message-ID: <87k38k66j8.fsf@red.patthoyts.tk>
References: <xmqqppilpwwe.fsf@gitster.dls.corp.google.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:52:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVem-00074M-Dx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbaFMRws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:52:48 -0400
Received: from know-smtprelay-omc-9.server.virginmedia.net ([80.0.253.73]:58386
	"EHLO know-smtprelay-omc-9.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbaFMRws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:52:48 -0400
Received: from red.patthoyts.tk ([82.34.175.55])
	by know-smtprelay-9-imp with bizsmtp
	id Dtsj1o0281C56nm01tskuu; Fri, 13 Jun 2014 18:52:44 +0100
X-Originating-IP: [82.34.175.55]
X-Spam: 0
X-Authority: v=2.1 cv=bdnlUY/B c=1 sm=1 tr=0 a=g1XlTrwDEGH9N8TSFs8Bjw==:117
 a=g1XlTrwDEGH9N8TSFs8Bjw==:17 a=6gpmbu8EOFEA:10 a=au0hL0heDXEA:10
 a=CtgcEeagiGAA:10 a=xqWC_Br6kY4A:10 a=FP58Ms26AAAA:8 a=ybZZDoGAAAAA:8
 a=Rf460ibiAAAA:8 a=Z07G6e2n9i0R4G7UIY8A:9 a=qIVjreYYsbEA:10 a=5KVauyKsRKMA:10
 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (localhost [IPv6:::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id ADD331960E8A;
	Fri, 13 Jun 2014 18:52:43 +0100 (BST)
In-Reply-To: <xmqqppilpwwe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Jun 2014 14:10:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
CC: Git Mailing List <git@vger.kernel.org>
X-Url: http://www.patthoyts.tk/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251624>

Junio C Hamano <gitster@pobox.com> writes:

>From: Jens Lehmann <Jens.Lehmann@web.de>
>Date: Tue, 8 Apr 2014 21:30:51 +0200
>
>Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
>"all" suppresses all output of submodule changes for git-gui. This is
>really confusing, as even when the user chooses to record a new commit for
>an ignored submodule by adding it manually this change won't show up under
>"Staged Changes (Will Commit)".
>
>Fix that by using the '--ignore-submodules=dirty' option for both callers
>of "git diff-index --cached" when the underlying git version supports that
>option.
>
>Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>Signed-off-by: Junio C Hamano <gitster@pobox.com>
>---
>
> * Pat, I've been carrying this in my 'pu' but I would prefer
>   changes to git-gui fed to me through you.  Could you apply this
>   so that I can drop my tentative copy?
>

OK - Applied.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
