From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unify subcommand structure; introduce double dashes for all subcommands?
Date: Wed, 23 Jul 2014 10:52:34 -0700
Message-ID: <xmqqiomodkt9.fsf@gitster.dls.corp.google.com>
References: <53CFBA1A.8040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA0if-0008C3-39
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbaGWRwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:52:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50224 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932241AbaGWRwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:52:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1091E29969;
	Wed, 23 Jul 2014 13:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LDncEPF1CburVI+ujQrRWqHBUkA=; b=tp386f
	L4H9wGEPG4lN/FHMIqg4x2DuRdupaovWHo8MvKlYD15YC3zDsbDtOGcUwAQmwaG7
	SjEMqsMV9GgKTMv4BnmIS9+xiwqTLK8ZQSkPS7mgCZs5Nq4cLEyXoTrgTNilODjT
	kI4e/Kl1q68hAXxYRGcTR6dsm86Nww+wRG87s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a5MfCOttPeqoR/PaOmrOQw3AbQxYjRF2
	h1oVblqnyX6attUc+zsxFHZMKDV+BNBrcgETbPtqcC36yWVLmw4szq/+uXNmikuw
	VHvGsc+eEz7J4w/wJcTiXE+Vs8vEYhDrltxZEknJHkylKOucF1HOpOpLLy003ti+
	NQf5SZB4JMc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04C7029968;
	Wed, 23 Jul 2014 13:52:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 707962995A;
	Wed, 23 Jul 2014 13:52:36 -0400 (EDT)
In-Reply-To: <53CFBA1A.8040600@gmail.com> (Stefan Beller's message of "Wed, 23
	Jul 2014 15:35:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2182E06E-1292-11E4-A932-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254098>

Stefan Beller <stefanbeller@gmail.com> writes:

> A git command is generally setup as:
> 	git <command> [<subcommand>] [<options>] ...
>
> The subcommands vary wildly by the nature of the command. However all
> subcommands
> could at least follow one style. The commands bundle, notes, stash and
> submodule
> have subcommands without two leading dashes (i.e. git stash list) as
> opposed to all
> other commands (i.e. git tag --list).

Sounds familiar.  E.g. here is a similar thread about a year ago.

  http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478

Further discussions to make the plan more concrete is very much
welcomed.

Thanks.
