From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Tue, 15 Feb 2011 22:35:20 -0800
Message-ID: <7vd3mslc5z.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102151606.21040.johan@herland.net>
 <7vipwlp3yv.fsf@alter.siamese.dyndns.org>
 <201102160154.24744.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 07:36:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppb0E-0006Hc-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 07:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab1BPGfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 01:35:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab1BPGfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 01:35:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E5EB488F;
	Wed, 16 Feb 2011 01:36:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tVJfiLKGXjt/PQ/xe2NjkPdi1ZQ=; b=Ncht21
	RIXAtzhyoS/WI39/RBLxMkBi7VZzo/7k0tk/mj6Sows82blcAv54fL6X0OupOWUB
	rG0SbqmY6/E8heqTzXzwyOIenUXdyOg11gPCFMKDfzCk5w+ZMqIykmxWgJND+MxO
	z5yBENRmlyOKqS57koVxier89xlkWgOut51ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EeRKfPx0YYtsEsaWJM95IBtEKzvN6c10
	n+vkVbQdrpf1zv+/slWO4zZ2onHXJKNpi9HE5B6/hrTm3R9LTPJvWr5F9iXQAIkD
	UFC8nr/ZJ+OeblNYr9v/gL5kFoz41o6lr5BirSQc9+N2W0NJkAQpYf+39g1/Mo3p
	s26PRWPnqg4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F27BD488B;
	Wed, 16 Feb 2011 01:36:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A8FFA488A; Wed, 16 Feb 2011
 01:36:27 -0500 (EST)
In-Reply-To: <201102160154.24744.johan@herland.net> (Johan Herland's message
 of "Wed\, 16 Feb 2011 01\:54\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BBF9A6E-3997-11E0-AD3F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166925>

Johan Herland <johan@herland.net> writes:

> I took the liberty of renaming the setup_push_tracking() function as
> well, and rephrasing its error messages. Although this may be
> considered code churn, I think it's worth keeping the function naming
> closer to the phrasing in the documentation.

I don't have any problem with that kind of internal naming clean-up,
especially when there is no other change in flight that would interfere or
cause conflict with it.

Will hold for a few days to see if we see any reasonable objection, and
then queue if not.  Thanks.
