From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0050: fix printf format strings for portability
Date: Tue, 21 Dec 2010 13:26:45 -0800
Message-ID: <7vvd2m7r6y.fsf@alter.siamese.dyndns.org>
References: <4D1105B5.5070703@ramsay1.demon.co.uk>
 <20101221202755.GA27214@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, prohaska@zib.de,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 22:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV9jb-0007Aa-JP
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 22:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab0LUV06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 16:26:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0LUV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 16:26:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AF9C372A;
	Tue, 21 Dec 2010 16:27:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CpVJ9TA+dWhc7rBzX7tBglCFck0=; b=KJfYLg
	B4cKyCfy90CYN16DPccgAK+ziIOls4l6LP5Jg76HZvxoLiEeD6UpStFZ6pNCeuSJ
	gxc6Za7Oa5r11spxEPy3s5RJ3vSIoQBsrB86OxfireBVIXDt1DkiIMhAY6b1wUa6
	KAIKhYrW/CzLMslxrz6bzJx3ztf5I0cXzdspo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJW48paJzknNCQ3eRFav87CEj8JsyZM0
	XMUnmP6PMEAZJMsVtyFLFooDRF87bqsfDCFHespeBaEltFV6o7lc0C+2o2WFtmAi
	BLuwv11qEz9ENK5F3vTD/aq5N5TYDUa7S7cM4lpb+VI70Tsu837eC75jUviTkxgQ
	IUMf4TNm4x8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC2743729;
	Tue, 21 Dec 2010 16:27:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F9AB3727; Tue, 21 Dec 2010
 16:27:15 -0500 (EST)
In-Reply-To: <20101221202755.GA27214@burratino> (Jonathan Nieder's message of
 "Tue\, 21 Dec 2010 14\:27\:55 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 181A0270-0D49-11E0-9EDB-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164060>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Unlike bash and ksh, dash passes through hexadecimal \xcc escapes.
> So when run with dash, these tests *pass* (since '\xcc' is a perfectly
> reasonable filename) but they are not testing what was intended.
>
> Use octal escapes instead, in the spirit of v1.6.1-rc1~55^2
> (2008-11-09).

Thanks.
