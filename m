From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 02 Nov 2015 07:13:10 -0800
Message-ID: <xmqqlhagfn95.fsf@gitster.mtv.corp.google.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA0C@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtGnO-000053-88
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 16:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbbKBPNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 10:13:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752234AbbKBPNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 10:13:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D92E2496A;
	Mon,  2 Nov 2015 10:13:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cmiWcwAeLU0U7w0KF0YWH2Gs83M=; b=w7eBDJ
	iZwmnjug3D6UYhsh6UKjPoo7sAwAccgqse2aiicmVFJ5g8IFNeGvSE+BwaX4MEKZ
	/gUr+SrqFoZmJeCPavABSDWbLB66/iuELORQygjP4pqlSEUfqja+ZozGdPLmyz16
	WCSx3EgVfzaWtDjd3EViBeGCru7rAAx7kmfPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Au0Vt7aEwkw2xXyqaQqm40PxXjX9dnmL
	rF+/4NbkqF8yYnrIKMrELDiR9ClfcPJC4sGbEG1ISKPbEYSi6x1vy8cWH+6XJcyc
	MFSHdBqSwjF31s5+DDlvlzJWriiHR501/V1myFk0j/Kf/usqiax5OyVBodRBm01I
	XVGeMaKwQFs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 855C624969;
	Mon,  2 Nov 2015 10:13:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F052E24968;
	Mon,  2 Nov 2015 10:13:11 -0500 (EST)
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA0C@mail.accesssoftek.com>
	(Victor Leschuk's message of "Sun, 1 Nov 2015 20:43:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B8E122E-8174-11E5-82C1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280694>

Victor Leschuk <vleschuk@accesssoftek.com> writes:

> do we have any objections on this patch?

The question you should be asking is "do we have any support".

It is not like the default for any series is to be included; it is
quite the opposite.  "Is this worth having in our tree?" is the
question we all ask ourselves.

Also I think you should have CC'ed those who gave review comments on
this topic in the earlier rounds, if you wanted to receive answers
to that question (whichever one it is ;-).

Having said that, I didn't immediately spot anything objectionable.

Thanks.
