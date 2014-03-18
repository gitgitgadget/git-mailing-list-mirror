From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC14][RFC] Is there any interest in adding a port of checkpatch.pl to contrib/?
Date: Tue, 18 Mar 2014 12:29:47 -0700
Message-ID: <xmqqeh1z8fv8.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:29:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzi1-00045i-J4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757573AbaCRT3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:29:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756715AbaCRT3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:29:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4613720D2;
	Tue, 18 Mar 2014 15:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XDMn1daOJRfvV03ulCsgPlC1oPU=; b=jjoY8N
	m97P9lqjVqTjzT/L9hmHhaUfahT3Au08UjnTQQBY1Gxv4hdhVvvAQib5dwT31mS+
	sDkoO7mLgk2H+HeIpBaFOI4IY2EyMyzbUIcuRjJxUpCXgMjElYqM0fK6oaMHWvAl
	pn5soYflB56bGtvMa/ZRoGPMDVj7qeV+26PJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ra9kTRxGf8buh15EwnBYmhQBDSCFqZKV
	R9i9ampygkBleVDENTRx/c30sUCFW8DTK4mefTywh4vRFKGfG3Ch2b/HtRGT4t88
	sClCSlE2lS/G7pP4LUmubSZpPz3bMqqfr5pb+k34Itq9lR1PDZ91bE7yVMSXEYUx
	g/5noxnCZt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD9A2720D0;
	Tue, 18 Mar 2014 15:29:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28664720CE;
	Tue, 18 Mar 2014 15:29:50 -0400 (EDT)
In-Reply-To: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
	(Jacopo Notarstefano's message of "Tue, 18 Mar 2014 02:38:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC354BD4-AED3-11E3-8A6F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244372>

Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:

> It seems to me that the topic of adding the checkpatch.pl script to
> Git's source tree has cropped up several times in the past, as
> recently as a couple of days ago: $gmane/243607.
>
> It should be noted that its usage for its sake has been discouraged by
> Junio Hamano in $gmane/205998.

I've never said any such thing.

I only said I am not enthused against a proposal to add a build
target that runs checkpatch or equivalent over *all* existing code,
which will invite needless churn (read again the part of the message
you quoted before I say "I am not enthused").

It is a totally separate issue for submitters to make sure they do
not introduce *new* problems, and use of "checkpatch --no-tree"
could be one way to do so.
