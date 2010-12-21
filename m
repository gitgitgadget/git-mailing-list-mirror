From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 09:50:56 -0800
Message-ID: <7v4oa79fr3.fsf@alter.siamese.dyndns.org>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
 <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
 <1292846433.19322.1.camel@drew-northup.unet.maine.edu>
 <AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
 <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
 <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
 <7vbp4f9gzh.fsf@alter.siamese.dyndns.org>
 <AANLkTikvV1chYnSJUMGGoHTFv8EaXuK5B7Vo71jVyTRy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Drew Northup <drew.northup@maine.edu>,
	"Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 18:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV6Mq-0000cs-M5
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 18:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab0LURvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 12:51:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0LURvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 12:51:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 609283B02;
	Tue, 21 Dec 2010 12:51:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SSq6cbkTxGXXdiFIosS5TZRm3k=; b=Kz6g+S
	yN0Dp5+sINiDqY3yv6fBClYIU00/+5Salyb29w23kx8ch5Fnvj2zMfsL8VnZeI/S
	xJ6r9pW1Nw8oeavrmNIkOa6lMFesyZMuazAE7bBOcQ30g04J4NX3hGnv5CPiLdC9
	DyshHI1bkobpx/tMBX91EnYxG7fvv+q+D2D1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1zuBwKTJuQ6BRq0fDsclBNIG676hO64
	XlYZa1XgDFWV5c/biUugwL9PTB2o8OrmxN95iF0U4EAdcFu1kmeuoh6pX56Af+x/
	WMPRso/etxrGn1OBvZhkPOpK9d38dQAz6b2lbzLV1w0uWNuYfVXW9P7VfdN95Yxc
	OJawStj6wVE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D230C3AFD;
	Tue, 21 Dec 2010 12:51:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA5353AEB; Tue, 21 Dec 2010
 12:51:26 -0500 (EST)
In-Reply-To: <AANLkTikvV1chYnSJUMGGoHTFv8EaXuK5B7Vo71jVyTRy@mail.gmail.com>
 (Thiago Farina's message of "Tue\, 21 Dec 2010 15\:40\:56 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4368374-0D2A-11E0-AC5D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164042>

Thiago Farina <tfransosi@gmail.com> writes:

> Maybe I'm missing something, or I'm confused (or I do not understand
> what I'm reading), but how you are assign routine to do_nothing if you
> have removed do_nothing above?

Apply the patch and read the first twenty lines of resulting wrapper.c
