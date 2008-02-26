From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
 threads for packing
Date: Tue, 26 Feb 2008 00:00:05 -0800
Message-ID: <7vhcfwb116.fsf@gitster.siamese.dyndns.org>
References: <47B1BEC6.6080906@nrlssc.navy.mil>
 <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil>
 <47BF812A.4020205@nrlssc.navy.mil>
 <20080226074933.GA3485@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 09:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTukH-0000Hh-4a
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 09:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbYBZIAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 03:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbYBZIAV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 03:00:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbYBZIAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 03:00:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C33B92D8F;
	Tue, 26 Feb 2008 03:00:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D77DA2D89; Tue, 26 Feb 2008 03:00:08 -0500 (EST)
In-Reply-To: <20080226074933.GA3485@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 26 Feb 2008 02:49:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75108>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 22, 2008 at 08:12:58PM -0600, Brandon Casey wrote:
>
>> +	if (progress)
>> +		fprintf(stderr, "Using %d pack threads.\n",
>> +			delta_search_threads);
>
> I just noticed that this was in next.

Please send in a fix-up patch to remove it.  I noticed it while
reviewing the patch, and even commented on it, but I somehow
forgot that this leftover debugging message disqualified the
series from 'next' when I was merging topics to 'next'.
