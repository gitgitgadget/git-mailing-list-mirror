From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/11] Introduce stream decompress helpers
Date: Sun, 03 Feb 2008 18:07:10 -0800
Message-ID: <7v3as9o4oh.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-3-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-4-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-5-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-6-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-7-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqkp-0007SB-Mr
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 03:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbYBDCHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 21:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbYBDCHa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 21:07:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbYBDCH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 21:07:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03472197D;
	Sun,  3 Feb 2008 21:07:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EFA9197B;
	Sun,  3 Feb 2008 21:07:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72451>

Overall, everything looks quite nicely done.

The same comments as the compression side to "*_alloc()" apply.
Perhaps call them "setup" and "finalize" or something?
