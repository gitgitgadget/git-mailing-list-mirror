From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 16/48] refs.c: add an err argument to delete_ref_loose
Date: Mon, 16 Jun 2014 17:22:10 -0700
Message-ID: <xmqqd2e8o05p.fsf@gitster.dls.corp.google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
	<1402941859-29354-17-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:22:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwhAK-0003dh-VO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 02:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaFQAWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 20:22:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61144 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbaFQAWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 20:22:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F31A020E6E;
	Mon, 16 Jun 2014 20:22:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4/lTxmDrY9eg1vvvzrnxU7GtdfM=; b=NT0kMv
	UIpL99xSS/u6Ums7b5n6DiwVLksbyxmrOjBUflc7UxUJhlZjpKxLVXNCfng+519i
	IHnWzI33PKNIBqt0mm9ukld9zwVuPS0/rTaa4+u2iizE+cdIjDTjDvYZcUk5ybNT
	tqcCQXXo9frP4s6w33SwamiarD+Z7dxh1eJNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P3g1aVprMdK6BnQveqgS/OIJg2g5sKrG
	MidmRLy1MEU9TEYTsdyB+pUZFOjdwjRIWSVjHcBug7r3yWTDeK1RLW14WcATxDO0
	x7KMVR9qN7qNOO5WNUU4lQK4ee9/RWl11Q87LQNTXjczCSMO7Wgrt4VvARQBkAp7
	xO70Yex4oHM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9D0C20E6D;
	Mon, 16 Jun 2014 20:22:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CA51720E6A;
	Mon, 16 Jun 2014 20:22:09 -0400 (EDT)
In-Reply-To: <1402941859-29354-17-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 16 Jun 2014 11:03:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6BD7115C-F5B5-11E3-99AB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251838>

The series applies cleanly up to 25/48 or so to 'master', but this
step already breaks tests, at least t1400 but possibly others.

Please do not make me bisect X-<.

Thanks.
