From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #10; Mon, 29)
Date: Sat, 04 May 2013 12:27:39 -0700
Message-ID: <7vhaiiwno4.fsf@alter.siamese.dyndns.org>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
	<87y5bvyw7j.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 04 21:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYi7W-0006MI-3u
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 21:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab3EDT1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 15:27:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab3EDT1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 15:27:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 496C81B049;
	Sat,  4 May 2013 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dDc91pqC9zqDrEto5nwB87qN/jE=; b=F+kXTa
	UlqHwW2nOmJlUJ728KeIwcZ1OWolsiwag79aSPbUAXSibZM9D0FDJZCWzFtBZ1uN
	ZqDoJrZaW4XzwgLM2m6EMgFIXs5vAydHBfFiqHlzVh61q9R9ILuoXkltueCVms6E
	xvbQqoyftwxqV/mBENhe8HhCyaI9zfXUiuIio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iai2dUQuVSTSPX9lFBIITweQ+7HtmBYT
	7JaIibewzMIJWdwDUwAqMeAIG0XvKSZFtqhrjtnECsPxn6IMiilu4MO0Q3zdmHoo
	5UUQ28ky8RoAePAaPNRL5m8Pa+uJjeEVEKGecU0RlFOFS4fJt93t0rZIEM1CU3ut
	hAHRtgb4V0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD551B048;
	Sat,  4 May 2013 19:27:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5B621B047;
	Sat,  4 May 2013 19:27:40 +0000 (UTC)
In-Reply-To: <87y5bvyw7j.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Sat, 4 May 2013 10:40:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFB4AE2C-B4F0-11E2-91C1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223373>

Thomas Rast <trast@inf.ethz.ch> writes:

> So for one thing, "ha ha we told you so" is not an extremely
> satisfactory answer, especially since we only "told them so" with the
> recent doc update.  Wouldn't a stern warning or even an early error be
> better?  

Sorry, I am not sure exactly what alternative you have in mind here
by "a stern warning / an early error".

> It could be tempered by checking that HOME agrees with what
> getpwnam says should be the HOME of the existing user, and checking that
> it is not readable, before warning; more experienced users like the
> scenario you mention in
>
>   http://thread.gmane.org/gmane.comp.version-control.git/220661/focus=220921
>
> would make sure that at least one of those conditions is not true.

Perhaps.

An update to change the rule easier to explain and the messages
easier to understand to help inexperienced users in the right
direction would be good.
