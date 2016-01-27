From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #05; Tue, 26)
Date: Tue, 26 Jan 2016 22:28:01 -0800
Message-ID: <xmqqmvrra64u.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3h3amtk.fsf@gitster.mtv.corp.google.com>
	<20160127025422.GB15119@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 07:28:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOJaM-0001R6-W6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 07:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbcA0G2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 01:28:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753749AbcA0G2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 01:28:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E61F836F37;
	Wed, 27 Jan 2016 01:28:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wTU4UywCBSbSWQtRXlUOFDHrYOE=; b=qDcv9v
	H4XuDgpFrlMMtWyWJT6WxeNYx31ZtO4B5S+SArC4uqc886MQmWEWArEc3201c82O
	ZNot5ordmbjzwUB110/Gxpkfo1PtcCZqf+DaRnluEYbamLIpRJvSkEBmn8KjH6G/
	hrH+SJvT/7mDLCYe14qrdSgBX1d+ir7eLgHxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+ZUed6wZCH3WxX00ZwFLDqQzDi0e0gV
	2vL7yDGCb4jEin2xv3Na4SLvtTjAaU4j6COHdvT87N4k7NtLQVmRUepEDVuDOK5f
	OVF3Xh2wNFgq8Vrc+j9V2bnpDETQ5YTvHr4ryXjvUKbx78mgFzXAakAQnVtl/EiP
	iUJiad72sgw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF03436F34;
	Wed, 27 Jan 2016 01:28:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 65AF836F32;
	Wed, 27 Jan 2016 01:28:02 -0500 (EST)
In-Reply-To: <20160127025422.GB15119@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 27 Jan 2016 02:54:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DE98EFE-C4BF-11E5-AC97-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284870>

Eric Wong <normalperson@yhbt.net> writes:

> Hi Junio, have you taken a look at:
>   http://mid.gmane.org/20160116101719.GA21147@dcvr.yhbt.net ?
>  ("git-svn: fix auth parameter handling on SVN 1.9.0+")

Yes, I did, and I also did notice that you said it should head to
maint.  I was meaning to ask you if you were going to tell me to
pull from you soon (as I know that you know that I know you know
git-svn a lot better than I do), but forgot to do so.

If you prefer me to apply it directly to 'maint' and merge it up to
'master', I can do so, too.  I guess you are telling me that that is
what you want to see happen here?

Thanks.
