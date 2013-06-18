From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t5800-remote-testpy: skip all tests if not built
Date: Tue, 18 Jun 2013 13:28:56 -0700
Message-ID: <7vip1b40zb.fsf@alter.siamese.dyndns.org>
References: <1371586006-16289-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:29:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2WZ-0004Rj-RM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156Ab3FRU3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:29:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55689 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932419Ab3FRU3C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:29:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABFE429AE3;
	Tue, 18 Jun 2013 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8tMrdqd85CdroBRvQxOJLSR0JYk=; b=B2rU3v
	T0I43MLg5E/Pvd/wRBzitkZYgDsXSjH6GWucfR0R4pH+RyJbbhUrwMsyduv2TdZE
	wiF6XoRAKSvkcNxfQuYy1AQMHT5R+Dcvi0NFACdd/YFuyJvcf9HNKkPEkVFzdOCN
	A9fxMJdzaPflSeO1BH2ORGBj7XyiCwL4o91kY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a7NntvWjcEbTGq364DTbaFMgIgwp4+wg
	UN9pn0AN+jxSlxlTu8dwIv8V+DtQWxQ/CRkwPEqzBOWAAbMiyjhGVw8BqTqnMQ9r
	U3XUfoI2tV9M/FeQqbFNhQ3x61beJ01q5pWlJ1HzNGQ5p634ioj9pA5uc8+RghZI
	By8WPKdCHTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FCD629AE2;
	Tue, 18 Jun 2013 20:28:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21AAF29AE0;
	Tue, 18 Jun 2013 20:28:58 +0000 (UTC)
In-Reply-To: <1371586006-16289-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 01:36:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B430F6DA-D855-11E2-A79F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228310>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> What this means is that git-remote-testpy is not built by default (when
> 'make' is invoked), but t5800 runs by default (like every other test in
> t/).  As a result, a new contributor cloning git.git and running 'make
> test' for the first time will notice test failures.

Sounds like making "make test" build it is a more correct approach,
at least to me.  What am I missing?
