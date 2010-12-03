From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/7] CodingGuidelines: mention whitespace preferences
 for shell scripts
Date: Fri, 03 Dec 2010 13:43:24 -0800
Message-ID: <7vsjyemt1f.fsf@alter.siamese.dyndns.org>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:43:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdQ0-0003w0-QK
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0LCVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:43:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab0LCVnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:43:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FC4E3A6B;
	Fri,  3 Dec 2010 16:43:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hvfC9r/ik5I+saUo7B/QXVadAdM=; b=KbdgMT
	IIdyO8DEgS7jZwmWwQva4xQ00kbis3NPL7uHPGk9/ekFSGmKmrkVvcg1BpSf+bXL
	65DT70y/uDbdSsJX2bqu17SlRKBR/l6LDF2QEH7pO8vOA14hSpg9XnTR+xEgCsGY
	k5tc/V/fRH95QME/AthW9VLLZ5/CXge2uvtl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jxnOzDUvySxtdmW78kw/+CFr4zYk8Hm6
	p+zRygsGn5FQKw5/X+Gq9KBhtqorchDEGNn7wivw8GIu6SbQg5aThXFuOYAyb2O7
	VyL//o76vyWkc0y32DTfm9DUaabYse4p+uMqIJKNqg/YBvkgkMau1Ws9dRIi/5Oy
	Bwz/6UoMlpI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF79D3A67;
	Fri,  3 Dec 2010 16:43:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9684C3A60; Fri,  3 Dec 2010
 16:43:46 -0500 (EST)
In-Reply-To: <1291394861-11989-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Fri\,  3 Dec 2010 17\:47\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B5B84E4-FF26-11DF-96B4-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162861>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Documentation/CodingGuidelines |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 5aa2d34..a9191d0 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -31,6 +31,10 @@ But if you must have a list of rules, here they are.
>  
>  For shell scripts specifically (not exhaustive):
>  
> + - We use tabs for indentation.
> +
> + - Case arms are not indented with respect to the case and esac lines.

Thanks.
I am tempted to rephrase the latter as:

    Case arms are indented at the same depth as case and esac lines.

It makes it less hard to read and understand without negation.
