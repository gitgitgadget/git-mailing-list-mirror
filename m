From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 17:10:25 -0700
Message-ID: <7vabffcf4e.fsf@gitster.siamese.dyndns.org>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
 <1218752308-3173-2-git-send-email-marcus@griep.us>
 <1218752308-3173-3-git-send-email-marcus@griep.us>
 <1218752308-3173-4-git-send-email-marcus@griep.us>
 <20080814223740.GD10544@machine.or.cz> <48A4C521.6090507@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmuq-0006BT-Tm
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYHOAKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYHOAKi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:10:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYHOAKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:10:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D1F0F5D41E;
	Thu, 14 Aug 2008 20:10:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 26C235D41D; Thu, 14 Aug 2008 20:10:32 -0400 (EDT)
In-Reply-To: <48A4C521.6090507@griep.us> (Marcus Griep's message of "Thu, 14
 Aug 2008 19:52:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9615EE72-6A5E-11DD-A548-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92446>

Marcus Griep <marcus@griep.us> writes:

> Petr Baudis wrote:
>>> +-H::
>> 
>> Can you guess what would I bug you about? ;-)
>
> If we get '-h', I'll submit another patch :-P

Wasn't the problem about documenting the addition of pack size, which is
not about this human-readable option?

>> If it's non-human-readable anyway, why are you dividing this by 1024? At
>> any rate, it is not obvious at all that the size-pack is not actually
>> size-pack but size-pack/1024. You should either add the (fixed) unit
>> string behind or name it size-pack-kb - or just not divide it at all?
>
> I divide by 1024 here because the loose object size is reported in KiB.
> The total that ends up in size_pack is in B, hence to be consistent, I
> report the pack size in KiB as well.

I thought this part was ok without room for dispute.
