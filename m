From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] docs: clarify git-branch --list behavior
Date: Thu, 31 Jan 2013 16:37:01 -0800
Message-ID: <7v4nhweuoi.fsf@alter.siamese.dyndns.org>
References: <20130131064357.GA24660@sigill.intra.peff.net>
 <20130131064545.GA25315@sigill.intra.peff.net>
 <CAPig+cT21Fx6BaD=1jT7KSBZSZkWu-A-0U+QsM2qO8g5gki=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Peter Wu <lekensteyn@gmail.com>,
	git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 01:37:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U14dE-0008Ja-7M
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 01:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805Ab3BAAhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 19:37:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272Ab3BAAhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 19:37:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7820B913;
	Thu, 31 Jan 2013 19:37:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xmPKgn0+fTcv5MFY3nXNtAkS8fg=; b=Gy6NmP
	J0bHYlhegWfSRblrOG/8polxUs8etKyAsXXdiBhPljFFoFwoej7y6EgaM80pN0IJ
	30Xn8fenpMnafcsH5wVyq3QWOwZowVRkr7qN2Kcltyg62/OB4RwkIPsMQphD7si8
	5YTRQsJGDp8fqxMF7bSCZAtMMMBianM/khByI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rk5BWdMLxOXQB/n0yoqcfWnX71UHLRy1
	Vhrn0Vg5JKsq4Fa/GdUIZLmmkDH9TZOiINzCdSWPdw8QzPE9RjzAfk1zx6UVQYVe
	67uAvxeQ58MzWNUUCCJfuib8p+cAe8Rlz+4/M0OQn5fhcV2sZzLRhHolVh3zm1Z2
	CIT2ewb6fxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABE80B912;
	Thu, 31 Jan 2013 19:37:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18A09B911; Thu, 31 Jan 2013
 19:37:03 -0500 (EST)
In-Reply-To: <CAPig+cT21Fx6BaD=1jT7KSBZSZkWu-A-0U+QsM2qO8g5gki=YQ@mail.gmail.com> (Eric
 Sunshine's message of "Thu, 31 Jan 2013 19:20:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F50A1F0-6C07-11E2-B84D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215192>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jan 31, 2013 at 1:45 AM, Jeff King <peff@peff.net> wrote:
>> +If `--list` is given, or if there are no non-option arguments, existing
>> +branches are listed; the current branch will be highlighted with an
>> +asterisk.  Option `-r` causes the remote-tracking branches to be listed,
>> +and option `-a` shows both local and remote branches. If a `<pattern>`
>> +is given, it is used as a shell wildcard to restrict the output to
>> +matching branches. If multiple patterns are given, a branch is shown if
>> +any it is matched by any of the patterns.
>
> s/if any it is/if it is/

Thanks; I'll squash this in.  Peff, no need to resend.

 Documentation/git-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 01aa87f..2635dee 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -28,7 +28,7 @@ asterisk.  Option `-r` causes the remote-tracking branches to be listed,
 and option `-a` shows both local and remote branches. If a `<pattern>`
 is given, it is used as a shell wildcard to restrict the output to
 matching branches. If multiple patterns are given, a branch is shown if
-any it is matched by any of the patterns.  Note that when providing a
+it matches any of the patterns.  Note that when providing a
 `<pattern>`, you must use `--list`; otherwise the command is interpreted
 as branch creation.
 
