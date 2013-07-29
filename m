From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Mon, 29 Jul 2013 10:29:51 -0700
Message-ID: <7vwqo91dgw.fsf@alter.siamese.dyndns.org>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
	<7v8v0p2z45.fsf@alter.siamese.dyndns.org>
	<CALkWK0=dGmMkgvaNV27E3Pb3+SWSZ2pNMOr-wsEcUR_wgLjMFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rGh-0001dR-5r
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab3G2R3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab3G2R3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:29:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86AAE34A48;
	Mon, 29 Jul 2013 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7qHkGG1YJo7FqtL1HvEoe90MdfE=; b=fnmY0X
	ALLykeLnhsaemPSMNUvYGWBMmo68wt+Knff/fRzVij4jQjAmxsTSpSK9yisacEmI
	6vwJ4GJlC3NrhYmrgdgWWUN1Jw7BXwtIfLuj8jofAmM2jMbKWpCD5gyFHiDEJxNI
	KPyQlxB0BNoESzaJKF01ZondAxnaUouKL8yTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXNxjzag3zMpkV2B4AJVJXoDO16ZDtV7
	6YPpCtkufhK/uG78DBOVHLaSLxNalKy/kFzdSz0jphd4NXx76OkIp3u8RRIogv/x
	xPv1+ePXAZLbtYVDX0+LTKh8RZMFeK1pds2JZtfOoXVxvZnan47FhvrXH9r0KIXz
	5COG1wtCAZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AABA34A47;
	Mon, 29 Jul 2013 17:29:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D686134A46;
	Mon, 29 Jul 2013 17:29:52 +0000 (UTC)
In-Reply-To: <CALkWK0=dGmMkgvaNV27E3Pb3+SWSZ2pNMOr-wsEcUR_wgLjMFA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Jul 2013 21:37:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A7451A0-F874-11E2-9B9D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231303>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> That's a bit strange---the patch text looks like the "how about
>> this" patch Duy posted earlier.  Shouldn't it be From: Duy with
>> S-o-b: by two of you instead?
>
> Feel free to amend as you see fit, as always.

I was asking what is "correct", without which I cannot "feel free"
to do anything, and your answer is not helping.
