From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] remote-hg, remote-bzr fixes
Date: Mon, 18 Nov 2013 08:13:22 -0800
Message-ID: <xmqqbo1hd6xp.fsf@gitster.dls.corp.google.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
	<1384747970-25481-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 17:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViRS5-0001XX-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 17:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab3KRQN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 11:13:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab3KRQNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 11:13:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2AC452915;
	Mon, 18 Nov 2013 11:13:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eS/TnUhDtAX5opNkCGzv7AL16P0=; b=T5GOh4
	XellmNOQxGviSXPu7XUKHo2NHEctfm2zRqvarU82CvZ/MaEiLG3Q2AV26HdnwIBp
	wlw9v2qj/mWiT+YiNUdcsvN58KEXTz9DSUCN+zyWCUqf5ixZg/s0k/FNtWbzbsFj
	KRLf4tXjqmmZC1XUtl13nPlN423wtjAs/OjFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3w/N4iy3uaSlDVosHx19esaWBw5LZB0
	F6OyAa7A4gX23U5IpAyyaczz9MOTwLSIydPE4wq4isuiOACFncnsgXPFf4G6PZTM
	TZNQDVQLQ3/htWZ1SVJcQVaOUoanjIgkPwYiUz3FitH+1gkwo7usg5GAFCMcJUNl
	fVmzDW8RPQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 941C152914;
	Mon, 18 Nov 2013 11:13:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E13D052912;
	Mon, 18 Nov 2013 11:13:23 -0500 (EST)
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Sun, 17 Nov 2013 23:12:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 597D3A20-506C-11E3-839B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237987>

Richard Hansen <rhansen@bbn.com> writes:

> A handful of fixes for the git-remote-hg and git-remote-bzr remote
> helpers and their unit tests.
>
> Changes from v2:
>   * changed the author on the following patches to Felipe Contreras:
>     - [2/9] test-lib.sh: convert $TEST_DIRECTORY to an absolute path
>     - [3/9] test-bzr.sh, test-hg.sh: allow running from any dir
>   * added 'Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>'
>     to the other patches
>   * made the following comment change:

Thanks, both; will requeue.
