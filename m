From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: actually check for a dirty index
Date: Sun, 02 Mar 2008 23:11:02 -0800
Message-ID: <7vablgjn95.fsf@gitster.siamese.dyndns.org>
References: <20080302064449.GA6334@coredump.intra.peff.net>
 <20080302072252.GA14214@coredump.intra.peff.net>
 <20080302103753.GB2973@steel.home>
 <20080303063055.GA24866@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4qG-0008GE-FW
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbYCCHLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 02:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbYCCHLb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:11:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbYCCHLb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:11:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 046B311F6;
	Mon,  3 Mar 2008 02:11:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3212B11F3; Mon,  3 Mar 2008 02:11:24 -0500 (EST)
In-Reply-To: <20080303063055.GA24866@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 3 Mar 2008 01:30:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75897>

Looks good.  I think we want to have the fix in 1.5.4 maintenance series
as well, so I'll backport it to 'maint' and merge it up to 'master'.
