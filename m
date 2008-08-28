From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 21:56:58 -0700
Message-ID: <7vd4jthh45.fsf@gitster.siamese.dyndns.org>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
 <48B5C9E4.4030807@lsrfire.ath.cx> <7vvdxmm78o.fsf@gitster.siamese.dyndns.org>
 <7vod3em67d.fsf@gitster.siamese.dyndns.org>
 <7v8wuim4kv.fsf@gitster.siamese.dyndns.org>
 <20080827233056.GA25745@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 06:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYZaI-0007oO-Vh
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 06:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbYH1E5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 00:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYH1E5J
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 00:57:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYH1E5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 00:57:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E1FD6A751;
	Thu, 28 Aug 2008 00:57:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9DCEF6A74F; Thu, 28 Aug 2008 00:57:00 -0400 (EDT)
In-Reply-To: <20080827233056.GA25745@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 27 Aug 2008 19:30:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C39D71E4-74BD-11DD-88D3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94038>

Jeff King <peff@peff.net> writes:

> A few complexities I found were:
>
>   - some things really want no setup, like init and clone. I don't
>     recall the exact issues, but trying obvious things caused breakage
>     there.

An obvious thing is to start these commands in a subdirectory of an
existing git worktree.

>   - the setup needs to not just be part of git.c, but factored out so
>     non-builtin C programs can use it.

Obviously.
