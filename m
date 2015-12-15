From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 15:34:34 -0800
Message-ID: <xmqqfuz3ffqt.fsf@gitster.mtv.corp.google.com>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
	<20151215233207.GA30294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Doug Kelly <dougk.ff7@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 00:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8z7C-0006sA-09
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 00:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbbLOXei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 18:34:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932286AbbLOXeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 18:34:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84D613377B;
	Tue, 15 Dec 2015 18:34:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qgTTD4lwgX9aWcbFTm/khmr/0vE=; b=JFutiG
	IT0KbxZvu/f4892CUDxiWTMESR4UBvIW1166oWg8N33awiYHDwHyA6B6ZfhgJqR5
	dfPkbK4AJF3k+XcABgXybADaBfCPpVA65T4KFvGmx8Al7M60sSqpSSwU+yL031ZA
	UHEocmlj0aGT/lWRHlmGw+yLzeRJf+qDFrC94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/LNQS5kgQ15QGYBnkGCKUumQy6yb1gX
	4ipuOjNg8cMzs3POCW6OHG+zNttj1mAEzSGC00Xx8Eb2bmxbg7WE1tDPtL2QRC0b
	Q0lBVwMErofHEaiXXHLtebs2PgmdjQV3qt3++vpUbFdtX7uwfhjtG07+ARcfC8vD
	ush47u5aaw8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FD9C33779;
	Tue, 15 Dec 2015 18:34:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5BF933777;
	Tue, 15 Dec 2015 18:34:35 -0500 (EST)
In-Reply-To: <20151215233207.GA30294@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Dec 2015 18:32:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66C02E14-A384-11E5-98E9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282510>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 15, 2015 at 02:48:42PM -0800, Junio C Hamano wrote:
>
>> * dk/gc-more-wo-pack (2015-11-24) 3 commits
>>  - gc: Clean garbage .bitmap files from pack dir
>>  - t5304: Add test for .bitmap garbage files
>>  - prepare_packed_git(): find more garbage
>> 
>>  Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
>>  .bitmap and .keep files.
>> 
>>  Waiting for review.
>
> I just read through and made some comments.
>
> Note that I think there was a re-roll of the first patch after I picked
> up the original:
>
>   http://article.gmane.org/gmane.comp.version-control.git/281759
>
> Hopefully Doug will re-post the whole series after taking a look at my
> comments.

Thanks.
