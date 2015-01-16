From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: reword --author error message
Date: Fri, 16 Jan 2015 11:53:12 -0800
Message-ID: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
	<84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
	<xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
	<20150116093220.GA3006@peff.net>
	<xmqqwq4m3a8k.fsf@gitster.dls.corp.google.com>
	<C67968DA2DD34039AF6EC8B61AA1CA47@PhilipOakley>
	<xmqqbnly376a.fsf@gitster.dls.corp.google.com>
	<CAPig+cR4vaYe+KiJthmpzo3p7JQyGgEDBqqLP0nBM3YjXXZywQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:53:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCxL-0008VG-OW
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbbAPTxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:53:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753864AbbAPTxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:53:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FAB930DAE;
	Fri, 16 Jan 2015 14:53:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ycaliFx6C41lDE0417pJWUwrt5Y=; b=MtD2ve
	k/wCAPyXgi1MmmayG8iHmobkW5tPouQFjQIWsW0jhLiUu8JG1mVRi9yJ/4GO5RMl
	IiZme3NdXMPJsf6Obs4ILQqLxZlF56x5siIdkjkg2JrxsUEDkiHh4tPGLvU9Li7J
	zVtNtIptv/d7VqfqZqS4FWor6cyDcoKtAXQuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/WdNFffl3KLzc/j8eggR38zg13ADzOg
	mM5TXWMF5monEj33905O0sW68q1Q4EJ9UsR8XPh692JnWKsdKp/U40WG7V2MIjAi
	IzDtV44DQ6awtwLOAumKLYypYdoSs57c/V/IzlJjDeYN+B/fnbnksDKz8h4SSrmR
	VAucqIcAiVo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BC7E30DAD;
	Fri, 16 Jan 2015 14:53:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7721C30DAB;
	Fri, 16 Jan 2015 14:53:13 -0500 (EST)
In-Reply-To: <CAPig+cR4vaYe+KiJthmpzo3p7JQyGgEDBqqLP0nBM3YjXXZywQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 16 Jan 2015 14:37:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E49F8FA-9DB9-11E4-AB46-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262569>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jan 16, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>>     die(_("--author '%s': not 'Name <email>', nor matches any existing
>>> author"));
>>
>> Sounds good.  Thanks.
>
> To further bikeshed (particularly if "nor" is in the mix):
>
>     neither 'Name <email>' nor a match for an existing author

Short and sweet ;-)
