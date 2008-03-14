From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 09:01:06 -0700
Message-ID: <7vd4pxqoql.fsf@gitster.siamese.dyndns.org>
References: <20080308171726.GA16129@localhost>
 <alpine.LSU.1.00.0803081850470.3975@racer.site>
 <20080313125229.GA24758@localhost>
 <alpine.LSU.1.00.0803131607030.1656@racer.site>
 <20080313192246.GA30361@localhost>
 <alpine.LSU.1.00.0803132216580.4174@racer.site>
 <20080313224741.GA5000@localhost> <7vhcf9r4qp.fsf@gitster.siamese.dyndns.org>
 <20080314121752.GB3315@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:03:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCLy-0007nf-Dx
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 17:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbYCNQBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYCNQBO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 12:01:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYCNQBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 12:01:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A4A6F1336;
	Fri, 14 Mar 2008 12:01:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0F1A21330; Fri, 14 Mar 2008 12:01:08 -0400 (EDT)
In-Reply-To: <20080314121752.GB3315@localhost> (Clemens Buchacher's message
 of "Fri, 14 Mar 2008 13:17:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77249>

Clemens Buchacher <drizzd@aon.at> writes:

>> Reading the rest of the function, I notice that it consistently favor "a"
>> over "b", when a conflict cannot be reconciled.
>
> Indeed. I think "b" should be favored over "a", however.

Why?
