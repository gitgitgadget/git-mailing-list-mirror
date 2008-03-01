From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when not
 running verbosely
Date: Fri, 29 Feb 2008 21:40:39 -0800
Message-ID: <7vpruf80iw.fsf@gitster.siamese.dyndns.org>
References: <1204323805-23185-1-git-send-email-mh@glandium.org>
 <alpine.LSU.1.00.0802292334040.22527@racer.site>
 <7v1w6vb9w4.fsf@gitster.siamese.dyndns.org>
 <20080301041005.GA8969@coredump.intra.peff.net>
 <20080301042739.GX8410@spearce.org>
 <20080301042822.GA14274@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKTr-0007uD-Hu
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbYCAFkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYCAFkz
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:40:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYCAFky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:40:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 14F9E1FE6;
	Sat,  1 Mar 2008 00:40:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 445DF1FE5; Sat,  1 Mar 2008 00:40:43 -0500 (EST)
In-Reply-To: <20080301042822.GA14274@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 29 Feb 2008 23:28:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75620>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 29, 2008 at 11:27:39PM -0500, Shawn O. Pearce wrote:
>
>> This is why when tests start to fail I just rerun the specific case
>> with "-i -v" and let the test stop on the first failure, *fix that
>> one case* and run again to see if anything else is going to barf.
>
> Yes, exactly. I assumed that everyone did that.

Likewise.
