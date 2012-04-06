From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/mingw.[ch]: Change return type of exec functions
 to int
Date: Thu, 05 Apr 2012 18:00:03 -0700
Message-ID: <7vbon54quk.fsf@alter.siamese.dyndns.org>
References: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
 <20120405181600.GA6340@burratino>
 <20120405220615.GA11751@sigill.intra.peff.net>
 <20120405223408.GA13910@burratino>
 <20120406002454.GB14224@sigill.intra.peff.net>
 <20120406004226.GA2658@burratino>
 <20120406004449.GA15125@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxXJ-0005gR-4m
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 03:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548Ab2DFBAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 21:00:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab2DFBAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 21:00:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 116E76448;
	Thu,  5 Apr 2012 21:00:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lEGMxQaotimPDL1YjH/W6ZDQsjY=; b=r401o+
	4QxGmO02IFo7lSH1L1OCnYy6cPQUZqDT2qI0blNot5WfhPBISrL8UTRiauJxmhJG
	l4mXXbn+8BvdaiGpG1qmnIVmxWbHtMyeU26ZxthDsaR1RnJ+YGZLrCIZcpzpdXCa
	IGzy2Fm8y+iwF4PdTwtUcZ0AJP9WYYEIKsxCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lqDE39vGzvW3bGvMroN53YbwBWL+hPaj
	axtcfaGPPc7Bly0YF0NLMnhrPKYzYadDQS9n/9pF1gjhfcacngtAYi9oaDCeRz4+
	QjxMF0TQO1/h1xCQcQLTjJkOVwzecZmDodBnwpRIQqIKIbcKYRsajws0JRRTl62/
	ysGd/YfYiCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2C786447;
	Thu,  5 Apr 2012 21:00:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E1C26439; Thu,  5 Apr 2012
 21:00:05 -0400 (EDT)
In-Reply-To: <20120406004449.GA15125@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 5 Apr 2012 20:44:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D94905BA-7F83-11E1-BAD9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194829>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 05, 2012 at 07:42:26PM -0500, Jonathan Nieder wrote:
>
>> >  	/*
>> > +	 * If we are still running, we know an error occurred; let's try to
>> > +	 * diagnose it more specifically.
>> > +	 *
>> >  	 * When a command can't be found because one of the directories
>> 
>> Looks fine to me. :)
>
> Thanks. Junio, do you mind squashing this onto the tip of
> jk/run-command-eaccess? Patch repeated below for your convenience.

Thanks. I've pushed out today's round already, so maybe later.
