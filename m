From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 6/8] CodingGuidelines: call the conditional statement "if ()", not "if()"
Date: Thu, 01 May 2014 16:14:21 +0200
Organization: Organization?!?
Message-ID: <87lhulziv6.fsf@fencepost.gnu.org>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 16:15:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfrlY-0006go-2w
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 16:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbaEAOPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 10:15:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:47990 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbaEAOPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 10:15:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WfrlP-0006Yb-Ay
	for git@vger.kernel.org; Thu, 01 May 2014 16:15:03 +0200
Received: from x2f52453.dyn.telefonica.de ([2.245.36.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:15:03 +0200
Received: from dak by x2f52453.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f52453.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:Fq8etGyl1VDakUfAUpBGtj8IuU8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247812>

Junio C Hamano <gitster@pobox.com> writes:

> The point immediately before it is about having SP after the control
> keyword.  Follow it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 1b0cd2b..21e4272 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -184,7 +184,7 @@ For C programs:
>     of "else if" statements, it can make sense to add braces to
>     single line blocks.
>  
> - - We try to avoid assignments inside if().
> + - We try to avoid assignments inside "if ()" condition.

That's not grammatical.

-- 
David Kastrup
