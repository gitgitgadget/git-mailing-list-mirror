From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Wed, 22 Feb 2012 21:08:17 -0800
Message-ID: <7vipiy5e7y.fsf@alter.siamese.dyndns.org>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Feb 23 06:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Quo-0001Y8-37
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 06:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab2BWFIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 00:08:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab2BWFIU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 00:08:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75D3074B2;
	Thu, 23 Feb 2012 00:08:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jxKdlxMbECdB
	dlMwKytrbZZXvds=; b=a/HqBLnJWHrCZn+9/uTJtLAKj59Dm92uojSv24pRUQUE
	jdAV57d7e3nlLk+kslPorw03OuUtVFRFlCE6S+doiw2/qD/lM2cXuiHX3ESgJ3/w
	tICdqPUBcxUvbmRPLQQgHQJSyq/CABVCZ6EmwGxcqPARLg1E5O82oXNe1VsjGqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vDbvBe
	JNoDHFITtbLub/GGi18KT4iNaB4Ebl6JaFC2+cEwzCpoEsUfh8PNMem8DOfhh6ne
	1p17X2aa2zegEJtTEb2WqA849dhzkUPlN7bXk0g2rCSHnUsRtUS+Fnm89D5jFdzn
	S45pF5ugmv0EIycZR3PMz3GAFNlp5JXgTpOn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C5AF74B1;
	Thu, 23 Feb 2012 00:08:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1D7574B0; Thu, 23 Feb 2012
 00:08:18 -0500 (EST)
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Mon, 20 Feb 2012
 22:57:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 665CB01A-5DDC-11E1-9124-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191330>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> this is v6, with a new approach.

When you reroll, please make sure you do not run format-patch with
nonstandard settings, e.g.=20

	diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
