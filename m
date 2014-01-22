From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 08:11:33 -0800
Message-ID: <xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
	<xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
	<CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
	<52DFE882.2040605@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Javier Domingo Cansino <javierdo1@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 22 17:11:49 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W60P4-0001PT-CC
	for glk-linux-kernel-3@plane.gmane.org; Wed, 22 Jan 2014 17:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbaAVQLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 22 Jan 2014 11:11:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbaAVQLh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jan 2014 11:11:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1CEF6421E;
	Wed, 22 Jan 2014 11:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=i9/L/cxYYsY7
	ou+nBpbXDUvfZGU=; b=U0xxSHvf3Nt5bWChWFvNuAExw0vct/hzlMoezn9atIY0
	k6B2Cw0xXF7nSx8VGS5kGUHDz9QlD5zaHa7rHPKAT24NS+GW4GGpxwTmPAGo3DZ+
	aMll+A3Qq+IJmBsFCXu6g4lMiylvDYHid8RxMZPDUaOPz9bMXmie+Ig4fzoVpJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yOQ4Xy
	g+OeZQd/QaanEJvPPDkN9wEqwaUOWXsTwL+QRrKkvLVeXF8SrLTJUoJX145cArjY
	yAJ/rzf671xBIcjeX1hAoXA1Zq9KMw8hLBMqy2Nu5v04pd2YeZ9iyS+XYOAYZQEN
	VPv848nRBGcQz/JyfA6xPszYNinmrz3TzI9pM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9AA16421D;
	Wed, 22 Jan 2014 11:11:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF99F6421A;
	Wed, 22 Jan 2014 11:11:35 -0500 (EST)
In-Reply-To: <52DFE882.2040605@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message
	of "Wed, 22 Jan 2014 16:49:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DDECA5A2-837F-11E3-95CA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240836>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

> Am 22.01.2014 13:53, schrieb Javier Domingo Cansino:
>> Will there be any change on how tarballs are distributed, taking int=
o
>> account that Google will be shutting down Google Code Downloads
>> section[1][2]?
>>=20
>
> Am I missing something or what's wrong with this:
>
>   https://github.com/gitster/git/archive/v1.9-rc0.tar.gz
>
> or any
>
>   https://github.com/gitster/git/archive/$TAG.tar.gz
>
> ??

Do these consume CPU every time somebody asks for a tarball?  That
might be considered "wrong" depending on the view.
