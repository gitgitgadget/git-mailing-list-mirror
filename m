From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] test -z/-n quoting fix + misc cleanups
Date: Fri, 13 May 2016 15:09:51 -0700
Message-ID: <xmqqoa898v9s.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
	<20160513182325.GB30700@sigill.intra.peff.net>
	<xmqqwpmx91mb.fsf@gitster.mtv.corp.google.com>
	<20160513195911.GE9890@sigill.intra.peff.net>
	<xmqqshxl9142.fsf@gitster.mtv.corp.google.com>
	<20160513204654.GA10684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 14 00:10:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1LHU-0000te-7v
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 00:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbcEMWJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 18:09:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753817AbcEMWJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 18:09:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D621119AA3;
	Fri, 13 May 2016 18:09:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u8ghgdsqdewaDSFJ1cS99vP+Lvo=; b=V5aZ5I
	NtYmVFux0E9E7FhahqA5zdXQRSlvaAnqjAkdu7DzN0Y9ehvaF1FSxhxeigAvuJiH
	IEYOC6hwDyors8ssFFpCY2Vd7gMfdZRT9QTNgzYkfYklvuXG67DVOpTNLiZXZhJT
	nz00R3tXCuZGTOuSkUdWvk9GY6WJawbnVRhlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=osm+obhh7F7li7rChpwMgPLgbsS0EGFh
	OmoPtpfeYgYKKtXfhERrlMcAYxfNZCiKq3IPfiRANyC5g4afpevUMniEH4+5nY3V
	t594PC7ImTHSCJINWgsbNvJp1Ygl0ITrxnCzAeykPjwgyhKd1own+xtv8qADGDeg
	/RXHxZNBznY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE59319AA2;
	Fri, 13 May 2016 18:09:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45FE919AA1;
	Fri, 13 May 2016 18:09:53 -0400 (EDT)
In-Reply-To: <20160513204654.GA10684@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 May 2016 16:46:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B36C66C-1957-11E6-8A91-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294587>

Jeff King <peff@peff.net> writes:

> Anyway. Here's a series that fixes the -n/-z cases, along with a bunch
> of cleanups that remove the false positives (most of which I sent out
> just a few minutes ago as "minor fixes to some svn tests").
>
>   [1/6]: t/lib-git-svn: drop $remote_git_svn and $git_svn_id
>   [2/6]: t9100,t3419: enclose all test code in single-quotes
>   [3/6]: t9107: use "return 1" instead of "exit 1"
>   [4/6]: t9107: switch inverted single/double quotes in test
>   [5/6]: t9103: modernize test style
>   [6/6]: always quote shell arguments to test -z/-n

All look sensible; thanks.
