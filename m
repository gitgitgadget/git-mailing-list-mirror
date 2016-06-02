From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-send-email: fix typo in gmail 2FA section
Date: Wed, 01 Jun 2016 17:19:47 -0700
Message-ID: <xmqqd1o0wifw.fsf@gitster.mtv.corp.google.com>
References: <20160601233741.31594-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 02:19:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8GMe-0004ot-9o
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 02:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbcFBATw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 20:19:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750822AbcFBATv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 20:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B825A21ED4;
	Wed,  1 Jun 2016 20:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uuQyzJitb3Jn
	o70XtEW/o0WDhyo=; b=Hlf+sPwCsfcnPiZ9bxYaH3bFRWI8rpTV7uELLXVmpB8D
	5sbCodpRMwesjKTG5Cr6nfT+vD9z3fjuARvzZ61q+kDEM6aj9N6P+sQAOtZWItWh
	rsvNDX38qDGMEjpcsJtyHO/gwGEoPSvEk6V8lLfohU7h7A9mVyZJu0MKBsxDMS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tA6SPk
	oGNYaz0Ydkn3VfpAIUicgSJ4hyoNi9ppRgg7E6Thnotqu2fDStNvqpYbNoAT5kxh
	I8NMtVMgp5SX2F7Vc61IxSwattdxoJpA/NGcOZ9yBCDutBFmNutIYE+BtIvtppxd
	mex51MOm+p0za8seeO//oIUQG2vQv0pcidnCo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE8F421ED3;
	Wed,  1 Jun 2016 20:19:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 465AF21ED1;
	Wed,  1 Jun 2016 20:19:49 -0400 (EDT)
In-Reply-To: <20160601233741.31594-1-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
	message of "Thu, 2 Jun 2016 01:37:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7D72174-2857-11E6-B3ED-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296178>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>
> On top of v2.9.0-rc1~10^2 (Documentation: add instructions to help
> setup gmail 2FA, 2016-05-27).

Thanks.  I didn't spot it when I queued it.

>  Documentation/git-send-email.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index edbba3a2ef4c..a88d18604a5b 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -450,7 +450,7 @@ edit ~/.gitconfig to specify your account setting=
s:
>  		smtpUser =3D yourname@gmail.com
>  		smtpServerPort =3D 587
> =20
> -If you have multifactor authentication setup on your gmail acocunt, =
you will
> +If you have multifactor authentication setup on your gmail account, =
you will
>  need to generate an app-specific password for use with 'git send-ema=
il'. Visit
>  https://security.google.com/settings/security/apppasswords to setup =
an
>  app-specific password.  Once setup, you can store it with the creden=
tials
