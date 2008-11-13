From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -v does not removes the patch
Date: Wed, 12 Nov 2008 18:15:45 -0800
Message-ID: <7vk5b8jrqm.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
 <20081110181023.GA22753@coredump.intra.peff.net>
 <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
 <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
 <20081111000706.GA26223@coredump.intra.peff.net>
 <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
 <20081111102914.GA30330@coredump.intra.peff.net>
 <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
 <20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 03:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Rm9-0004is-5I
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 03:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYKMCQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 21:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYKMCQG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 21:16:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbYKMCQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 21:16:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D4C17C8AE;
	Wed, 12 Nov 2008 21:16:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 66E5B7C8AA; Wed,
 12 Nov 2008 21:15:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0588E442-B129-11DD-86F4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100843>

Jeff King <peff@peff.net> writes:

> Here's a patch series that at least improves the situation by turning
> off the diff-stripping if we never put in a diff in the first place.
> That way only people who actually _use_ "-v" will have to pay for it.
> It has the fix I sent to Santi earlier, as well as some related
> cleanups.
>
>     1/5: define empty tree sha1 as a macro
>     2/5: wt-status: refactor initial commit printing
>     3/5: status: show "-v" diff even for initial commit
>     4/5: commit: loosen pattern for matching "-v" diff
>     5/5: commit: only strip diff from message in verbose mode

Makes sense.  Thanks, will queue for 'master' with minor futzing to lift
minimum fix to 'maint'.
