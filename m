From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] threaded pack-objects: Use condition variables for thread communication.
Date: Sun, 16 Dec 2007 14:12:31 -0800
Message-ID: <7vy7bui90w.fsf@gitster.siamese.dyndns.org>
References: <200712160018.54171.johannes.sixt@telecom.at>
	<200712161941.38109.johannes.sixt@telecom.at>
	<20071216190016.GC4999@xp.machine.xx>
	<200712162045.34456.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Dec 16 23:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J41jX-000345-I5
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 23:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012AbXLPWMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 17:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759178AbXLPWMw
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 17:12:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000AbXLPWMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 17:12:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 10B0753FB;
	Sun, 16 Dec 2007 17:12:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 94AC553FA;
	Sun, 16 Dec 2007 17:12:38 -0500 (EST)
In-Reply-To: <200712162045.34456.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 16 Dec 2007 20:45:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68494>

Looks nice and I think the clean-up makes the logic easier to follow as
well.
