From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Sat, 07 Apr 2012 21:43:43 -0700
Message-ID: <7viphaygsg.fsf@alter.siamese.dyndns.org>
References: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 06:44:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGjzC-00071r-82
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 06:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab2DHEnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 00:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2DHEnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 00:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B15D7816;
	Sun,  8 Apr 2012 00:43:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DVfs9EaNi1x0h6RIDWpmlHAXf8U=; b=ROINow
	jNB5zUev6lBaOrnkvIIKfjSG9P7WJSsVFhNotS9Lah7mC+UooESL8Xt6Fphefk1i
	Be1CCJNohmXL0BtKOos9t1AdSz7H19s8N/PLAIB7YVlb/GBzvgEHn0obpEJkT/2W
	pkR0MgKub4ZsbzFnS/Yrm8btOidftwpivW3+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hjTOt/cyfBQujRk9YvJqpO6kcdak3RPj
	366FCW9PVtUvTKVPXV49mdTBrgQA3cyXd3GuSV8wIO1vrnLQTHzjtBbxFzoAhIH8
	/KFXjeOVown5FHnaXDNBmalwTXFpZGJRY+miYIDiMI0qdWdPbkLnFjF9+7EBPPp0
	ahRQXL979QI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1254D7815;
	Sun,  8 Apr 2012 00:43:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A29EA7814; Sun,  8 Apr 2012
 00:43:44 -0400 (EDT)
In-Reply-To: <20120407075150.GA18168@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 7 Apr 2012 03:51:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C3962E0-8135-11E1-B546-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194974>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 07, 2012 at 09:49:47AM +0200, Michael Haggerty wrote:
> ...
>> If "push.default" is not set, then have it default to "beginner" mode.
>
> I would be fine with that (I've suggested it elsewhere in the thread,
> though I think I stole the idea originally from you. Speaking of going
> in circles. :) ).

This makes the first priority for 1.7.10 cycle to come up with a solid
implementation of the "beginner" mode, I guess.
