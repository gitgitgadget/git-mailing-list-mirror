From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 12:37:16 -0800
Message-ID: <xmqq4md4cu83.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<1CE3F5E2-DDCC-4F1B-93CF-1A4A194650BF@gmail.com>
	<CAGZ79kbGyCTdq4P02fNb7tEuvkvqcZviWJp40Ob1ed6=JCh9Xg@mail.gmail.com>
	<xmqq7fi1hlw6.fsf@gitster.mtv.corp.google.com>
	<0E364888-DD95-4B47-9679-3CB586FC7E8C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 21:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWro9-00010k-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 21:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993175AbcBSUhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 15:37:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992711AbcBSUhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 15:37:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82467448B0;
	Fri, 19 Feb 2016 15:37:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8r4fncqiXX2wfRzbIusSbHry4lc=; b=diA9Gp
	FXhNuXZbHT2XQSCen+qtbkDyBHTTJUG+RzVD/gVGma9FiHmvn9LNm/BpjcmJA2d2
	VtJL8Y5ZOjA45BvHRCbYD22/2DJNbbuNbBM197LDjnIRejy0F2ODO6X7+UDdAw69
	rC4wD2ra7c/6x+8C+8uxDtdyxbhW4s2sqVtn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eO8gzfukFkz5pHRBnVHSN2UGmMLvWKCm
	ownfnmQZI0yABVtgu0kdIpRqOhOLrnnj2G/MH7jnmnpRjghPKn8R7tEFUsZkbtDo
	qor/2aYUd6G5uNMVh345qJzhmWPFH3x4NJ8EWBbMt2BKO++sfmjEqaw2vJ7NpBJ3
	i7ceU9JgO3I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79098448AF;
	Fri, 19 Feb 2016 15:37:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED951448AE;
	Fri, 19 Feb 2016 15:37:17 -0500 (EST)
In-Reply-To: <0E364888-DD95-4B47-9679-3CB586FC7E8C@gmail.com> (Lars
	Schneider's message of "Fri, 19 Feb 2016 10:23:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9155CE2A-D748-11E5-9174-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286749>

Lars Schneider <larsxschneider@gmail.com> writes:

> If this mode is enabled then Git shall print a warning message before 
> running a potentially destructive command. In addition to the warning 
> Git shall print a command that would reverse the operation if possible. 
> Most of the information to reverse an operation is already available 
> via git reflog. However, the task here is to make this information more 
> easily accessible to Git beginners.
>
> --
>
> Does this go into the direction of "making the powerful tool harder to
> misuse"?

Not really, if done without a real thinking.  The approach risks to
make the powerful tool harder to use, not just misuse.
