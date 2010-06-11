From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Fri, 11 Jun 2010 16:52:19 -0700
Message-ID: <7viq5pgma4.fsf@alter.siamese.dyndns.org>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 12 01:52:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONE1g-00065O-20
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 01:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab0FKXwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 19:52:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879Ab0FKXwd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 19:52:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65532BB287;
	Fri, 11 Jun 2010 19:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LoqYaXGFMDGELFtB9jEZvTa2D30=; b=xHD259qY0wXTfnUAdGe1tew
	295vseD3HflOaTwK114dGXkwescyqNI+LFC5ArUFYAh/xA8Aa7E71qK4p7Flneuf
	cZV9B4Go0SLAXDJvq3JtkjA6MoVvcr/GMgnaXVIKYtTnJ4N4T/edHP/EvjMcqNxs
	kHv4urCPOCGOD8NjrTkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RACW3PsXzh/FzZ38HSBIASTcKcUlJIW8g+W/ZlufPbnAkRMxF
	EfVkFguVvIM8AmUD6hTekPzF+hpsb9BXKG0z56O1yDQJ3sOwoYL0KEOoAw1HKcFr
	PrCbUdVhkNEs6ZrD7woDieU7i+tvM3PXt9XMf6Vq1ukANnhLBK8Tc8debw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 238B0BB282;
	Fri, 11 Jun 2010 19:52:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46C40BB281; Fri, 11 Jun
 2010 19:52:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6312C83E-75B4-11DF-A65E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148976>

Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

> +	switch (userdiff_config(var, value)) {
> +		case 0: break;
> +		case -1: return -1;
> +		default: return 0;
> +	}

Style:

	switch (userdiff_config(var, value)) {
	case 0:
		break;
	case -1:
        	return -1;
	default:
        	return 0;
	}
