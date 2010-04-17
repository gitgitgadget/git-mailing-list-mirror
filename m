From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: use current date in mbox 'From COMMIT
 DATE' header line
Date: Sat, 17 Apr 2010 11:16:37 -0700
Message-ID: <7v1vee0wsa.fsf@alter.siamese.dyndns.org>
References: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
 <20100415151619.GK12365@arachsys.com>
 <201004151735.31415.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 17 20:16:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3CZa-0002Cz-0F
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 20:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab0DQSQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 14:16:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0DQSQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 14:16:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2351ABA65;
	Sat, 17 Apr 2010 14:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g2cCbBsgfCE1WPxYX50gc1EScf0=; b=LiuP1U
	EN5eA6FBzT+NBmdxWe2U60wS9XylIqw6HTXB69cSYPRzUCWEPehYWfwvr9mux6rn
	e+v3WkqVIsQTkNyOULIJSdJEwNC0Csb8XVcJ240lN7bv3aevGNcxpFpyNIMsZTtj
	EJpVkSKFtgKCvU7rZLCauYtM6MGjTvdl7ytWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WViaaT8PCjf+EoOiqXFGifof3jCNXFiC
	oS2pro0yDvEV9ftJZdG3GRmjP9pApD41HVpDPNhmcMPGWnrpa5T53J0nuEvJoTnT
	UhuG0c0KYIVZUFePHzn2bPHXsHAi+P5wJbYQvGH0lt2MrUhi6mf9B5VANj4kmIwJ
	DQZN4fxwrD0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79BCDABA63;
	Sat, 17 Apr 2010 14:16:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 732BFABA62; Sat, 17 Apr
 2010 14:16:39 -0400 (EDT)
In-Reply-To: <201004151735.31415.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 15 Apr 2010 17\:35\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6066F110-4A4D-11DF-8576-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145167>

Thomas Rast <trast@student.ethz.ch> writes:

> Chris Webb wrote:
>> Chris Webb <chris@arachsys.com> writes:
>> 
>> > Put the current date in the 'From COMMIT DATE' header line instead of using
>> > the fixed date 'Mon Sep 17 00:00:00 2001'. A DATE_UTC mode for show_date() is
>> > introduced so we can easily generate this line in the correct format.
>> 
>> ...but this will break t4013-diff-various which expects the exact date
>> string 'Mon Sep 17 00:00:00 2001' in the mbox header. Patch to fix this test
>> to follow!
>
> Have you read
>
>   http://thread.gmane.org/gmane.comp.version-control.git/124082/focus=124092

Thanks for a sanity.
