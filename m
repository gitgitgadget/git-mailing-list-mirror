From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing weak references to blobs and strong references to commits
Date: Tue, 31 Mar 2015 16:00:33 -0700
Message-ID: <xmqqiodgojqm.fsf@gitster.dls.corp.google.com>
References: <20150331100756.GA13377@glandium.org>
	<xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
	<20150331223919.GA24362@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd59E-0002M1-Rm
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbCaXAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:00:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751325AbbCaXAg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:00:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6FB453F6;
	Tue, 31 Mar 2015 19:00:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8gDpci//UAqmcdNdTueBMdgLdkg=; b=SmYz8v
	TlAd24NIQnJexeAAOWIFWHAC9hnIvaWtrJK6tP3KHg9NnQ7lfnV976VxpgubxZGt
	x8QEac2QsAimhxjhRGTrA+90FwB1D3tP+L6J/y//m27BuRNzkU2zR7KwBpSUH7yl
	ESn4MEdfUs9WDYDhaIskrf5QhiMk6S1sR0AQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FVYrUquiv5VY3XDOZ0jhsqEWa/Yq/uUP
	MZSCtpadmNrFf2LWS/e4AbeeTBgWGh/qzBMD0VV1psa5g58SV+/IkDeVpL89fNLr
	b2OxVPKYb2+Yz4PfImHxTX8Q4AsK8/xGnZsW/NOsiv0Me1kAt7a/jQFwBi6ezz9j
	CVG7AqJUmSU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7143453F5;
	Tue, 31 Mar 2015 19:00:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B42B453F4;
	Tue, 31 Mar 2015 19:00:34 -0400 (EDT)
In-Reply-To: <20150331223919.GA24362@glandium.org> (Mike Hommey's message of
	"Wed, 1 Apr 2015 07:39:19 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BCC63224-D7F9-11E4-B5A0-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266577>

Mike Hommey <mh@glandium.org> writes:

> Octopus merges are limited to 16 parents.

Huh?
