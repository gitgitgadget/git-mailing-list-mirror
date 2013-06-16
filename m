From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Write a good 'stash store' for autostash
Date: Sat, 15 Jun 2013 18:22:30 -0700
Message-ID: <7vtxkykfxl.fsf@alter.siamese.dyndns.org>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 03:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo1fx-0000Vz-Kz
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 03:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab3FPBWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 21:22:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754809Ab3FPBWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 21:22:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29F928BD4;
	Sun, 16 Jun 2013 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XNxNjd0sMdK5Ga/6+4kIQcJ8lqU=; b=maC2uB
	R4O+oWycayqOw0LmZ7/aHA/3pTmxyMzvbWu5mg8wmd5sjAlJ8qKTC9tEWPfLWJg9
	iMRYnBmt+ARuJvfJqeQ8fR1aI9nv/hxTuO6HseVauHTKneRcS6c8DJX//T8Q5mFq
	hrPc24zwUMl7I6gTUg03OCr9nrfIKDvXvuP5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=No2sRVmOudbPwhO8ztMntPYZIN1B36Vu
	Ek+Mt0xfyfip6k44kJFcQc3XJMsJDsV23xoLW2PUJfLbPEgqGdwn7f75z/jwA2r0
	h4TMLHnpSuF37iC3cwQ5u/Vh+X7JffUMwgYLmjwkvJ1lHvqs7Ptlwn1c1oYemKWw
	eHqHocXxY1k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9E8E28BD3;
	Sun, 16 Jun 2013 01:22:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A06928BD2;
	Sun, 16 Jun 2013 01:22:32 +0000 (UTC)
In-Reply-To: <1371302006-29775-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 15 Jun 2013 18:43:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37D9EE54-D623-11E2-A25C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227980>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra (5):
>   stash doc: add a warning about using create
>   stash doc: document short form -p in synopsis
>   stash: simplify option parser for create
>   stash: introduce 'git stash store'
>   rebase: use 'git stash store' to simplify logic

Looked sensible overall. I briefly debated myself if "git stash
store" even needs its own error message that needs to be squelched
with -q (as there is no reason for the end user to invoke it), but I
think it does not matter that much, and we can remove that part
fairly easily before it hits 'next'.

Will queue (but I am not on my main machine today, so not very
soon).

Thanks.
