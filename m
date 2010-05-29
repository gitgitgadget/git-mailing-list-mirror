From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: fix bogus commit header check
Date: Fri, 28 May 2010 18:10:34 -0700
Message-ID: <7vtypr5x85.fsf@alter.siamese.dyndns.org>
References: <20100526215034.GA6872@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 03:10:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIAZd-0005Q3-N5
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab0E2BKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 21:10:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab0E2BKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 21:10:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89E61B77B1;
	Fri, 28 May 2010 21:10:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=G/6vdpjbq4/r+ar/QbW0SoMJT
	cA=; b=aauln4vo8W18WcDsfQR/eNZ2SMXM6gyHh9745jyn9lwQpQcFO/TigSp55
	oOT+T5bjLKNt+WfAmDZu0kimVJUA7AYswNCbuVSA1OvVu+E69B6BS+jFQizWuTkh
	efQ8i7GZyy11mZ6xosQkvzos8Un7c9e9crY4+zigP+TEu5m9Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AQAnc+DPwlG02qCFsdH
	Ez5GxJ1CzlZutyIYfpdaGrGyB2Y6LxV7/mc7K+xHuCFGXW3atNzTIccelXcGNqbN
	uoNr9YF71hbUIp5096PAOEzdKdK84LRSc8s5GmnvxqqeYoLJJIwaPB0yq6hxG175
	7yMxiJ72pjvateS+K3g8pGBk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FA00B77AF;
	Fri, 28 May 2010 21:10:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89C77B77AE; Fri, 28 May
 2010 21:10:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEA3FC2E-6ABE-11DF-91AA-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147942>

Jonathan Nieder <jrnieder@gmail.com> writes:

> daae1922 (fsck: check ident lines in commit objects, 2010-04-24)
> taught fsck to expect commit objects to have the form
>
>   tree <object name>
>   <parents>
>   author <valid ident string>
>   committer <valid ident string>
>
>   log message
>
> The check is overly strict: for example, it errors out with the
> message =E2=80=9Cexpected blank line=E2=80=9D for perfectly valid com=
mits with an
> "encoding ISO-8859-1" line.
> ...

Thanks.
