From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
 number links
Date: Mon, 26 Sep 2011 14:14:19 -0700
Message-ID: <7vipof0zx0.fsf@alter.siamese.dyndns.org>
References: <1317060642-25488-1-git-send-email-peter@stuge.se>
 <7v62kf2jf4.fsf@alter.siamese.dyndns.org>
 <20110926194639.25339.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:14:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8IVO-0006PB-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab1IZVOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:14:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1IZVOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:14:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 244354A0D;
	Mon, 26 Sep 2011 17:14:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j80e0PDcNwTCyATBuuGNNUAJCO8=; b=MK/Ate
	eqtMdJVSwcF06s4OkTPt0R6udQbarsWYiEzSlBhvJx+CvXLpIRwhIaNvboFIaJEG
	CtacXHqOe524Sce9l37cBkdLrTG1kHmUqaPEOpLpzMlN5S56XlYbKaD/bo5pnlYf
	d2Pc+PPcqBITUsRA/GxzKnr//6AmgcTNRxOv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a+yd9Q9n2LbRc4GFD0DVc8RCQWc22NPi
	XFBS7pIoikp8s0+NoLhDW3V4bJug334BDqzv/bse/+21mmwCRHSP4Q4Ul8U8J0aH
	BrOz8AVc9blT/mGhV8WXZz3jzCk/t73nYRMEr0yMHcaDl8rjIemHTqGjlw3ah4xG
	5uo7qWtkEQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CB6A4A0C;
	Mon, 26 Sep 2011 17:14:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA4D74A0A; Mon, 26 Sep 2011
 17:14:20 -0400 (EDT)
In-Reply-To: <20110926194639.25339.qmail@stuge.se> (Peter Stuge's message of
 "Mon, 26 Sep 2011 21:46:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 804EAC26-E884-11E0-BEBA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182165>

Peter Stuge <peter@stuge.se> writes:

> Okey. I thought subject together with change would be clear enough. :)
>
>
>> Explanation of what you are fixing is totally lacking.
>
> The subject sums it up, if briefly.

... Sorry, that is not what I meant.

You don't have to explain these to *me* specifically as a response to this
thread. What I meant was that your patch should have these necessary
descriptions in its proposed commit log message.
