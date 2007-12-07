From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-am: catch missing author date early.
Date: Thu, 06 Dec 2007 22:06:13 -0800
Message-ID: <7vk5nr82ei.fsf@gitster.siamese.dyndns.org>
References: <200712062134.47330.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 07:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0WQa-0001vz-FV
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 07:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbXLGGKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 01:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbXLGGKq
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 01:10:46 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbXLGGKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 01:10:45 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2007 01:10:45 EST
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A8D2645;
	Fri,  7 Dec 2007 01:06:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A642644;
	Fri,  7 Dec 2007 01:06:26 -0500 (EST)
In-Reply-To: <200712062134.47330.lenb@kernel.org> (Len Brown's message of
	"Thu, 6 Dec 2007 21:34:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67382>

Sorry, and thanks for the report.

Jens complained the same yesterday and the change was reverted.
