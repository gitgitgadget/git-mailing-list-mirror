From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 04 Apr 2013 11:34:11 -0700
Message-ID: <7vip42i1r0.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <20130402200948.GF2222@serenity.lan>
 <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
 <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
 <871uaqrwrp.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:34:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNozj-0003HF-OX
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761559Ab3DDSeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:34:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761438Ab3DDSeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:34:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059F413CD6;
	Thu,  4 Apr 2013 18:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bH4J98l6iEoezEMQukro7zPPT0Y=; b=lmHoN+
	lfp9Ic9I8J7rpweQ66S8Ix6gu79JhxJ/tKMJPoUq8GU2Ui97UiUMfMaSIYbOg5AW
	5QXK30TKXyk6LpjuLziL6lkNcy+cQ+jxIZRPKlxZta6pn29Ve+j0tf3YTpAvcUVP
	T8aoSJywL1HZGMLJ9CuV9BorAu4tGYdgzs+OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KP/DOiIGE51uRJeyOwsg7+mQ8b64XiKX
	3oTPeiSvHO+irQFIEcvaovHMcYtfTBqZp87gBSSoYJvH14g85MFqdykUD6WXNxa0
	hxPGnUYzhwtfr1gCT6MNtWAKeNocAfy0WNboAkT7S/SbhpsPdO8d8U4Zl4M3ky5j
	KuaU6qHaTp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED75613CD5;
	Thu,  4 Apr 2013 18:34:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F77C13CD3; Thu,  4 Apr
 2013 18:34:13 +0000 (UTC)
In-Reply-To: <871uaqrwrp.fsf@59A2.org> (Jed Brown's message of "Thu, 04 Apr
 2013 13:11:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F9F5292-9D56-11E2-B6AE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220056>

Jed Brown <jed@59A2.org> writes:

> ...  I felt that it was wildly oversold and that putting it into
> git.git was premature.
>
> I tried gitifyhg later and it basically worked out of the box.  All
> known problems were marked by 'xfail' test cases.  At that time,
> remote-hg failed almost all the gitifyhg tests.  I contributed a few
> things to gitifyhg, including the notes support (essential when talking
> via email with other people using Mercurial).  Since then, the last
> major project I'm involved with has switched to Git so I rarely need
> gitifyhg or remote-hg any more.
>
> FWIW, I also thought Dusty's original announcement oversold gitifyhg, but
> it was closer to the truth and upon cloning the repo, it was more clear
> what didn't work.

So,... is there a concrete proposal for _me_ to act on?  Do you want
to see contrib/remtote-hg out of my tree, and have it compete with
the other one (which also shouldn't be in my tree) in the open?
