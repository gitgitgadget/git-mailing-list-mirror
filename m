From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 00:33:27 -0700
Message-ID: <7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTomQ-000813-Al
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab3DUHdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:33:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab3DUHdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:33:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1941432B;
	Sun, 21 Apr 2013 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8mKtToGV6EE2DJCHgSWaGevFBzI=; b=oEvQ2E
	hcR9/JIQxRnxTlXRRADdut8ZjoXDyI9GDkU09mrRMr+jQCFF5EFx62ZjJWC/1PRp
	BMAbA1uU6e3wR9W+S/jZwQl689EJytFH3DIeAKC3+7sjUDP6jvm3NXxJxXXsMeN5
	t4ZpCRGx18T8BKiUtZlEhXhlodyr682QWc4DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wYB4WFTQH8OBO9WC+UI4rmWjvXsaRjnf
	wdtrivfMnY6NMhhaQxER4fOXblrS8KrkoMgURBgAW9Hyk0B71vCF6kWs4XiIu6J8
	4Niw4Fv9mJSRiVIQSLcx66EI9nnYHksA3tkapk+Zp+vAzctaAT5OK65E3zvneuw3
	VUFganuvK0I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D10C01432A;
	Sun, 21 Apr 2013 07:33:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5237314326;
	Sun, 21 Apr 2013 07:33:29 +0000 (UTC)
In-Reply-To: <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 21 Apr 2013 12:56:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2E83AFE-AA55-11E2-AB29-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221906>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I think "branch names" was an attempt to make it more newbie
>> friendly by sacrificing technical accuracy.  With the suggested
>> update (see the review for the previous one), it would be easier to
>> read if this part said "options or the revision range".
>
> Why does it have to be a range? It might well be a list of revisions,

Study "Specifying Ranges" section of gitrevisions and come back,
perhaps?

A list of revisions is merely a way to specify "revision range" that
are reachable from any of these revisions listed.  "log A B" won't
stop by just showing A and B (that would be "show A B"), but will
list those that are reachable from A B, so in the context of
discussing the arguments given to "git log" command, "A B" is still
"revision range".
