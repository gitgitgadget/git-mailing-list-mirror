From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] refresh_index: notice typechanges in output
Date: Fri, 18 Nov 2011 12:40:29 -0800
Message-ID: <7vwraxjhaa.fsf@alter.siamese.dyndns.org>
References: <20111114225056.GA27370@sigill.intra.peff.net>
 <20111114225651.GD3993@sigill.intra.peff.net>
 <7vaa7yi6wv.fsf@alter.siamese.dyndns.org>
 <20111115020506.GA6305@sigill.intra.peff.net>
 <20111118110938.GA5940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 21:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRVEj-0006Eb-LI
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 21:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab1KRUkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 15:40:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab1KRUkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 15:40:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9336782;
	Fri, 18 Nov 2011 15:40:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyv1n1aByAxF/05RaWoWgEE/4hM=; b=TL7Yeq
	MQlMQQKgEJYf0All190Arpdq9McQ/YekcZXiAWNtKnDxP6tBz/AkaVyUDFPr2Pp6
	Ctj1tFfij+PDhW0sLyELxdPPirJ6GJ6Co1VQAtECMQkGMO6h+j8LXoJhbWgRYj09
	ZFS48LmDQAjoDDZc9dBppEFwOyaSqE/AyxLAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AHVS4ozysA23F00/JY36aU8BsnAUNLK7
	vs9UvdAAV4GyHnO8BLFNGT4q063ZIPoBJIXJMC+Hdb2KXWGcrWdcp2mDfdbIxuaH
	FVcbcZcT/fB235Jp2JLYdiquqSmeIChXvqJDZ5ZD/paRVFYFYcTOMxeLPm8zRpuz
	9bSjsdQILqE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 620DA6781;
	Fri, 18 Nov 2011 15:40:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC1FA677E; Fri, 18 Nov 2011
 15:40:30 -0500 (EST)
In-Reply-To: <20111118110938.GA5940@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 18 Nov 2011 06:09:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E632C40-1225-11E1-AB8C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185677>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 14, 2011 at 09:05:06PM -0500, Jeff King wrote:
>
>> Do you want to add your patch on top, or do you want me to re-roll with
>> this squashed in? I can also hold the re-roll until post-release if you
>> want.
>
> You mentioned squashing in the "what's cooking" message. Rather than
> squashing just the typechange bits, how about this re-roll, which I
> think is a little easier to follow:
>
>   [1/3]: read-cache: let refresh_cache_ent pass up changed flags
>   [2/3]: refresh_index: rename format variables
>   [3/3]: refresh_index: make porcelain output more specific

Looks sensible; thanks. Will replace.
