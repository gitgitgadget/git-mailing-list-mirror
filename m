From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for t9113 and 9126
Date: Thu, 19 May 2016 10:11:18 -0700
Message-ID: <xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
	<1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
	<20160519100658.GA20225@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 19 19:12:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3RTs-0000Cf-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbcESRLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 13:11:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932420AbcESRLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 13:11:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BD391DC7B;
	Thu, 19 May 2016 13:11:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cuRdFVs567y5SmhLVbHuDGRlQ9A=; b=svmWuZ
	hhHU4MhJJGGuMX/AjhzmIDrpDF7G14hpmbQBFlo+2FptDCASLtBxvlx2o2zlNY0r
	o/Vg8BIXOigWVFqYN/Skoi5zUViOY8d3hoAkwoFJgiHOy/GjsY0tUS+ldjQd9YJw
	mCln3t53rQ2HdYzg4SxYkGjMsk0kQ6nceAbIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRV73w0Aej+5Y+hGzrrnszURFdtvTez4
	2cpasMKmP3aNCSYjipa/vAN92VsWZmqz8SIMuChgcU6CmkYbZkjQj7PfuOZRWA3E
	LyPiLrkxiZl5QJeieDxMkF8vRKz4rmrnwaSyrv6pdaPUAcp729XAjkh5QaWBdlIM
	23W/ew81cZE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18C2C1DC79;
	Thu, 19 May 2016 13:11:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D1CD1DC76;
	Thu, 19 May 2016 13:11:21 -0400 (EDT)
In-Reply-To: <20160519100658.GA20225@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 19 May 2016 10:06:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B571C1AA-1DE4-11E6-ADD4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295076>

Eric Wong <e@80x24.org> writes:

> Anyways, how about making the tests run on separate ports and
> not worry about serializing them at all?

Yeah, that does sound like a more sensible approach.
