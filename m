From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Doc: git-push: Specify the default mode in the
 description
Date: Tue, 09 Nov 2010 16:32:55 -0800
Message-ID: <7vd3qej9vs.fsf@alter.siamese.dyndns.org>
References: <AANLkTimYTRvOb1SjjUyANuTX2sCRKj17bLMbkKKG3rFg@mail.gmail.com>
 <1289305497-13883-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 01:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFych-0005eL-UO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 01:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab0KJAdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 19:33:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0KJAdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 19:33:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D88FA3DFD;
	Tue,  9 Nov 2010 19:33:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zVcblzSILcFb
	VHYwVW4HzaI6jM0=; b=F33aOx7pLg6GYzLkNlysA9pDeuDOk3AshZ/qaqG3hYQO
	MNHli2ryK6xhYeQCsxhix17eUAEIvbnHCMHmwJeZ1415myXS4r2knKYkDliGh2Mj
	4+d/9c8j785KcHggSYM2nkdLDrXinuw5twhYvel8kN/8sY6wbibOPW4K1blRq7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N8pPBm
	DB+tQIjg4wOEzLPGIJzySRlewLi0zD2NaNJibu/WNKiieXqfbG8Khx5k8xKX220U
	6wbby0AYyeaww14tR52CPXkL+V/jqUjRNppQ0Qj2M7jl66tCid5b16U5n3y433Fo
	6G3/frI/3US7YDL/+oEjgGqf8nLlRPcxkOF64=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8F4E3DFC;
	Tue,  9 Nov 2010 19:33:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6AAB23DFB; Tue,  9 Nov 2010
 19:33:01 -0500 (EST)
In-Reply-To: <1289305497-13883-1-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Tue\,  9 Nov 2010 13\:24\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14F84852-EC62-11DF-8EDE-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161114>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Text extracted from the <refspec> option.

Perhaps I wasn't clear enough.  "extracted" is not something we want.

If you think "'matching' is the default" is so important than anything
else, explaining it upfront _might_ be a good idea, but then why leave =
the
original description only to repeat the same thing again?

It would be an improvement if you rephrased things so that the manual
becomes shorter, non repetitive, and having more important information
easier to find.  Otherwise it's just adding noise on top of noise that
already is there, isn't it?
