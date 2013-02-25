From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 25 Feb 2013 09:44:00 -0800
Message-ID: <7vd2voz3tr.fsf@alter.siamese.dyndns.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <453931856.Va6j4WpQCl@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Barr <b@rr-dav.id.au>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 18:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA26O-0003mB-7X
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 18:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843Ab3BYRoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 12:44:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758842Ab3BYRoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 12:44:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C37F4A0AA;
	Mon, 25 Feb 2013 12:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i7wD9W/2AJZdGAUPNSD994DoVOc=; b=fGqheX
	JrkFiDRVb8bCUYU2a7TbcMQppW/+4pcvpCGHwUSfyRhSmVBjUh0m7hbrWXXtS48L
	2wMyZfHVGiVviNR8Ft9B8V102JCozSM/7EJn+7oeRsYc8kCU+3UeTKoFtrrRuplz
	F1y3J6k94wFw244YJr+CDTH4Ov8TJ0lATQz7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+7+aR7Mn7ZDjev/Z4fmC+988jZa402/
	8D1uCLUH6g2crvFpymEo/bSpgOMjkfw0d5MQlQdy42izSpVUEAykh2chXNGtPedd
	j2W99x9hXIJSnUMdcFlfDJSDMUWFr5jefPHQgLhG7hYwni0tPcKmob1JcnbH4qsr
	qmyl+fpyV3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20518A0A8;
	Mon, 25 Feb 2013 12:44:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11AE8A0A3; Mon, 25 Feb 2013
 12:44:01 -0500 (EST)
In-Reply-To: <453931856.Va6j4WpQCl@flomedio> (Florian Achleitner's message of
 "Mon, 25 Feb 2013 10:12:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1001E2E-7F72-11E2-B2F2-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217068>

Florian Achleitner <florian.achleitner2.6.31@gmail.com> writes:

> For a student one aspect of  GSOC is also quite important: It is a cool and 
> demanding summer job during the holidays, but it has to ramp down when the new 
> semester starts.

Thanks for sharing.

I think an important lesson is that mentors and reviewers need to
think really hard to limit the initial scope of the assignment to be
not too ambitious.  Starting with an ambitious goal and achieving
only small first steps of them _can_ still be a good end result, but
if a mentor wants to go that route, the decision to cut down the
scope of an ambitous assignment needs to be made early enough to
leave sufficient time to wrap up the half-done assignment in a good
shape. Finishing with implementation of only the initial 30% of an
unproven design, that by itself is not useful, does not help our
project at all, and it does not give satisfaction to the student,
either.
