From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate fails
Date: Tue, 20 Jan 2015 16:22:19 -0800
Message-ID: <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
	<1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
	<7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "Dan Langille \(dalangil\)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDj3z-00058t-9h
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 01:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbAUAWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 19:22:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752075AbbAUAWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 19:22:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32E233200E;
	Tue, 20 Jan 2015 19:22:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+x0z6n24cZEzC/psIRkXL9Bn0Q=; b=uXmOeI
	Nf3eOnfjl6goax4cmIGrdRAGjgOapAYPDVmJPPu1O3XRKWVZbMTCEURn6yF8EfpW
	1JkbGPqjTsgIR+lWN9N6y6t1qTLxFqvWcmDcpHapKtWaoinPGCNdECa1mkjZP8FP
	QknDwBbQE2LtHYP3hAUB0qWiwrSVKPrCxfxzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZLjPRLXRPPffDH8k+agWdN0M/lTpoch
	p3M/xi2rv80gTBhRS5+caxQF90m3xrvO5r++tlVobj0I26Zhg0GjK9jGFP/WeTNf
	VIBegUgOBu0tR7XYS+CXLfG5OXeoc6Bvm7eqMo12r/iWeRpOrOippjheRq+/SRSj
	prankL6D9QM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29BF53200D;
	Tue, 20 Jan 2015 19:22:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5F383200C;
	Tue, 20 Jan 2015 19:22:20 -0500 (EST)
In-Reply-To: <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com> (Dan Langille's
	message of "Tue, 20 Jan 2015 16:40:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 905C54B6-A103-11E4-BB07-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262706>

"Dan Langille (dalangil)" <dalangil@cisco.com> writes:

> I did not test this patch.  Is that holding up a commit?

I am hoping that you rebuilt the Git you use with this patch by the
time you wrote the message I am responding to and have been using it
for your daily Git needs ;-)

I believe it is queued on the 'next' branch so that others like you
who need the change can verify the improvements, and others unlike
you who do not need the change can make sure the change does not
cause unintended consequences.

Thanks.
