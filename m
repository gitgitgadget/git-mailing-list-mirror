From: Junio C Hamano <gitster@pobox.com>
Subject: Re: configure clobbers LDFLAGS
Date: Tue, 06 Jan 2009 00:19:14 -0800
Message-ID: <7v1vvgkfst.fsf@gitster.siamese.dyndns.org>
References: <m3tz8e32ru.fsf@multivac.cwru.edu>
 <20090105060058.GB13189@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: prj@po.cwru.edu, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7BL-0007yr-GO
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZAFITX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbZAFITW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:19:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZAFITW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:19:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A14B31BE89;
	Tue,  6 Jan 2009 03:19:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 178A01BE91; Tue, 
 6 Jan 2009 03:19:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B8836F1A-DBCA-11DD-9E3B-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104659>

Jeff King <peff@peff.net> writes:

> On Sun, Jan 04, 2009 at 09:27:41PM -0500, Paul Jarc wrote:
>
>> In a couple of tests, configure clobbers the LDFLAGS value set by the
>> caller.  This patch fixes it.
>
> Thanks for the patch. It looks obviously correct to me, and the problem
> was just some typos introduced by 798a9450.
>
> Junio, I think this should go onto maint.

Thanks; will queue.
