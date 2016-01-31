From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Sun, 31 Jan 2016 08:42:49 -0800
Message-ID: <xmqqh9htya2e.fsf@gitster.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-2-git-send-email-pclouds@gmail.com>
	<xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
	<20160130142039.GB4978@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, git@drmicha.warpmail.net, Jens.Lehmann@web.de
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 17:43:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPv5c-0007os-GZ
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 17:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243AbcAaQm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 11:42:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750854AbcAaQm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 11:42:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90F453EFAC;
	Sun, 31 Jan 2016 11:42:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2+kZdIiXL59sSP2s8hZZvE7Lqw=; b=Cp3fZ+
	LVXPOoOYnAD7r1Q09hb6jJrG2pWnx1ECRt0U0Mo6eOn+z4Tkvnv3yj5xTOaWR2Iv
	Qs2+XDVowUt3IAbgE/HZRzE7k8dwp622MG+OHLmUX+h88zIWrTgRJWSnN7tsolT+
	AawOstWBQlN2TWFcZMoMfNeJjBNhUd+Akqv2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKngS+D77KHaTr4owSJ1AOHeflfXNDMi
	+1Ba16chNWRePe+rKScaJiiVPxRX9/a7QYMmx5uGIRq1MTbmKftI6ITUwHVvr2fl
	M8wgGC3KOm5ZjrJghnSPL1hlN4zQLbv9MCHutY2zORzU1j7Z6ZY/P5kJzxLJfL/4
	t6ZC9vu7pSc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8665F3EFAB;
	Sun, 31 Jan 2016 11:42:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C10A3EFA6;
	Sun, 31 Jan 2016 11:42:50 -0500 (EST)
In-Reply-To: <20160130142039.GB4978@wheezy.local> (Max Kirillov's message of
	"Sat, 30 Jan 2016 16:20:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAE71A2E-C839-11E5-A963-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285155>

Max Kirillov <max@max630.net> writes:

> The worktree feature has been used by several people
> already (me included), and do far the only issue which
> requires change in repository layout is the config
> separation. Isn't it enough to be confident?

One lessor key phrase above is "so far", I think, and another one
you forgot to use is s/which requires/that we know &/, which to me
is a more serious one.  IOW, I do think it is premature for us to
say that that config split issue is the only thing, or to say that
the issue is best solved by changing the layout in the way being
discussed; the multiple-worktree feature needs more lab experience
for us to gain confidence.
