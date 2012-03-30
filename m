From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Enhance git-rebases flexibiilty in handling empty
 commits
Date: Fri, 30 Mar 2012 13:32:13 -0700
Message-ID: <7vpqbtltiq.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:32:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiUe-0005wQ-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761356Ab2C3UcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:32:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756941Ab2C3UcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:32:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD1C3E66;
	Fri, 30 Mar 2012 16:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YWPqcMXNJU3j0HK0TDxaNQ1oFYg=; b=lvD2Lw
	zsIWK52fLSJtIn/3HM3jj+SL2hzVgfWUr57FKR/XcGpe9z4aw3tUuoar1Qca1JYM
	7kzCcEDdkTJTU611fpLT5PRcSonzJG7NJJVfeVW8luEu7NRVU1HOsfcaXxISwXcn
	fLxn5y1StjQY7LwbseBve0M1gc4Rqk5ZbghVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixvi20rBemT4zlhdIRoSm7DJGMi12/kN
	/pj6t2HC8VGBQ7Tmvx0UylJuOM1FNEYApG992lCVO8llY3VvkuffDkrYDHZ5ShE9
	zwrpsXLX4QBq7/BPwDQOPdWDNXEW7WZXXew8RFNzvEINGpDumn+S1uUI2Qjym7Ss
	wh44vD9USe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518093E63;
	Fri, 30 Mar 2012 16:32:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD0F33E60; Fri, 30 Mar 2012
 16:32:14 -0400 (EDT)
In-Reply-To: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Fri, 30 Mar 2012 15:48:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FA6FA4E-7AA7-11E1-AC2F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194401>

Neil Horman <nhorman@tuxdriver.com> writes:

> for interactive rebases, I changed the default selection editor text somewhat.
> By default, empty commits are allowed in this list.  With patch 4 here, empty
> commits are commented out automatically, unless --keep-empty is selected (in
> which case all commits are pick-ed).  The user sees additional text indicating
> that empty commits are commented and if they wish to be kept, then they must be
> uncommented.  The pick_one function then intellegently passes the --keep-empty
> option allong to cherry-pick as needed.

Sounds like a sensible UI design.  I am a bit curious what it would do
when you try to "rebase -i" a series of commits, all of which are empty,
though.

> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Jeff King <peff@peff.net>
> CC: Phil Hord <phil.hord@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>

Please do not do this; Cc: goes to your e-mail header, not here.
