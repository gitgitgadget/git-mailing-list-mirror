From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: preserve-merges fails on
 merges created with no-ff
Date: Tue, 26 Apr 2011 22:00:58 -0700
Message-ID: <7v1v0ob851.fsf@alter.siamese.dyndns.org>
References: <1303357080-25840-1-git-send-email-andrew.kw.w@gmail.com>
 <4DB77E53.7070206@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwsO-0004vL-G6
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab1D0FBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:01:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1D0FBK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:01:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B0D25B58;
	Wed, 27 Apr 2011 01:03:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=egPxwc96F9p6zjPIiLDP8NYOJAc=; b=uR8s2G
	+A2Dvosv4ctrX3qAxCErvPhowq9JZySByjvlB1x7xzv2Gv9PiDLltDobaNVgbCi6
	tuZDf30zD9uiuzLJjAVE40vMYp1QQU3vd7U4yotyRGa2djXHza699YA5BsiIeEug
	vpIjV+oSXYeNkEpKBQyS5L9jx7pB6wbTGEDag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UCnxoOCgMNS6zxHpTRCo8jDt6JZnqI4O
	Loa5SIMmRUi9h6ey9gqzCUO9FzOTs876uLb6kHGpsdqvN7IZAfQpQ5rM+qK1UW55
	J6pLQRJYkpowKOtO2D+TDjewnitYB0fk0+ZrPnbmVvfdDruWQ82LYQkNk2QXwXZs
	DZlTs09WObo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C2055B57;
	Wed, 27 Apr 2011 01:03:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C4AA45B55; Wed, 27 Apr 2011
 01:03:03 -0400 (EDT)
In-Reply-To: <4DB77E53.7070206@sohovfx.com> (Andrew Wong's message of "Tue,
 26 Apr 2011 22:24:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A44B3656-708B-11E0-8BD4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172168>

Andrew Wong <andrew.w@sohovfx.com> writes:

> Could someone please take a look at this patch?

I took a look at it when you sent it out, and found it so obviously and
trivially correct that I expected that others will soon say it looked
obviously the right thing to do.  So I decided to wait until that to
happen before applying it.

But nobody said anything, and forgot about it.

Let's see if it happens soon enough this time ;-).  Thanks for a reminder.
