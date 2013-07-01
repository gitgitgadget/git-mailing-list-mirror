From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/4] Perl rewrite of Ruby git-related
Date: Mon, 01 Jul 2013 10:00:22 -0700
Message-ID: <7vobamgqqh.fsf@alter.siamese.dyndns.org>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 19:00:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthSn-0000Lw-FF
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 19:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab3GARAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 13:00:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab3GARAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 13:00:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 876E22DC00;
	Mon,  1 Jul 2013 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nAJjBqcCK8m8yJEN7PLtReaTb6Y=; b=R7hMi7
	4Jwp9o/VNqbg+gI6REoyTF21HmTBDFkJOG3EvKlxcu9oRmEq0N6VL/QDOv0PFP6w
	b7TBeCmvLg7gsRW116yRUV8Y6qq6Dak57vkszZG+G8z150sR6RuoYraadmzWbD1A
	Vg6HorUmkZS0OZL3AqghZFT5g1WehPBahrh+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O82vD2ofhWoXBAFxHYPI6MM+I6afzR4u
	ETvrZypYbS/fegyr+bOvwG06t+slgAB93D5/7ypNDKA8Gu+kp45AOHQEf8SKJfaA
	QMPLtVVvYN8P1rhhMrU3ydZPf0fdPz5MLB6//QCKqFSXo1R3DlX5jEWOo1KPMav8
	YCi1vmmR35g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AEBB2DBFF;
	Mon,  1 Jul 2013 17:00:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF8112DBFC;
	Mon,  1 Jul 2013 17:00:23 +0000 (UTC)
In-Reply-To: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 30 Jun 2013 07:08:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B88B0986-E26F-11E2-B869-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229314>

Eric Sunshine <sunshine@sunshineco.com> writes:

> In this submission, the command name has changed to git-contacts since
> git-related felt too generic. (git-contacts seemed best of several
> possibilities I surveyed: git-people, git-interested, git-mentioned,
> git-blame-us.)

I admit I am pretty bad at naming, but "contacts" sounds like the
most sensible name for what it wants to do (blame-us sounds cute to
my ears, though ;-).

> No attempt is made to answer Junio's v9 review[5], as I lack sufficient
> insight with '-C' options to be able to respond properly.

I just wanted to see if we want to allow the end user of this script
to specify what -C level they want the underlying blame to use, or
just a hardcoded one should suffice (and if so an explanation why).

> My Perl may be rusty and idiomatic usage may be absent.

That is OK.  We need to start somewhere.

Thanks.  Folks, please discuss ;-). 
