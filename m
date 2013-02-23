From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] update-index: list supported idx versions and their
 features
Date: Sat, 23 Feb 2013 13:23:30 -0800
Message-ID: <7vk3py7mi5.fsf@alter.siamese.dyndns.org>
References: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
 <1361584468-11820-1-git-send-email-pclouds@gmail.com>
 <20130223205356.GC3222@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:24:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9MZZ-0006Gj-7t
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 22:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab3BWVXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 16:23:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757853Ab3BWVXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 16:23:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0679BBB0A;
	Sat, 23 Feb 2013 16:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OOxT1bg2M8M3
	Zkx6yKuL2LgPuwY=; b=h1/Qma/2iIYPtl3lwyOYUYhdoHtg27xTytkK8Z0IG9KI
	zrMySuP23w+iTLYGAnhXwZuzAZOlb/G33iCfwc7xsWHb0hQfC+g7JqQ92ju2ZdYC
	PG5bfxXQVa4j0PXwtqb19dNwQ1lTnd1P9zjoEai8cpUWhux3LThl7MDVd0WP5KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ci3ALg
	Nj5BUUD16OKm4ofAsV6vIrWySnEkiqzA7XursipYliy49Z5oAsifPgrf8pIvEZTB
	ltQA0SVfx18ysMSqN5DXajmOhCnmZ8piJX0KWLpoW/gBaQIRJ43vr6SD/Bh74/nu
	hG4ICzt4dvcXCC2meD9mxMPDSg2u1DtfL4AmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3FDBB08;
	Sat, 23 Feb 2013 16:23:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74DDEBB04; Sat, 23 Feb 2013
 16:23:31 -0500 (EST)
In-Reply-To: <20130223205356.GC3222@elie.Belkin> (Jonathan Nieder's message
 of "Sat, 23 Feb 2013 12:53:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45BFC5F6-7DFF-11E2-AE3E-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216916>

Thanks, both.

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> ...
>> +	Version 4 performs a simple pathname compression that could
>> +	reduce index size by 30%-50% on large repositories, which
>> +	results in faster load time. Version 4 is relatively young
>> +	(first released in 1.8.0 in October 2012). Other Git
>> +	implementations may not support it yet.
>
> Usage nit: s/could/can/

I think s/could reduce/reduces/ is even simpler.
