From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 4/8] CodingGuidelines: give an example for control statements
Date: Thu, 01 May 2014 16:12:15 +0200
Organization: Organization?!?
Message-ID: <87ppjxziyo.fsf@fencepost.gnu.org>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 16:20:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfrqS-0004eW-JY
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 16:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaEAOUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 10:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:49481 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbaEAOUI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 10:20:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WfrqG-0004Ov-Ap
	for git@vger.kernel.org; Thu, 01 May 2014 16:20:04 +0200
Received: from x2f52453.dyn.telefonica.de ([2.245.36.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:20:04 +0200
Received: from dak by x2f52453.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f52453.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:ejwe/A0iX1/7+ZTd0qfvFEXkkhI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247813>

Junio C Hamano <gitster@pobox.com> writes:

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 1e0c4cf..d72e912 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -97,6 +97,17 @@ For shell scripts specifically (not exhaustive):
>     "then" should be on the next line for if statements, and "do"
>     should be on the next line for "while" and "for".
>  
> +	(incorrect)
> +	if test -f hello; then
> +		do this
> +	fi
> +
> +	(correct)
> +	if test -f hello
> +	then
> +		do this
> +	fi
> +
>   - We prefer "test" over "[ ... ]".
>  
>   - We do not write the noiseword "function" in front of shell

s/noiseword/bashism/

-- 
David Kastrup
