From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git rebase" loses the additional changes in "evil" merges
Date: Tue, 05 Mar 2013 15:31:38 -0800
Message-ID: <7vmwuhs9t1.fsf@alter.siamese.dyndns.org>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
 <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
 <201303052118.r25LIoAC000463@freeze.ariadne.com>
 <7vy5e1sf6b.fsf@alter.siamese.dyndns.org>
 <D9E55432793A444F941789A493F97B1C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale Worley" <worley@c-66-31-108-177.hsd1.ma.comcast.net>,
	"Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Mar 06 00:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD1L5-0001It-DT
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 00:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3CEXbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 18:31:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab3CEXbl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 18:31:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C03E1A2BC;
	Tue,  5 Mar 2013 18:31:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oiSoKhJIfWzDyMeiTdEmKHKdToc=; b=CP25nD
	h9Fq9QbxIBPYIylWb18L9NsyuEwnPKZqzYVCqly1TwBMmgREoFNL+vY0R9k0iO6A
	MPeQwHHu7hWuZ8xeBqQ2cAH0vxbYILGVdborCPomrfAhafluvGhamP0t6dAE3sI/
	m4fBXy2TNuA3Yqu1G87ZFwA/EqhXgQBuFC3mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x+J17Lt75c4KCBEyoIqSlYTWrmxhE3+e
	m4UcFdKbS9Hv1WgQi1FtCoc+9TSYrGs5/KbqAf4y98NS5u3+BeMkwmH+8vGylQhZ
	oYh5VOjbn4+ui8xetaDFYZCfP4InsUQyHEDGVJmD6DusfZ5waT+BIp0qkeD7QKUW
	4Rsh4rZC7gc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B51FCA2BB;
	Tue,  5 Mar 2013 18:31:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36843A2BA; Tue,  5 Mar 2013
 18:31:40 -0500 (EST)
In-Reply-To: <D9E55432793A444F941789A493F97B1C@PhilipOakley> (Philip Oakley's
 message of "Tue, 5 Mar 2013 23:16:03 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4BA9C5A-85EC-11E2-848F-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217495>

"Philip Oakley" <philipoakley@iee.org> writes:

> Given that many folk appear to trip up with their rebase mindset, does
> this suggest that a few tweaks to the manual may be in order to stop
> such misunderstandings?

Perhaps.
