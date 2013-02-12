From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff(1) appears to contradict itself
Date: Mon, 11 Feb 2013 18:54:46 -0800
Message-ID: <7v1ucmjl6x.fsf@alter.siamese.dyndns.org>
References: <CAOnWdojOT61XOY6JxL-3sR4W8N0katShsSLsOsuJ0-PuM9Vemg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Reuben Thomas <rrt@sc3d.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 03:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U561a-00042T-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 03:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab3BLCyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 21:54:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab3BLCyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 21:54:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00AD3CB24;
	Mon, 11 Feb 2013 21:54:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bOCaxtFxitv8ibZvN7LiTLn8res=; b=EreEvd
	focYAXzuYXaPqiIC0xUWfD4vHwcz/oUGXtxpAwTDj0MHf2yXQWOG/JkCdArcAEbV
	wZ97Wy60DMeZcU3r8VF19P9UerN5ySJI6GLbwSxrAtlg5AUj1jdnh/iNVm6MlLTE
	j1YkXXR/3oOc9dGOP18AlOZdPlt5T8LrGzUfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p3TwQ8P8GBoEC6vPGAwS/hTMeAZtDBgj
	/QT7EnINPT/UFYnVsdflfoAEkBhO5fa7Hmsp+jNrq+ko++Si3KbbvGbcqQIc6mpk
	InIBkcT/mQjpP6/9i3sS4XKoxxASznDHK/j9bJ4Uqut6noiSsD/9Mqepj3Ql4Hrc
	DFICgPs5E8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9BEDCB21;
	Mon, 11 Feb 2013 21:54:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60C75CB1E; Mon, 11 Feb 2013
 21:54:49 -0500 (EST)
In-Reply-To: <CAOnWdojOT61XOY6JxL-3sR4W8N0katShsSLsOsuJ0-PuM9Vemg@mail.gmail.com> (Reuben
 Thomas's message of "Tue, 12 Feb 2013 02:49:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90F43622-74BF-11E2-8EC3-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216114>

Reuben Thomas <rrt@sc3d.org> writes:

> Under the --color=<when> option, it says:
>
> Show colored diff. The value must be always (the default for <when>),
> never, or auto. The default value is never.

I think it wants to say this:

    You can say "diff --color" without saying "when".  That is the
    same as saying "diff --color=always".

    If you do not say "--color" at all, that is exactly the same as
    saying "diff --color=never".

Patches welcome.
