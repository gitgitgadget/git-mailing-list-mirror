From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 19:09:50 -0800
Message-ID: <7v7hsu6wap.fsf@alter.siamese.dyndns.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
 <m34onye3h8.fsf@localhost.localdomain> <4B21AC4D.2020407@kernel.org>
 <7vk4wu6x6a.fsf@alter.siamese.dyndns.org> <4B21B550.1060806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 04:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIvtN-0000WE-LK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 04:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbZLKDJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 22:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbZLKDJx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 22:09:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbZLKDJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 22:09:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFEC4A56D5;
	Thu, 10 Dec 2009 22:09:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NLxYxg8JlxkO+5zZH+BkLhlt3ZU=; b=r52IJr
	3lI6ZYHCnTJHgHeVHA5d9q2dN1gLxpu0feLxa+RyZoB9zRzP1Xke40kqI3Gka3gF
	y2Yti7A2rwvFiQYJOgtO3nvTH2Ci1nZtCKiYVdVFB67pRmwKYM3God2V6Nb7ehrs
	p+RdYMKcak17mrxFm41O+bT9TnRTGzMAmr4Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J6S+NeDkjGyl5XQTm5cqARHGwqDqL0jf
	K4vN677HeFjJLv7jMyGW11GU7Tn9iW+gw99Au1Nn5znedcP6bc1et02oiwG7L3fo
	eYXpfzztow/TFBAEt0skMTlKkz1DE1ZDzU+FMjeACGp5UVOx60t5nl0ypp1fD/gx
	4Mnu0jhUurc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C087AA56D2;
	Thu, 10 Dec 2009 22:09:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 873B6A56C3; Thu, 10 Dec 2009
 22:09:52 -0500 (EST)
In-Reply-To: <4B21B550.1060806@kernel.org> (J. H.'s message of "Thu\, 10 Dec
 2009 18\:58\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9014DF8-E602-11DE-BB48-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135071>

"J.H." <warthog9@kernel.org> writes:

>> Thanks; all sounded a reasonable response to the review.  Are you
>> re-rolling the series anytime soon (I am asking because then I'd rather
>> not to queue this round especially because I didn't see 5/6).
>
> I'll probably have some changes up and about tomorrow, and it's a
> little troubling that 5/6 didn't come through for you
>
> 6 at least made it to marc.info:
> http://marc.info/?l=git&m=126048884825985&w=2

Sorry; I meant to say "[PATCH 5/6]", not "5 and 6 didn't come".

> and 5 seems to have been eaten by a grue somewhere.  It was a *big*
> patch mainly because all the caching flips over in a single go.  If
> you want I can privately bounce 5 & 6 to you so you have a complete
> tree right now?

Thanks, but not interested, in the sense that it wouldn't make much sense
to me to have a version tonight that is known to go stale within a few
days.  I only pick up and queue patches to 'pu' to save me from later
trouble of finding them from the mailing list backlog, and not to actively
review and engage in the discussion to polish them right now.  We are
already deep in pre-release freeze and my attention is not currently on
anything that won't go in to the upcoming release.

I want to have a solid 1.6.6 before the holidays as a present to all ;-).
