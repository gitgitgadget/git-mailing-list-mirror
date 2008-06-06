From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 06 Jun 2008 09:46:36 -0700
Message-ID: <7vej7av7df.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer>
 <alpine.DEB.1.00.0806060006370.21190@racer>
 <7vve0nw4b7.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806061441120.1783@racer>
 <7vr6bav8ww.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806061735550.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4f6X-0005BU-Uy
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 18:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080AbYFFQqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 12:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759079AbYFFQqr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 12:46:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758995AbYFFQqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 12:46:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2D1A1F47;
	Fri,  6 Jun 2008 12:46:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E8C0E1F46; Fri,  6 Jun 2008 12:46:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806061735550.1783@racer> (Johannes
 Schindelin's message of "Fri, 6 Jun 2008 17:37:50 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 259910B8-33E8-11DD-AC63-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84090>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Only in hindsight do I realize that I could have increased the context, 

Yeah, I was thinking about suggesting that, using -U7 or something before
dumping the output to the editor.
