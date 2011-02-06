From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Sun, 06 Feb 2011 12:41:30 -0800
Message-ID: <7vmxm8x5dx.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <m3zkqe8xc8.fsf_-_@localhost.localdomain> <201102051931.10979.thomas@koch.ro>
 <AANLkTikX5Y=TrXayXj-MCaR5p0=Tokc_5ihGqHFL9CQx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: thomas@koch.ro, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:41:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBQd-0002p1-On
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1BFUlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:41:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1BFUlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:41:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B70F33A0;
	Sun,  6 Feb 2011 15:42:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4offiFH99KAPoVjsqUr5Gly5ISc=; b=A+5GGv
	kM+bBhsv/dSRsU8aPs28vhI9RqlKIHdWL4bT52Pm4xxjGehbFaOydGjAFX0sNxtM
	UBcHLwTXmqLTApr8jxQ3KMofuZzV01oDiKls89aTHDUH+iB1NWjb5P3Og2zViuoN
	Ous6kWKtwVgbT2Pj3vEHPPzde0YMca+u4PUKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMsF5WN0yOgkfZwTzbrU5/kIb9S001Q7
	ZK37CF32XQFUn4q9se8+7VdSzjSc1w6HtWJslNJtFZQVixI1K+XP6a3jujuMxC1P
	56oXB6RSfN9rY+zKL5hu3PF33L1MQVl+mPU+dfoYcu3E4tdNAts1mb3jpiCOiv06
	cYKRdYaoJq0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAC70339F;
	Sun,  6 Feb 2011 15:42:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 84FBF339E; Sun,  6 Feb 2011
 15:42:30 -0500 (EST)
In-Reply-To: <AANLkTikX5Y=TrXayXj-MCaR5p0=Tokc_5ihGqHFL9CQx@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 5 Feb 2011 20\:00\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A10D1042-3231-11E0-B9CE-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166200>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sat, Feb 5, 2011 at 19:31, Thomas Koch <thomas@koch.ro> wrote:
>> - Implement the possibility to checkout/read/handle empty directories as soon
>> as possible, even in the next 1.7.x release.
>
> I think regardless of whatever else we do, this makes sense. I think
> it's been suggested by Junio in a neighboring thread as well.

Huh?
