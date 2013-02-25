From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Sun, 24 Feb 2013 22:44:24 -0800
Message-ID: <7v7glw3nav.fsf@alter.siamese.dyndns.org>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com>
 <CANiSa6gM1gpj0A6PC0qNVSaWvVrOBnSnjn2uKR9-cHSLAZ2OVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, git <git@vger.kernel.org>,
	phil.hord@gmail.com, Neil Horman <nhorman@tuxdriver.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:44:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rnw-0004RM-JZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab3BYGo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:44:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755347Ab3BYGo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:44:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69E86A6A5;
	Mon, 25 Feb 2013 01:44:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=FTORbxFDfEnIR+60iMuMq722wBI=; b=HNwnC+gubLQoJNLCJ1t9
	l7y3xh6o4icnZcWIZ+Hn1Bi922g6BOSmqo90HOsF4OYjApP+TsZo06AxHcKot5no
	/MHL0L7KGNajq2xhOenOmmxSjpjdnL82SdH7mWF2sTlAvaZx2CcORUHzihW8gqN/
	3uWMbweCHS0FIJrfKBPN/hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vnbRHTxnzobTG4Y2vyrPmiYR8OQFyYWKgvmPQtLgjOp9Ov
	pWtLhmRyMCMLx9nwxM0oQQwAX1bWVOnIoWKKrlXoEd6hFSVgPqqPzkFtNvnoe5bp
	R9rl/WrrukWz4SiG6efokWrCPWsPz/VEZ6DcZa4y6372YMmHc9LZzRGlu7XLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295EDA69F;
	Mon, 25 Feb 2013 01:44:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C90AA688; Mon, 25 Feb 2013
 01:44:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB9B9C14-7F16-11E2-A226-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217038>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> I'm working on a re-roll of
>
> http://thread.gmane.org/gmane.comp.version-control.git/205796
>
> and finally got around to including test cases for what you fixed in
> this patch. I want to make sure I'm testing what you fixed here. See
> questions below.

Did anything further happen to this topic?
