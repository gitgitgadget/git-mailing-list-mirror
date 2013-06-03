From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] add simple tests of consistency across rebase types
Date: Mon, 03 Jun 2013 11:05:56 -0700
Message-ID: <7v8v2rf4sb.fsf@alter.siamese.dyndns.org>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-2-git-send-email-martinvonz@gmail.com>
	<CANiSa6hH3APigj_vozsbBQriNhqnPT=2Qcb0T76qs9hPhbhacg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZ8t-0000SX-Iy
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150Ab3FCSGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:06:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890Ab3FCSF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:05:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8460724AB7;
	Mon,  3 Jun 2013 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUjN2oXtQ98B9afEOQEpUMYcNxM=; b=CXAFsB
	JOFqy8K9GYBWli/i3qHmjutxN9sIJg17mlS0ExP5Ljk+2ITVEmmFjhanLHdDEsFs
	XoxsEKAqa7p8MWqB/tv0PHaWoWZSgjLkmiwlZIlivZ8R3W4Wb+8p6aaeXIjOiD6y
	5+bpavwYfTG+ISLgVwUsxSUD94vHofxyNxUOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kp38FXNDPxv74Y7SD5tv4S5qL4HseM83
	PLiEa8fYhndyKpUGCTsP226NcS4uI+0+rSwqaNp/cRkYQ1uROdoQihVYrOkuqW9x
	yfaDJyU5erv2Ujr9MvER6oI0shl7kF6FLUKfXK8v1fBrLXCOq0R5oBoJHPer0wjh
	gLikGFK5tJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7808524AB6;
	Mon,  3 Jun 2013 18:05:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4E3E24AB4;
	Mon,  3 Jun 2013 18:05:57 +0000 (UTC)
In-Reply-To: <CANiSa6hH3APigj_vozsbBQriNhqnPT=2Qcb0T76qs9hPhbhacg@mail.gmail.com>
	(Martin von Zweigbergk's message of "Mon, 3 Jun 2013 10:16:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DAE929E-CC78-11E2-BF06-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226256>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Tue, May 28, 2013 at 11:39 PM, Martin von Zweigbergk
> <martinvonz@gmail.com> wrote:
>>  create mode 100755 t/t3420-rebase-topology-linear.sh
>
> Just FYI, there's another test case with the same number
> (t3420-rebase-autostash) in pu. I don't know how you normally handle
> such cases.

Thanks for a heads-up.  Usually, the series that appears later on
the list yields and finds a unique number.
