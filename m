From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] git-p4: add initial support for RCS keywords
Date: Thu, 23 Feb 2012 12:03:16 -0800
Message-ID: <7v39a148sb.fsf@alter.siamese.dyndns.org>
References: <1329983490-4033-1-git-send-email-luke@diamand.org>
 <1329983490-4033-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0esv-0002ZQ-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab2BWUDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 15:03:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab2BWUDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 15:03:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E390B7D6F;
	Thu, 23 Feb 2012 15:03:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+vMGG7pvYRp0iZ486vk93sHul8=; b=hl7TDT
	tyvjOjsxGUKe6nIJdmA4FZuW+6y4t2KvIrJOWRtUEXI4BXilY8fGiF5wuI5q4NhB
	vwFJyJD/wK8p21qLHBD2P5g0RDb0rDlMkr9jjIYhyHZPNQp8EOwMrE4IJYgLuV1O
	gpQbpPxXsC5b9lqc2DHSqgobGZcYuHpKZTPyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mdwUxAI/Ae4ANv9LtWCgOAU7VZ2VEqQU
	OeALCzJSbOkX0xc34/ERru01Znl782lXIKoRpAzQyRj9Xl8XJEhtYLHtNasHLMqe
	uL5Mti3/y8k4QJttre5Bwq//XtgeEPT64y5Woc76RRi1LgGpU48ELvmtJZzcj7S8
	A4iTgAys6ws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3117D6E;
	Thu, 23 Feb 2012 15:03:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70C207D6D; Thu, 23 Feb 2012
 15:03:17 -0500 (EST)
In-Reply-To: <1329983490-4033-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Thu, 23 Feb 2012 07:51:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D2F2EC2-5E59-11E1-9536-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191390>

Hmm...  I somehow was expecting that the patch will be an incremental
update to what has already been queued in 'next' for the past several
days, with its commit log describing what the incremental improvements
are.

I'll revert it out and apply this on top.  Thanks.
