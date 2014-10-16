From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] Consolidate ref parsing code
Date: Thu, 16 Oct 2014 13:47:21 -0700
Message-ID: <xmqqwq7zspwm.fsf@gitster.dls.corp.google.com>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:47:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XerxI-0001DS-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 22:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaJPUrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 16:47:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751472AbaJPUrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 16:47:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2078E16B7A;
	Thu, 16 Oct 2014 16:47:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrMI1ft5w0WYrXZCCIlVFShQIg4=; b=Pys15q
	/jQiYfXzdkuSahauqTPEKjGiGuDwLBm3WM7k6w8CWdS/iJw2O5SxdFXVUgwqFNN3
	bDGC+bmkMOnMtnsvXV/U7GosaUgE3cM8qH7R4rcqJNHvjXa/ZEj4MLEkfUiJxTLL
	LF2PnQC6bQShNxiX7TaSEMj8SV4PlP18lGrIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xukTdRKfLk4stuHv9S9XnL2GIxG8ztOD
	V+1yVjzz2paz/WWKSBosp0RgOsSQwq1jo4XctEVHkSbNSsxpqUE6BjFsqCYA3UOy
	o0q5fb5g6MlRqKOlToEel64bIay4xDpspaQMdkP7LaNq3PnNsug8s3+YPk1SyHZS
	ibjrRt/gvPU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1589016B79;
	Thu, 16 Oct 2014 16:47:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90EB016B78;
	Thu, 16 Oct 2014 16:47:22 -0400 (EDT)
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 15 Oct 2014 17:06:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0D93C98-5575-11E4-8733-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is a rif on Duy's oldish patch series [1]. I started reviewing
> his patch series, but found that some of his patches did multiple
> things, making it harder to review. I started pulling it apart into
> smaller changes to aid my review, and I guess I got carried away :-/

Hmmm...

You are aware of another large change in flight in the same area,
and after having reviewed that series a few times I was hoping that
you would have a better understanding of how ready the other topic
is.  And then I see this series that conflicts with that other
topic.  Is this your way to say that the other topic is not quite
ready?
