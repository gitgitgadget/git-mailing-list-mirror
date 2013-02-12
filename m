From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] unify appending of sob
Date: Tue, 12 Feb 2013 12:45:08 -0800
Message-ID: <7vehglfei3.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <20130212201613.GC12240@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Mk0-0006s2-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758945Ab3BLUpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:45:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756451Ab3BLUpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:45:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A81C38A;
	Tue, 12 Feb 2013 15:45:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nBuobbU6/A7JqQahdW00JeevyXI=; b=c2GAjk
	IhqqmFOzfOteZ8yCzAOoCegjKkx74oeyNTxwb05bianqXvyzTM56J7z9HbehZbhn
	vdtfa6/L9BGMPsqEgI8/sPCSMr5t2yJsGOuONaJL1BtUQ7aJMLI0r34dzq0AvJkW
	x1W/2m0IGOLmqpnnhlpQrnI3pvAoeyW5sCMyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H+9qobdPIjzDgGBJ2/1FS1IyPxnIN8qq
	8DhPgF2TSCuCGdNQsOv/GjY5YIp7aN5rlR8N9zsCfcoVeO86kBEUwpDhXpBuS9B6
	RwVhHoI9tTpVyXX0ujOC7Td7dbtc/yMQiZaLrjH8PxYrX1HIyqBMuRrbw3gx2GNm
	fDVoQ6qm148=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF110C389;
	Tue, 12 Feb 2013 15:45:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31EC7C386; Tue, 12 Feb 2013
 15:45:10 -0500 (EST)
In-Reply-To: <20130212201613.GC12240@google.com> (Jonathan Nieder's message
 of "Tue, 12 Feb 2013 12:16:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1789F13C-7555-11E2-AED9-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216193>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Casey wrote:
>
>> Round 4.
>
> Yay.  I think this is cooked now and a good foundation for later
> changes on top.
>
> For what it's worth, with or without the two tweaks Junio suggested
> (simplifying "(cherry picked from" detection, deferring introduction
> of no_dup_sob variable until it is used),
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yeah, I am inclined to merge this to 'next' without any tweak, and
let it cook and get polished incrementally.  I am not sure if we
have enough time to graduate it to 'master' for the upcoming
release, though.

Thanks.
