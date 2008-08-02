From: Junio C Hamano <gitster@pobox.com>
Subject: Missing pieces for 1.6.0 on MinGW?
Date: Sat, 02 Aug 2008 12:05:04 -0700
Message-ID: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Aug 02 21:06:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPMQh-0003cg-DL
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 21:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbYHBTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 15:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYHBTFN
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 15:05:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYHBTFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 15:05:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C148245660;
	Sat,  2 Aug 2008 15:05:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 37A184565F; Sat,  2 Aug 2008 15:05:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDF0D780-60C5-11DD-BBF5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91169>

Just a quick question before the weekend ends and -rc2 gets tagged.  (I
lost track of that argv0 vs bin/git vs libexec/git-core/git-foo
discussion).

Are there any missing but necessary patches we need before 1.6.0 for
MinGW?
