From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] [submodule] Add --depth to submodule update/add
Date: Fri, 28 Jun 2013 14:41:19 -0700
Message-ID: <7vd2r5ncao.fsf@alter.siamese.dyndns.org>
References: <1372425746-11513-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hvoigt@hvoigt.net, jens.lehmann@web.de, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 23:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsgQ2-0008FT-3x
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 23:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab3F1VlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 17:41:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab3F1VlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 17:41:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E37B2C502;
	Fri, 28 Jun 2013 21:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JJIxFcwmXiy2sg/R4BC5VoMA8kM=; b=lPn7xg
	/2xIf7QkJtbd333qyMiVabl6Hbq/B3EBWkedIjjjS6+pRQzsFUgeJ3vD2BNmNhoF
	/QS35uu/OjYysBi2Fv8mu2P60B56DMIejnMrK1ZbSBWYBFrhf1nQ9VXh9jqEi9oe
	e+BL41HazKqX/FddqEZR9HzFPCmWiMC16J/7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQxEuHHMotndkfjuSuglm63aa7IIA5QF
	q9SvC6yvSt5ouYduSQJN5uWMdSj2JFjjzqwh4V75avLCDnEFxIU+V7fMYVpszY4j
	bVXmKnkkG2yAXPE5h9wCAofQwtyPebIoQO6rhl0aQsP/Rs3wIuwWzET1vuOrTgfz
	s9kr/MC7K1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 353972C501;
	Fri, 28 Jun 2013 21:41:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B20E12C500;
	Fri, 28 Jun 2013 21:41:20 +0000 (UTC)
In-Reply-To: <1372425746-11513-1-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Fri, 28 Jun 2013 15:22:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78B560EE-E03B-11E2-9E15-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229242>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index a4ffea0..b2d0f0e 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -31,8 +31,9 @@ test_expect_success 'setup a submodule tree' '
>  	git clone super rebasing &&
>  	git clone super merging &&
>  	git clone super none &&
> +	pwd=$(pwd)

Broken &&-chain (will locally amend later but not today).

Thanks.
