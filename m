From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using signed tag in pull requests
Date: Tue, 17 Jan 2012 17:47:15 -0800
Message-ID: <7vwr8pok7w.fsf@alter.siamese.dyndns.org>
References: <7vehuyosaa.fsf@alter.siamese.dyndns.org>
 <CAH5451nSMcJ50fu2qtMkw4zPpx-Kg-k-jqCcpryu+pkC8JX8rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 18 02:47:34 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RnKcf-0002AX-Ra
	for glk-linux-kernel-3@lo.gmane.org; Wed, 18 Jan 2012 02:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511Ab2ARBrT (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 17 Jan 2012 20:47:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab2ARBrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2012 20:47:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DBB85B38;
	Tue, 17 Jan 2012 20:47:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnO/7RC5VG0umfkroV5sCusP6g8=; b=BtY6wV
	BEmg550uo1vfZU35MXi8k7B+S8xp1lOlBam0BY52MVMmh2UDCf965D2VQGBYZnOQ
	gdNzKXn3GsDEnW7HOLMVpNo0ADPOPUANAeTPfAluEOSNXGG1WnED6A5ZdVTuhJ09
	otU6fC3dj2lcBwWttg665Kxrbb0TQQDuTVlH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1nS1pqy1f7ljXRMiLqaiUT1P3Zf8maQ
	BQzqU1GzF/OBrLSlBnvqFY1LmFQc02IiRSHGHyxf1DVGrdSPoPM1etKlraKVUTfc
	GwsgjO4zwC1j+6jKK7A2KjnCy5IrjutmOM2e4erUESCYEZY2fkLrSfWTMxVMeL3j
	mvEOBN92xWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 459C55B37;
	Tue, 17 Jan 2012 20:47:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9C595B36; Tue, 17 Jan 2012
 20:47:16 -0500 (EST)
In-Reply-To: <CAH5451nSMcJ50fu2qtMkw4zPpx-Kg-k-jqCcpryu+pkC8JX8rw@mail.gmail.com> (Andrew
 Ardill's message of "Wed, 18 Jan 2012 12:07:18 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59EB689E-4176-11E1-8E61-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188735>

Andrew Ardill <andrew.ardill@gmail.com> writes:

>> Starting from Git release v1.7.9, a contributor can add a signed tag to
>> the commit at the tip of the history and ask the integrator to pull that
>> signed tag. When the integrator runs `git pull`, the signed tag is
>> automatically verified to assure that the history is not tampered with.
>> In addition, the resulting merge commit records the content of the signed
>> tag, so that other people can verify that the branch merged by the
>> contributor was signed by the contributor, without fetching the signed tag
>
> I think you mean to say 'the branch merged by the integrator was signed
> by the contributor'.

Definitely. I'll update my local copy.

Thanks for spotting this.
