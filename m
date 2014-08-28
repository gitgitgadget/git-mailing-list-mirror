From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] improving advice message from "git commit" during a merge
Date: Thu, 28 Aug 2014 10:11:13 -0700
Message-ID: <xmqqoav4bkum.fsf@gitster.dls.corp.google.com>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
	<53FF1DEE.8030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN3EQ-0003bF-A9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbaH1RLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:11:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55642 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbaH1RLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 13:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 838C835BDD;
	Thu, 28 Aug 2014 13:11:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYdLUTijDusGYJt52nqiga9ZsV8=; b=gQTIky
	rE5+ddwWji8GNiP0UkiFdz+HROJKyEri2F3gYxGnc1m2tiZQc85XOwQP5xlln81T
	gWTvycGuhI039SSOuPgs3H3g4m2gw/ggM78a0sSpO56tVMFSYel9GzHtMkw5OUN7
	g5pkUKM6ZWfqbaUlV4uNRzgHoiQFUDJrNCWM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MqsGeU0qFUKeMheL9Kahgi+FkV0/esgN
	qZkcRtf3X/1InjTrOIVkDXG6r6h/G0FGsvJushy6spkwhvKtS8flltd2GXL+kBid
	M8p6lnL+54erj7zlxKutYHLva4W6LWjPRWgUZiV+bh5VZyqz8Ljdkdb6NJUuc1uW
	/60YuZNLjUE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7890135BDC;
	Thu, 28 Aug 2014 13:11:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF1C135BCA;
	Thu, 28 Aug 2014 13:11:15 -0400 (EDT)
In-Reply-To: <53FF1DEE.8030504@gmail.com> (Stefan Beller's message of "Thu, 28
	Aug 2014 14:17:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 51C96D64-2ED6-11E4-BB5B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256103>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 27.08.2014 20:23, Junio C Hamano wrote:
>> I am not doing this myself soon, though.  Hint, hint...
>
> I asked once upon a time, if there was a place, 
> which collects such topics for casual contributors and new comers.
>
> Would you mind to update the leftover bits at
> http://git-blame.blogspot.de/search?q=leftover&by-date=true
> ?

They live in a bit more permanent home at

  http://git-blame.blogspot.com/p/leftover-bits.html

these days.

It is too early to tell this particular one will make an entry there
yet ;-)
