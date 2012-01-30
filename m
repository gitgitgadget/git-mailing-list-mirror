From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 12:35:31 +0200
Message-ID: <CAMP44s0rp1EwruAwMpntcUzKS=Pbe44t7Eq0OcHdH8WF7OoUhQ@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
	<7v8vkperli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 11:35:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RroaH-0001d5-OL
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 11:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab2A3Kfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 05:35:33 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52005 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008Ab2A3Kfc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 05:35:32 -0500
Received: by lagu2 with SMTP id u2so2092764lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fFF0Zx1SR1AkMLiMeiPErVKIJ3Pc3hBy7lAUFwMECxY=;
        b=Dll+ZmsRLhIWPev98Fmuu/FzfLxYCK+7sTAyaFDEoXiLZiQcaskGHk/PhvpnuuVNqd
         uUyDLoS03U3eHVdowaoV3cmITPpALF6guofavtLMGsrhaH3Bd4xwMvDRV5NVo8eUwNt9
         jcPo7NRVVLuIARR8IjM7YDSSggTgnUY/fpL7w=
Received: by 10.152.147.103 with SMTP id tj7mr8918904lab.3.1327919731369; Mon,
 30 Jan 2012 02:35:31 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 02:35:31 -0800 (PST)
In-Reply-To: <7v8vkperli.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189336>

On Mon, Jan 30, 2012 at 6:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Let's avoid it. This has the advantage that the code is now actually
>> understandable (at least to me), while before it looked like voodoo.
>
> I am somewhat hesitant to accept a patch to shell scripts on the basis
> that the patch author does not understand the existing constructs that
> are standard parts of shell idioms.

I have been writing shell scripts for years[1], and I have *never* had
an encounter with ':'. vim's sh syntax doesn't seem to be prepared for
it, and zsh's sh emulation has problems only when ':' is involved, so
I still think ':' is quite obscure.

Plus, I haven't seen ${foo:=bar} that often.

In any case, there's no need for ad hominem arguments; there is a
problem when using zsh, that's a fact.

[1] https://www.ohloh.net/accounts/felipec/positions/total

-- 
Felipe Contreras
