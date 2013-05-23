From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push not resolving commit-ish?
Date: Thu, 23 May 2013 11:05:00 -0700
Message-ID: <7v8v35fu7n.fsf@alter.siamese.dyndns.org>
References: <20130523105310.GA17361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 20:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZt1-0004uh-K6
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 20:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758722Ab3EWSFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 14:05:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757048Ab3EWSFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 14:05:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2C86213EB;
	Thu, 23 May 2013 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDNLSpd2t/e0bSU93sv694NP0HU=; b=nrl1RB
	oEW89EOUt7f3hlyQHc4PB+tDnq7Zz6AnYG6SnHbYwnxcmgrlsSL9C4XsIWboqzi0
	BnZs5zgsLE1G5uZynkZ7Ux9qH7Fk2mgqJNsIzJQVitS68aX3l+dJ1rkLZ2UTrJLw
	XnEctBkeD0Xi05yCsy0vFnth29gx4JI1oIr8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=waULPObLwt7JKMQ0F2EY7NeKcStFHgC2
	aM/IXxLU0+OU9iQvcvJfdyN2wj2XoOwx919+BbpB42dCL2aZJAX+LC1RiEkA5u2U
	HaByEniyCjF0Gv/FRbSsCR1/3o19zqFKUYwEGVS6GlXTXtsjF8EV1mk7J5uIBLIe
	taXe5N682JI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5F97213EA;
	Thu, 23 May 2013 18:05:02 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10402213E6;
	Thu, 23 May 2013 18:05:01 +0000 (UTC)
In-Reply-To: <20130523105310.GA17361@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 23 May 2013 13:53:10 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49F3D1AC-C3D3-11E2-8B50-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225277>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Looks like push can't resolve tags to commits.
> Why is that?

How else would you push a tag out?
