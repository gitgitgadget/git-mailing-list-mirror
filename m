From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] streaming filter: ident filter and filter cascading
Date: Tue, 24 May 2011 18:06:36 -0700
Message-ID: <7vy61v612b.fsf@alter.siamese.dyndns.org>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
 <1305961127-26540-5-git-send-email-gitster@pobox.com>
 <4DD82931.6000101@lsrfire.ath.cx> <4DD82DB2.8000101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 25 03:06:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP2Yj-0002IW-Vi
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 03:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990Ab1EYBGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2011 21:06:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900Ab1EYBGo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 21:06:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 015EA5644;
	Tue, 24 May 2011 21:08:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AVjY62rKhK8H
	n+xzkaIX7Mgm6gQ=; b=CT+I2LCqmTbNSWzhcIsEr1T0NfdVqUKlH7gSzih9cQgo
	YLIHh9Jg5jOpiO81qZmq2MqIjQLDnDlUgzAkLTfuuM/ggtqV7k2bGVQcbpIoZhFf
	WbJGy4p+yD/sXPCmzlLxkyWNrbnzz36C/uAHyNE7W9ryfOkzmm3fZCGnL/6U9pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jQHCgP
	YV4svBzx0FMU40imsQaoLyChXubNzzstqGnc1RWG5UIWGHlucbJ7MSwqRBeTMeLi
	olUFPcjaa2YFRrhrYFc6bhlXRXuFAdWjB7kKuOLBxolsPw44IfdJ1pNZ/6/S9Hsp
	xcGG9QogxDNM9VudCnaznW7XFfU4OW312HRtA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3EFE5642;
	Tue, 24 May 2011 21:08:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4ADB5641; Tue, 24 May 2011
 21:08:45 -0400 (EDT)
In-Reply-To: <4DD82DB2.8000101@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 21 May 2011 23:25:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BE5D42C-866B-11E0-91ED-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174364>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Subject: t0021-conversion.sh: fix NoTerminatingSymbolAtEOF test

Thanks.
