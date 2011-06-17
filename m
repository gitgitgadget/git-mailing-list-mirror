From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sh-i18n--envsubst.c: do not #include getopt.h
Date: Fri, 17 Jun 2011 14:28:51 -0700
Message-ID: <7vhb7of8q3.fsf@alter.siamese.dyndns.org>
References: <kRqfchEd_hGmm2-6DxLIF_ZcWaZwm2iR22QJo3x5ntYrK5NZzsgLexeDbn1dSo9BMP8SLjkiTqiNION3P1CL0w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 17 23:29:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXgb6-000586-4l
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 23:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222Ab1FQV2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 17:28:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab1FQV2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 17:28:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A0CFF5298;
	Fri, 17 Jun 2011 17:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2X8evg0QRalmTWmTrzDyMx+KwLs=; b=dTmpgJUi+atuHqfLj2TL
	OUeYEUGtzt7MNy2fy5r/Fj1TL6TZ8yB/EVBHPoA/JxN5JYeIu6li84ekNXThlrtj
	GpzKepo0SR2VJfY7NVw7siwJhNbvkB+b8/JTbB0pYcglsSvmZ7lMteW8K05gNHvk
	fkmZ+T2xRMdtZ1Pp6I1GjgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=x9BXQl/19heW6wcPcXq546b3e/TsTylNSGyD3Dfu2tjwk0
	6aOwhVknSjW09tzrhEYLSMYENfglCIRA/0iZ93f/4GUguWa3DJFf7MlG/bMfdxhI
	e8HlJ8vV0dzS0jLA+Gz5xCcVYzQHpKCERh/lROZhqh5gTouRFcLxpW7JHdEPU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A9545297;
	Fri, 17 Jun 2011 17:31:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B1225296; Fri, 17 Jun 2011
 17:31:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B38DD8E-9929-11E0-8DBA-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175961>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> The getopt.h header file is not used.  It's inclusion is left over from the
> original version of this source.  Additionally, getopt.h does not exist on
> all platforms (SunOS 5.7) and will cause a compilation failure.  So, let's
> remove it.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Thanks; will queue.
