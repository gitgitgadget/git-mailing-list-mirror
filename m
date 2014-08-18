From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send: simplify tunnel construction
Date: Mon, 18 Aug 2014 10:00:15 -0700
Message-ID: <xmqq1tsdybq8.fsf@gitster.dls.corp.google.com>
References: <53EBA0C3.2040805@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Mon Aug 18 19:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQIZ-00068U-9X
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 19:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbaHRRAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 13:00:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59685 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbaHRRAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 13:00:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20B893068B;
	Mon, 18 Aug 2014 13:00:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rvj7shVjNDn0ITIZeZMt3Dl7Kco=; b=n7wyZK
	KEi/9QoU0wUJVoQH2PlVGugIqkI1fF7qZaCCmvXuhvLHGaaFrJKXOGbbNlLsWyIK
	4MrCUm7V0DYMj3pRWurmlIZ8f4Zj/i0xmiM7uk1VslVqXKXcNRzt7aSjQY9fzN4B
	dsq1PBuBDib1iN7vJw25LSW460uG68eiGFT00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fQ6IVPaRJMRfmwRd6h6UkjI34Az5hX4v
	aoEUXxh1bSb9FH8cin2bu1BNpI9miWRPjHlXkTfz7x1kM4EDdJxJFPc2WjGSQVcZ
	XVIBMeOWmIxZ40ATRdYog7L7j5UbkphvR3ViCtgwITHn+w0Q2r5EZqZ+104/8cRy
	x2IVTua5szA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 180183068A;
	Mon, 18 Aug 2014 13:00:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 745EF30648;
	Mon, 18 Aug 2014 13:00:17 -0400 (EDT)
In-Reply-To: <53EBA0C3.2040805@raz.or.at> (Bernhard Reiter's message of "Wed,
	13 Aug 2014 19:30:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21454094-26F9-11E4-8EDA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255401>

Bernhard Reiter <ockham@raz.or.at> writes:

> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---
>  imap-send.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Oy.  Where is the patch?

Please avoid multipart/mixed on this list.

Thanks.
