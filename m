From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] ident: make xgetpwuid_self() a static local helper
Date: Thu, 10 Dec 2015 15:39:20 -0800
Message-ID: <xmqq4mfpho0n.fsf@gitster.mtv.corp.google.com>
References: <20151210213228.GB29055@sigill.intra.peff.net>
	<20151210213304.GA8374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:39:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Ao4-0008RF-2h
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbbLJXjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:39:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751406AbbLJXjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:39:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E720F33947;
	Thu, 10 Dec 2015 18:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nu3YdNRsKHH2WLyfw/uLiUtCdno=; b=dnQLbm
	tJLkwCLW74EETN4KH97LQTQof7JWlF0zMq7++T5UnGq/tp0Z07IpHIAcTvbYSSwv
	LnxLP6aUIqCNJN3MgZE9+B0kXPaog0zdPJz4e5wdu/bGSOvxXZgTjebaL+IxHA+g
	H1bN7Q23w/gdiEoVWtHwjo54K0zaXBjdL6Lpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a68tCTcfqHQfS6b76g9uFBee0unS6jzR
	lagxUkiq7pQ9t+Dd0+I+nBK9Mgbd2b4/GDVpg/SfvPGVmUpHNxa2PGtYQCwjPIi6
	jzymHJhvIyd4bZqmcykrF+bTfNk/cbJ5SxGr1u66fG96HWibJLOIm9fFFl6hyHTz
	rjEDwNmu+BM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF4D533946;
	Thu, 10 Dec 2015 18:39:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 62A0F33945;
	Thu, 10 Dec 2015 18:39:21 -0500 (EST)
In-Reply-To: <20151210213304.GA8374@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Dec 2015 16:33:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CD5DB8A-9F97-11E5-A896-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282243>

Makes tons of sense (even without patches 2 and 3).  Thanks.
