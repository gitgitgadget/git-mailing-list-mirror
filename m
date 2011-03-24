From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #04; Wed, 23)
Date: Wed, 23 Mar 2011 22:24:15 -0700
Message-ID: <7vy645ay68.fsf@alter.siamese.dyndns.org>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1103232015390.30954@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 06:24:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2d29-000303-GX
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 06:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab1CXFY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 01:24:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1CXFY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 01:24:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87955330B;
	Thu, 24 Mar 2011 01:26:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VPRBpgtHuD1qFdhFqmJ4q2vjb94=; b=XIIsRm
	KmXMxspeltygjYgoVcQ7booseB2x0EvMI9/9/GynRqysF+WeD0wlNIOoakF2D6rD
	6OfpKzSvUuVQg5PHSP6LyySQIMIvSgaIEEWO5jUhBsVnni0f9epdiIxRLfnk/XMf
	YhYQoTJfx8lK2RcTA0jm7Fl78HmdsNBg/UidQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LuBjGIyzTGQrBXnK4TBOOYuAguhQWaAU
	CNnYZEw7TYTa38cF6EUJk0BQTuhKSTZcJ9/iyZ0JAJTJ4+EyHfx/dTY0H9NW9u9V
	rcX/CvSgsrex2ml+D+U1GUrSiZCJNPutyXIYwa1En6toNYAqLW+co8pVwXiP/Wgl
	70HqVxBQaDI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42EBE330A;
	Thu, 24 Mar 2011 01:26:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5415C3309; Thu, 24 Mar 2011
 01:25:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1103232015390.30954@debian> (Martin von
 Zweigbergk's message of "Wed, 23 Mar 2011 20:39:09 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35505282-55D7-11E0-8693-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169892>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Wed, 23 Mar 2011, Junio C Hamano wrote:
>
>> * mz/rebase (2011-02-28) 34 commits
>>  - rebase: define options in OPTIONS_SPEC
>> ...
>> 
>> I think the tip one is a response to J6t's regression concerns; it looked
>> Ok to me.
>
> Do I need to do anything to un-stall (the tip of) this topic?

Thanks for a ping, but not at this point.

I was hoping that I don't have to be the only person to re-review the last
bit and has been waiting for an independent Ack from other regular
reviewers.
