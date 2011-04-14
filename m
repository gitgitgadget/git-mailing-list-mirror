From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive: tar.umask ignored
Date: Thu, 14 Apr 2011 15:57:34 -0700
Message-ID: <7vhba0fnkx.fsf@alter.siamese.dyndns.org>
References: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com>
 <4DA497B7.706@lsrfire.ath.cx>
 <BANLkTinEFPZoaUAc+8F1sPGE636u1vDOZw@mail.gmail.com>
 <4DA73749.40303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacek Masiulaniec <jacek.masiulaniec@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAVU4-0004ES-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab1DNW5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 18:57:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab1DNW5u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 18:57:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 739035EE6;
	Thu, 14 Apr 2011 18:59:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RZMfq3RjYJno
	muo+nwXYZJALo80=; b=nM8ud1F20fB7Ck4OH19KTw/knxTdV/i5jxQ4buFSgWC4
	bJsIgw/g0RX4IWg/0Ks85lVM48HekTaEME4XAolJ3yCaHavmEMT1S+/1phZzlYBf
	lPCvC/wmrvda2bheRaZ4jYsXx+6EPgkQAcDS1UCnzsOKliNqKSTd9Xfyyh/g5ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=edP4Hh
	IVeu1ytl+qIWDGBIB5zR/U7e+p2bkey2KYCeJ9/iZ6iTH+o/QHV8V1pcRzf3VL34
	vfq33h/n1VYjWRoMKi2s08y37sJBWEpeFPkZs/++A3DjskoVnebSpWPdYom/1eco
	U+6612CqRD66c1jevaCLPyxTVejjubezzbAc4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DDB35EE5;
	Thu, 14 Apr 2011 18:59:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CA6C5EE4; Thu, 14 Apr 2011
 18:59:34 -0400 (EDT)
In-Reply-To: <4DA73749.40303@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu, 14 Apr 2011 20:04:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1FAFE28-66EA-11E0-91E1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171571>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Yes, the documentation should be updated first.

Thanks; applied.
