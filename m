From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 22:27:52 -0800
Message-ID: <7vr5rt90d3.fsf@alter.siamese.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com>
 <20091119074226.GA23304@atjola.homenet> <00d401ca6954$a29fa020$e7dee060$@com>
 <200911200149.19528.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "George Dennie" <gdennie@pospeople.com>, git@vger.kernel.org,
	B.Steinbrink@gmx.de, "'Jason Sewall'" <jasonsewall@gmail.com>,
	'Jan =?utf-8?Q?Kr=C3=BCger'?= <jk@jk.gs>, torvalds@osdl.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 07:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBMym-0000Pt-6Y
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 07:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbZKTG2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 01:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbZKTG2L
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 01:28:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZKTG2K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 01:28:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 31D72A0C21;
	Fri, 20 Nov 2009 01:28:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JtkrgO/CDmqY9u5ZElhA3JDy+D4=; b=pCW6Lr
	5IMEGf6UfwjTu1p6sqDyYCIdglPFtcmkPd+/hQdNgIX6cZ4aW06h/pQHJGo8qlJ0
	amWNH62UJ4mguvJD4qnLONZflLdHfN46hB2NubjlIqAzYBUEfrIWsPKQo+PpM8dB
	J7Fa4aaUwqVWDFiibHyj9TUYHvDQIT8B7A5TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpklZic22yhe2o+FKh+qJ8L26CY3m+S0
	IHZ1PlTQyivtvfLFDbdwidtBnyQSMPDHjzWZlC8qipw5vZn9ekkg27M0Sz8hZZNQ
	t452yMSxHAlJvO1re91urKKe5q6bkIW0Ahh+tGdmNuQc2iXU/7/WYdnfFI8Dbqnw
	Njpz9kUKaic=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB5E4A0C20;
	Fri, 20 Nov 2009 01:28:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 767C1A0C1F; Fri, 20 Nov 2009
 01:27:59 -0500 (EST)
In-Reply-To: <200911200149.19528.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 20 Nov 2009 01\:49\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE80B7A4-D59D-11DE-A640-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133306>

Jakub Narebski <jnareb@gmail.com> writes:

> If you didn't find sufficient description of underlying concepts behind
> git in "Git User's Manual" (distributed with Git), "Git Community Book"
> or "Pro Git", take a look at the following documents:
>
>  * "Git for Computer Scientists"
>  * "Git From Bottom's Up"
>  * "The Git Parable"
> ...
> It is documented, see referenced mentioned above.

I actually would want ourselves step back a bit and make sure that anybody
who is completely new to git won't get confused with the concepts after
s/he reads our "Git User's Manual" and nothing else.  Listing five or six
documents and "you'll find information somewhere among these" *might* be
the best thing we could do at this very second, but we should strive to do
better than that.
