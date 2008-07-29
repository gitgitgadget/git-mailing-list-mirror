From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make it clear that push can take multiple refspecs
Date: Tue, 29 Jul 2008 16:20:00 -0700
Message-ID: <7vwsj49t27.fsf@gitster.siamese.dyndns.org>
References: <1217362159-25440-1-git-send-email-ams@toroid.org>
 <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org>
 <20080729212808.GA27076@toroid.org>
 <7viquobb0e.fsf@gitster.siamese.dyndns.org>
 <20080729231338.GA30717@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyVF-0000Qc-Jn
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYG2XUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYG2XUL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:20:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYG2XUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:20:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8969341E6F;
	Tue, 29 Jul 2008 19:20:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 62AE441E6E; Tue, 29 Jul 2008 19:20:03 -0400 (EDT)
In-Reply-To: <20080729231338.GA30717@toroid.org> (Abhijit Menon-Sen's message
 of "Wed, 30 Jul 2008 04:43:38 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E147AAEE-5DC4-11DD-BFB5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90708>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-07-29 15:06:57 -0700, gitster@pobox.com wrote:
>>
>> If you saw the question asked many times in the real world, that
>> would be a good indication that this patch falls into the "helpful"
>> category, not "noise". Will queue.
>
> Thanks.
>
> You may find the appended patch less noisy still. I certainly like being
> able to get rid of the "any number of..." sentence; and I also think the
> example is clearer, though I merged it into an existing one.
> ...
> -<refspec>::
> -	The canonical format of a <refspec> parameter is
> +<refspec>...::
> +	The canonical format of each <refspec> parameter is
>  	`+?<src>:<dst>`; that is, an optional plus `+`, followed

After re-reading this, prompted by your comment about "both synopsis
syntax and regex in the same sentence, I actually do not see a problem
with the original one.  The synopsis talks about the ability for you to
specify zero or more of whatever is called <refspec>, and here we define
what _A_ refspec is.

Somehow I thought the issue was that we said "<refspec>...::" in the
heading of the description without saying zero-or-more, but that is not
the case here.
