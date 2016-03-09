From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Tue, 08 Mar 2016 16:39:59 -0800
Message-ID: <xmqq37s0jxgg.fsf@gitster.mtv.corp.google.com>
References: <56D28092.9090209@moritzneeb.de> <56D401C2.8020100@moritzneeb.de>
	<56DF6D67.9040103@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 01:40:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adSAx-0003iC-4k
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 01:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcCIAkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 19:40:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753080AbcCIAkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:40:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8142E4BEFD;
	Tue,  8 Mar 2016 19:40:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W8kmiaXRAu3P4DkGgTNTKHiKZkg=; b=j0Gino
	d2/8X7qz8WmCSeM9rVzfkBZjm9NdAl8lnCDcUNlqPvak8tYZaZ6drTVVv9Bp1SX1
	XxDzbhXqY26TJL2y5dl35G5w1Xu2lGAQnA4JOxhfLNioRpl5vU8FpaQqj6bWRbsj
	jjfn8Uio45SDhkberaK2YSkyNZXrXT/Pv+g3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=re0b44+ANIhd8cmsHD/+uRVK4d0V9fZV
	9lB89OshkT4RRC5dGvuWQsW5CcTOSMt4HUAQn6Ipa9MZ13pW7Q3MkqKDoJ2H/XGa
	2dxM6QUvvwiIVGuXmzrGSrIF2Ri4/nPUsdyptlCzZ0zqXkBmijE5GvuCc0iyIN7H
	kkNN0uzkKQY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C57F94BEFA;
	Tue,  8 Mar 2016 19:40:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CEDD4BEF7;
	Tue,  8 Mar 2016 19:40:01 -0500 (EST)
In-Reply-To: <56DF6D67.9040103@moritzneeb.de> (Moritz Neeb's message of "Wed,
	9 Mar 2016 01:25:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75140240-E58F-11E5-AC35-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288465>

Moritz Neeb <lists@moritzneeb.de> writes:

> how to deal with patches during the v2.8.0 rc freeze? Will they wait on
> the mailing list until the feature release cycle is finished?

Because people are expected to stop getting distracted by new
features and no-op clean-up changes and instead to focus on helping
find and fix regressions that have been introduced since v2.7.x
series during the pre-release period, you may not get review
comments unless your patches are really important.

To participate in regression hunting or not is your choice.  In any
case, you'd likely be re-sending a reroll after a release concludes
this cycle in order to get sufficient reviews and Ack's, as people
may have expired the last round of patches from you from their
mailboxes and their brain by then.  And then we go from there.

Thanks.
