From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 15:49:44 -0800
Message-ID: <7vd2wkewvb.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <7vy5f9dmrt.fsf@alter.siamese.dyndns.org>
 <20130131222817.GP1342@serenity.lan>
 <7vtxpxdldj.fsf@alter.siamese.dyndns.org>
 <20130131225620.GQ1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Feb 01 00:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U13tS-0004KR-Qb
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 00:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab3AaXtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 18:49:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3AaXts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 18:49:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95DC0BE3D;
	Thu, 31 Jan 2013 18:49:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fpTUtDE2f/53oppNQcD7q7OmT/c=; b=rBnjSJ
	zicYJAQUS0fPIhu78O4jMqGaNlyke5h977/hQZIaW8SCjvl4oSN6NiNzUoGlMBrs
	1OlVy1IulmemFd3GuGfZ7ez0ne2d8eorBm6faNdqwd7QVZEqxvQhELX+JC9to8Me
	rGXfbnFtoDOC9fAcbdHNpHID2kxtg3GNCOpXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gN1nnDJoSbcOVoQZ7uyeGsTooehfUus9
	pCARP8xykMC4+d7lKhuDYYpOjGf2vRb7GUyG3QoF29tyYNmv8LTFxJCn8f5UpBq/
	GmrL68zP2dq+nzngBBJ8g3kMGq0zICOEU+FhgOCQagjQhvQrZeZcPOPLKt+XxNrs
	92cut5/6v4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A92BE3C;
	Thu, 31 Jan 2013 18:49:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0609FBE36; Thu, 31 Jan 2013
 18:49:46 -0500 (EST)
In-Reply-To: <20130131225620.GQ1342@serenity.lan> (John Keeping's message of
 "Thu, 31 Jan 2013 22:56:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4E1CEEC-6C00-11E2-A597-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215189>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Jan 31, 2013 at 02:43:20PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > Yes.  Should I change it to "git-remote-helpers.html.in" and then copy
>> > it into place?  That seems like the simplest answer and means that
>> > "*.html" will continue to refer only to generated files.
>> 
>> I'd like to see if we can have a way to keep its look as the default
>> css gets updated without maintainance burden.
>> 
>> How about using AsciiDoc instead of "cp", perhaps like this on top
>> of your patch?
>
> I tried AsciiDoc first but didn't like the output.  I think putting "See
> gitremote-helpers" in the synopsis is the magic I was missing.  This
> looks good to me.

Actually I didn't mean "take this patch, it works".  I've queued a
slightly different version and will push it out as part of 'pu'
later.

Thanks.
