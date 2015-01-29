From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/1] http: Add Accept-Language header if possible
Date: Wed, 28 Jan 2015 22:19:21 -0800
Message-ID: <xmqq7fw6f6s6.fsf@gitster.dls.corp.google.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 07:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGiRu-0005rP-H9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 07:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbbA2GTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 01:19:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753358AbbA2GTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 01:19:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8E392932C;
	Thu, 29 Jan 2015 01:19:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nlwabs59SO0Ah/k8oTSjNcaiIuk=; b=fb8Avh
	ogrF+9/HIr9JhNcY30PRz0PPoM9jYYQUw+6QE2IOqdrK7o0+d43ovHQR6Y7cqi/8
	aGd78jtCxCPbeP2CVpmnN693knUSt5DrYZzxPkL5Uaef2F07o9DWhl6yLZCOjyEL
	6RWypbC1NuPHIHKAt4TXBYWPiHFhD+Q6XTq7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3UmOeCXyOYJ7SQIn2t/72mB3jV1RHTs
	YFfR5goQk5q44J6/COGZB2Ozlg8gGUJ9Xt2tOqf+qMCCEFp4BTJ16KZl33sye4JW
	AR17HZNhyFT4He95Rs9IYXQJuEqUwwW9z9j1UPmclBi4EKvJQYArxHKoEJ7pqhpI
	J+yzWqC8wgU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE4002932B;
	Thu, 29 Jan 2015 01:19:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6239229329;
	Thu, 29 Jan 2015 01:19:22 -0500 (EST)
In-Reply-To: <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com> (Yi
	EungJun's message of "Wed, 28 Jan 2015 21:04:36 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C40C8520-A77E-11E4-BBEF-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263140>

Thanks; queued.  Let's run with this and try to make it graduate
early next cycle.
