From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add test case for rebase of empty commit
Date: Tue, 03 Jul 2012 14:13:57 -0700
Message-ID: <7vpq8ctune.fsf@alter.siamese.dyndns.org>
References: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vr4t079jp.fsf@alter.siamese.dyndns.org>
 <20120703182000.GB10864@hmsreliant.think-freely.org>
 <7vtxxovfec.fsf@alter.siamese.dyndns.org>
 <20120703203136.GC10864@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 23:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAQB-00072W-TE
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab2GCVOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:14:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266Ab2GCVOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:14:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56FD59FE9;
	Tue,  3 Jul 2012 17:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U3tjbXx/eTJER8jYuzv/DUbJQbA=; b=GTzQdo
	mTA9psHCza55Y8ani1I+PjwDD6bkoQ5WOCNjqr3siQRYy+8A8sN2l6MBB+MXfQxQ
	8ZAbiIDJWMxo5H0rKM+GVl+2VUOPmKEEtu2nOZIQyAbZK587+5F7sVzkuhXE7sLx
	ePolagYULH50xSfgX/P+E3pjTq4jsDfgRuxdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ETTh1zvGQJ73FFxFUYrOAY0kTju8DbpU
	2hh7L7vRVWdlBuplWa2NNTEZq6yzf6QvEXVhJhuoVDIxRvySWZg5w8q3S35JzSw1
	/zq0rbdIwPloGb3BPNSFaWuoQty9z1dKFJcZWVlWuthQJCQNhixqrpS7Hh88iIbB
	bPxyu45+u1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F5F59FE8;
	Tue,  3 Jul 2012 17:13:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC0119FE6; Tue,  3 Jul 2012
 17:13:58 -0400 (EDT)
In-Reply-To: <20120703203136.GC10864@hmsreliant.think-freely.org> (Neil
 Horman's message of "Tue, 3 Jul 2012 16:31:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01649116-C554-11E1-97F4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200946>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Tue, Jul 03, 2012 at 12:00:27PM -0700, Junio C Hamano wrote:
>> 
>> The changelog might be similar or textually identical, but it is
>> entirely a different matter if it makes sense taken out of the
>> context (i.e. cherry-picked).  So I would personally do not bother
>> "filtering" about them too much---if you ask for empties, you will
>> get all empties.
>> 
> Ok, copy that.

That was somewhat unexpected, though ;-) It was 30% tongue-in-cheek
comment.  People who want to keep the empty commits in the history
may want some filtering. As I am not among them, I do not think of
anything useful (other than "filter all empty ones away", that is).
