From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in
 packs with a .keep file
Date: Wed, 12 Nov 2008 10:19:45 -0800
Message-ID: <7vy6zoolha.fsf@gitster.siamese.dyndns.org>
References: <20081103161202.GJ15463@spearce.org>
 <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <20081112080909.GA29176@coredump.intra.peff.net> <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <7v7i78q0go.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0KLm-00033e-6J
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYKLSUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYKLSUn
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:20:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYKLSUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 13:20:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C0EFA7C708;
	Wed, 12 Nov 2008 13:20:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF4407C6EF; Wed,
 12 Nov 2008 13:19:52 -0500 (EST)
In-Reply-To: <7v7i78q0go.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Nov 2008 10:10:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C078880-B0E6-11DD-913A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100799>

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> Jeff King wrote:
>>> On Mon, Nov 03, 2008 at 02:37:05PM -0600, Brandon Casey wrote:
>>> 
>>>> This version replaces the use of 'head -n -1' with a grep, and should work on
>>>> all platforms.
>>> 
>>> Hmm. I'm not sure what happened, but the version in 'next' has "head -n
>>> -1" in it.
>>
>> Well, there were so many revisions, I probably should have re-rolled the
>> whole series....
>> ...
>> if that's the way we want to go. I'm not partial to the phrase honor-pack-keep,
>> but I don't think ignore-pack-keep is appropriate, and it's the best I've come
>> up with.
>
> Ok, care to send in a series in incremental updates format, please?

Nah, nevermind.  I see you already sent a replacement series overriding what
is in 'next'.
