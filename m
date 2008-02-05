From: Junio C Hamano <gitster@pobox.com>
Subject: Re: man pages are littered with .ft C and others
Date: Tue, 05 Feb 2008 01:59:50 -0800
Message-ID: <7vy79zbu5l.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
	<m34pcr6vnm.fsf@localhost.localdomain>
	<7vejbuxwpu.fsf@gitster.siamese.dyndns.org>
	<200802031139.48752.jnareb@gmail.com> <20080204220120.GA23798@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Adam Flott <adam@npjh.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 05 11:00:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMKbV-00060a-26
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbYBEKAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbYBEKAE
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:00:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbYBEKAC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:00:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF6D4F08;
	Tue,  5 Feb 2008 05:00:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 884194F02;
	Tue,  5 Feb 2008 04:59:53 -0500 (EST)
In-Reply-To: <20080204220120.GA23798@diku.dk> (Jonas Fonseca's message of
	"Mon, 4 Feb 2008 23:01:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72639>

Jonas Fonseca <fonseca@diku.dk> writes:

> I was able to solve this problem with this patch, which adds a XSL file
> used specifically for DOCBOOK_XSL_172=YesPlease and where dots and
> backslashes are escaped properly so they won't be substituted to the
> wrong thing further down the "DocBook XSL pipeline". Doing the escaping
> in the existing callout.xsl breaks v1.70.1. Hopefully v1.73 will end
> this part of the manpage nightmare.

I checked this with 1.71, 1.69 and 1.72 (with DOCBOOK_XSL_172).
It seems not to regress.

Applied to 'master'.  Thanks.
