From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 01/12] git p4 test: remove bash-ism of combined
 export/assignment
Date: Sun, 16 Sep 2012 21:50:57 -0700
Message-ID: <7vk3vtxnf2.fsf@alter.siamese.dyndns.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com>
 <1347221773-12773-2-git-send-email-pw@padd.com>
 <5054F22D.2020909@diamand.org> <7vfw6izenb.fsf@alter.siamese.dyndns.org>
 <50559E08.5020500@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:51:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTIc-0006OK-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 06:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab2IQEvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 00:51:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2IQEvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 00:51:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E77AD97D7;
	Mon, 17 Sep 2012 00:50:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DTSL89cQrNe5BVZv6LVWvlGy1bc=; b=Gm/J/2
	kElMdqD09YjX4IaS0z1U9BVfdvqao1lHIBGOGyg18lGmUswzpXa11fEi7diLOgLH
	a+0HblcVlRc1Rxn3kJLvWokiYT6S/nkheacGejNJ0ktYgfGBhTu9dhU5LtOIoapf
	YMkJwSCdU+fM1S+Lx0Kn/6v8uEB2oHyWnSdSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WUIIeB5XgTlnu/JSnA2kdMGY+dV+kLwG
	Ws40fKN0EcFnpMposI5LcT25MrKCdVgHmULGnWpTCk/aShULFCA7ydvjsZZAk5H+
	hQnKI27W7Ct327cJ6qiPM+Y1GlPfKp8UzK8OM1gyLWiGiJyKi+KVMpDW6YMoiGZR
	QK7jMqJFRS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4F6A97D6;
	Mon, 17 Sep 2012 00:50:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 506DC97D4; Mon, 17 Sep 2012
 00:50:59 -0400 (EDT)
In-Reply-To: <50559E08.5020500@diamand.org> (Luke Diamand's message of "Sun,
 16 Sep 2012 10:38:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4638D58A-0083-11E2-B78F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205641>

Luke Diamand <luke@diamand.org> writes:

> On 16/09/12 07:05, Junio C Hamano wrote:
>> Luke Diamand<luke@diamand.org>  writes:
>>
>>> Looks good to me, ack.
>>
>> Thanks; is this an ack for the entire series, or are you expecting
>> further back-and-forth with Pete before the whole thing is ready?
>
> An ack for the whole series. I'm just going through the rest of the
> patches now but I don't expect to find any issues.

As long as the parties involved in the part of the system can agree
that "this series is basically sound", I'd be happy to merge it
down. Minor issues can be fixed up as follow-up patches.

Thanks.  Will merge it to 'next'.
