From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch problem or was master on kernel.org reset?
Date: Mon, 18 Aug 2008 11:25:26 -0700
Message-ID: <7v3al2npt5.fsf@gitster.siamese.dyndns.org>
References: <20080818172615.GA6014@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 20:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV9R8-0007BE-WC
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 20:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYHRSZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYHRSZf
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 14:25:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbYHRSZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 14:25:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B0D256C3F;
	Mon, 18 Aug 2008 14:25:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B31DF56C3E; Mon, 18 Aug 2008 14:25:28 -0400 (EDT)
In-Reply-To: <20080818172615.GA6014@blimp.local> (Alex Riesen's message of
 "Mon, 18 Aug 2008 19:26:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A3A55C6-6D53-11DD-8280-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92724>

Alex Riesen <raa.lkml@gmail.com> writes:

> The commit ea02eef096d4bfcbb83e76cfab0fcb42dbcad35e is the current
> value of master (on kernel.org). But it definitely was
> 2ebc02d32a4360da2cf69c2b5f5bfad0716d42b0 some time before (at 11:42)!

I suspect that one of the mirrors still had ea02ee (1.6.0) when you made
the above observation, after 2ebc02 (Start 1.6.1) was pushed into.
According to my push log, "1.6.0" was pushed on 14:04 and "Start 1.6.1" on
19:47 (both on 2008-08-17, US/Pacific).

Currently all git://git[1-4].kernel.org/pub/scm/git/git.git/ mirrors seem
to have the correct 2ebc02.(Start 1.6.1).
