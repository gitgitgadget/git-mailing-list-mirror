From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v3] push: better error messages when push.default =
 tracking
Date: Wed, 02 Mar 2011 17:43:24 -0800
Message-ID: <7vbp1t9dxf.fsf@alter.siamese.dyndns.org>
References: <7vhbbmellx.fsf@alter.siamese.dyndns.org>
 <1299096731-14194-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Mar 03 02:43:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuxZr-00013b-Re
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 02:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab1CCBne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 20:43:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab1CCBnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 20:43:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5214F42F4;
	Wed,  2 Mar 2011 20:44:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mkIESBltfoT0I2iaMw9Mpuas2Qs=; b=JI7ii2
	OXT0SGhpKLFcIXxw2n1AZaDnU0hrt1v9/f6DuYyyCJ/t621cdn79TLTfGvoikL8X
	JPnc7Dk2LNFKwP50PEaCDOE2ic37RdcTCc7G80z5fN7qE5qs+TVjhyKZD4CgEeOw
	AH3bz7uBjLcZpgbftbi5EAn6/fAY6uAhKyoBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yo8W5yCqAsFIJD6X6VOWDEvwqdDgRuDk
	kC/epKWiKdco1ikipyHDIpTgv6XaFqPBBwOaBiyN9aEx7OW66IMEA3sZenOzwDkC
	HsrQ8w0TWDYHvnMryYXX08Js5q+zZDRfFh7DHlY7613qOLvs8Q1f13rIgjYFCZio
	bCqjU17sjvU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3004442F2;
	Wed,  2 Mar 2011 20:44:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4537A42DB; Wed,  2 Mar 2011
 20:44:48 -0500 (EST)
In-Reply-To: <1299096731-14194-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\,  2 Mar 2011 21\:12\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D47C6414-4537-11E0-A1F1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168365>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I applied Junio's suggestion to suggest pushing HEAD in detached HEAD
> state. I don't care very much either way indeed (and I didn't want to
> make the message too heavy, just give the user a way to do something).

If I were asked my honest opinion, I would have to say that I do not care
too deeply about it either, in the sense that I won't claim that the
workflow I thought was most likely to get a new user into the situation to
get the message on the detached HEAD would be really the most likely one,
but I wouldn't spend too much time on coming up with other scenarios
myself even though I admit that there may be some other cases that the
updated message is not optimal.

But one thing that I would value (and I would like to see others on the
list to also value) is that every change we make is backed by solid
thinking---at least I would like to see us being able to explain _why_ we
thought that the message after applying this is better than the old one
today.  Others who will wonder why the message advises the action it
advises three months down the road should be able to find out the thinking
behind the change, and decide to agree or disagree with it.  Without such
a trace of clear and solid thinking, i.e. "even though we admit we may not
have fully thought things through, at least we considered this and that
when we came up with this solution", we would end up going circles,
wasting everybody's time.

In any case, I've applied them and pushed the results out.  Thanks.
