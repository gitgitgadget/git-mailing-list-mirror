From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] gitweb: Improve handling of configuration files
Date: Wed, 25 May 2011 12:34:25 -0700
Message-ID: <7vr57m377i.fsf@alter.siamese.dyndns.org>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
 <4DDD4CC1.3070103@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 21:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJqv-0005Ul-HA
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab1EYTek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:34:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab1EYTej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:34:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFE925B76;
	Wed, 25 May 2011 15:36:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hhP6vAdLsyBEEjGOK0g9xIbQvhU=; b=K4o4iE
	93iBEFjBj08Tz6X5oAG3NZEcuVDIL+G+6xCB71DygpjGGIWpN33JbW/2+YmbCJbm
	QXYOveyas1+lQb5c0exb2A3t56OAsqNiBqEf6vk/uTeEuYggAvsL7BoZYCzJTkDO
	lLJH2s9BQwMDBa7syBULs/uFwK/za5Y3E16Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKe6l/MVQpzwywnPS7mUGK2mm45IfnZ6
	qXXLLxArkjosJt4vH6wft/jhUWZ5KOdj5ZP43J4Bd4LqvcA8/2T6m48bD3OmMm6Z
	tYLaG5Y+YmgARhyUHOJAAfvbgVXYtNZoYkZAFO+ViicJnnxXuEhpFJidpSZzuTby
	nZ/Nrni7YCs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E1045B6A;
	Wed, 25 May 2011 15:36:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 197225B50; Wed, 25 May 2011
 15:36:34 -0400 (EDT)
In-Reply-To: <4DDD4CC1.3070103@kernel.org> (J. H.'s message of "Wed, 25 May
 2011 11:38:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50C2B81A-8706-11E0-8906-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174451>

"J.H." <warthog9@kernel.org> writes:

> I would argue against this, for a couple of reasons:
>
> 1) Git itself treats /etc/git.conf in this exact manor,...
> Case in point turning on things like updateserverinfo, or automatic packing.

If we read both from the beginning of time it would have been more
convenient, and I agree with that 100%. So this is not a valid reason to
"argue against this".

> 2) Trying to get people to do includes in their config files, or to
> completely ignore the system wide config isn't a sustainable practice.

I also agree with this.

In any case, I do not think we have to choose between Jakub's two patches.
