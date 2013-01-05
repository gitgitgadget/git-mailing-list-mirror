From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Sat, 05 Jan 2013 11:38:52 -0800
Message-ID: <7v1udzqv1v.fsf@alter.siamese.dyndns.org>
References: <1357314431-32710-1-git-send-email-wildfire@progsoc.org>
 <7vhamwse2c.fsf@alter.siamese.dyndns.org>
 <CAM1C4Gm_ea8DgrVhnp_MHmqaF6pyDe98EDA_BPkjvc8M5AO6FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Anand Kumria <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 20:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrZaN-000161-Kg
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 20:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab3AETi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 14:38:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832Ab3AETiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 14:38:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A533EB3FB;
	Sat,  5 Jan 2013 14:38:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AtkdDm0npLiFW4Eq6Jlpz3rITPU=; b=VGaK2Y
	XyXU8IO7fAbt4eW1tgo0GOBgeOuYU+sWwo4t+ZuZdivJ2Tmhsq0//1qyTIEIFd+A
	U1ksLHzPlB5wU17ziLwFL3BCbgqdG3hk69OhHw4RS3k892fq+ABz9zdKAFt50eUB
	vAzFA1L7PqoM5FCVNRhZjANNOdkfThRmb1OEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rKGNvIlhrgGoe5iUS/eHf2zoUtUB0/Ev
	sbcOqlTYotbuAhtmzxswnFY3moDRnhYYp/hmy5pYt2rgr+whEkpg5xNS8253Zbdx
	9s9aKtcvM0MoSVDYE7E3EETN4JK4YEC6y74EY13qFvL9KTt0S8zt120ODik8fnLm
	5LeL0rLvHL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97082B3FA;
	Sat,  5 Jan 2013 14:38:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19B3BB3F9; Sat,  5 Jan 2013
 14:38:54 -0500 (EST)
In-Reply-To: <CAM1C4Gm_ea8DgrVhnp_MHmqaF6pyDe98EDA_BPkjvc8M5AO6FQ@mail.gmail.com> (Anand
 Kumria's message of "Sat, 5 Jan 2013 14:05:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89E6CB82-576F-11E2-86BE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212706>

Anand Kumria <wildfire@progsoc.org> writes:

> Sorry, I didn't know that gitk had been split back out (and
> Documentation/gitk.txt still mentions it is part of the git suite).

It is not "split back" at all, and it won't be.  From "git" user's
point of view it is part of the suite.

Gitk however is still a viable freestanding project, so it would be
selfish for me to take a patch to gitk-git/gitk directly to my tree,
as the patch will not be able to flow back to the standalone gitk
project. Hence we always let patches go through Paul's tree and then
I pull from him.
