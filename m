From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4049: avoid test failures on filemode challenged file
 systems (Windows)
Date: Sat, 01 Dec 2012 18:24:39 -0800
Message-ID: <7vd2ytmbrs.fsf@alter.siamese.dyndns.org>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
 <50B71B33.1090000@viscovery.net> <7v38zss7zb.fsf@alter.siamese.dyndns.org>
 <7vfw3sqoup.fsf@alter.siamese.dyndns.org>
 <7vfw3sp232.fsf@alter.siamese.dyndns.org> <50B86438.3010806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:25:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TezEp-0003kR-0K
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 03:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab2LBCYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 21:24:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab2LBCYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 21:24:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321D3A99C;
	Sat,  1 Dec 2012 21:24:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=koK1YJX+3kww8bAcQY8LNFDpeGg=; b=ZZ0htI
	j63K0T4Vd4VIIiP3wihr/df4zsUu6mPTnxE6Mpdc3sTGMk/nruhFYiQOw0BwDW+m
	QMX3+xQweCXs15a6YOJbGYxXKt1Jwo2iknDvg/CVdmsZ8uzok8y/N4DNIB1nZpEt
	6Wt28cgpUvNOc6yEwcpU9Q0iWSizh7z6uPFNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nX0Ymk+Ln5J8o9oF1KeJD8P41nvYODAU
	/X22gbL/1DKjgyF/x0KoUil8SjiBPbvCNDxAP48tz80Ue84ICb8HYXsggPrbnLVb
	f0x5nJQO2GWCLBxWOknD6ZJUgJa/njl5CemXMg14kJ14TQ+xPyLemwyVj4MxenTl
	96XbTkeuhFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C433A99B;
	Sat,  1 Dec 2012 21:24:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C487A997; Sat,  1 Dec 2012
 21:24:40 -0500 (EST)
In-Reply-To: <50B86438.3010806@viscovery.net> (Johannes Sixt's message of
 "Fri, 30 Nov 2012 08:46:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D11EC66-3C27-11E2-97A3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210992>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 11/29/2012 21:48, schrieb Junio C Hamano:
>> I've tested this with the testpen set on vfat mounted on my Linux
>> box, ...
>> and it seems to work OK,
>
> Works well here on Windows, too.

Thanks for checking.
