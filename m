From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter
 configuration
Date: Sun, 07 Apr 2013 02:03:04 -0700
Message-ID: <7vmwta7lx3.fsf@alter.siamese.dyndns.org>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
 <1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
 <7v4nfi92q1.fsf@alter.siamese.dyndns.org>
 <CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 11:03:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlVI-0002NE-RE
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 11:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945Ab3DGJDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 05:03:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622Ab3DGJDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 05:03:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 647B4F9FA;
	Sun,  7 Apr 2013 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z0xq5rEGlFtEq/I4QQuk3PDaDgM=; b=VQX/1B
	7ZEGgEVzwMbx8I8Tjchyb3CPsWri1MTaQ8PrhqEaqHI6i9wZMrNZ8oP5sU/LMzp4
	vy2vPidIWkT0Ndj+v7bTiJbgQj3LeccmCGY5hbFJGXuqJpDJbVgRlYiTG13EhH7y
	XFwoxOGwR4wzin+4iNghw1dPRExTYe1NGyFW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=crVtrOPHE2eQghb6KjwEwR5FFgeILqRV
	aFwuCiWGeuQ7dqScd7ecwV+oC4txJDOT8WEk4gziTCkdgMfreitEd+/ei01S/Ov3
	CrfxhV8FUUJQSHbWhm6F+Fo6jIHEJJ2jkGHd44mbPK9OsHC4kMZDfe6KBAtXSxVq
	/IqcgGob3EA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 598AAF9F9;
	Sun,  7 Apr 2013 09:03:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE08BF9F7; Sun,  7 Apr 2013
 09:03:05 +0000 (UTC)
In-Reply-To: <CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com> (Felipe
 Contreras's message of "Sun, 7 Apr 2013 03:48:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5C5CBE8-9F61-11E2-B433-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220301>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Users know how to count, if the default is no cover-letter, then doing
> --cover-letter=auto is basically --cover-letter, unless they don't
> know how to count and thought --cover-letter=auto would do something.
> The same is true is they configured coverletter=true.

The user who says "format-patch origin" does not necessarily have to
count beforehand with "rev-list origin..", so "Users know how to
count" does not sound like a relevant and convincing argument to me.
