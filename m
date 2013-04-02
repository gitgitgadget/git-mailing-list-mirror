From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Re-roll rr/triangle
Date: Tue, 02 Apr 2013 10:28:20 -0700
Message-ID: <7vobdwetaj.fsf@alter.siamese.dyndns.org>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
 <20130402135813.GA23828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:28:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN50t-0007wt-GR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868Ab3DBR2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:28:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761374Ab3DBR2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:28:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3705512AC5;
	Tue,  2 Apr 2013 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n+NB+AbqrKNNBKmHux9Ag3dvl8s=; b=AMoWaI
	nPgsPowoClprD6v8Eq6xQQtGPSU0TDceHJhTTuRYIas4VnP5MrIEI3KZEu+3CrdY
	R4ISRCkrrIiGQ3FoW5OqJ30ihQWDrMsUsGjZ3hgypsRvjtNG2cLKxI5Zotit6L1K
	1NQJfFtJunMN1B8Pl7kIygg5vdtNiXvxGIsok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1rWS2ZZHSEri5JgBJlIK8qmUCc6ZsTG
	7l1xx1RHnRo4L6YiE35KIG5NMkzTGGqUQp29evgsroTuqt9+AQ4vEPmjYoW828vl
	LDhfgXBKND0nV2s6HKAbhLakpMaio7sAG5oREQ1C2ZbTyj4211olSiANZ/WYJ7aR
	dNXbfAW1+f8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2912112AC4;
	Tue,  2 Apr 2013 17:28:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A207712AC1; Tue,  2 Apr
 2013 17:28:21 +0000 (UTC)
In-Reply-To: <20130402135813.GA23828@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 09:58:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B757564C-9BBA-11E2-A4BE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219812>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 02, 2013 at 01:10:28PM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King (1):
>>   t5516 (fetch-push): drop implicit arguments from helper functions
>> 
>> Ramkumar Ramachandra (5):
>>   remote.c: simplify a bit of code using git_config_string()
>>   t5516 (fetch-push): update test description
>>   remote.c: introduce a way to have different remotes for fetch/push
>>   remote.c: introduce remote.pushdefault
>>   remote.c: introduce branch.<name>.pushremote
>
> Thanks; I didn't see any problems in this round.

Can I turn that into 5 Reviewed-by's?
