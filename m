From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-mailinfo strip whitespace from the start of the mail file.
Date: Thu, 01 Nov 2007 14:33:31 -0700
Message-ID: <7vd4utabx0.fsf@gitster.siamese.dyndns.org>
References: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Simon Sasburg <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhfl-00021g-E4
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbXKAVdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbXKAVdi
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:33:38 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:51121 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbXKAVdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:33:37 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 690232F2;
	Thu,  1 Nov 2007 17:33:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id F278091261;
	Thu,  1 Nov 2007 17:33:54 -0400 (EDT)
In-Reply-To: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com> (Simon
	Sasburg's message of "Thu, 1 Nov 2007 22:05:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63012>

Just to help me understand why this change is needed...

Are you using mailinfo directly without splitting with mailsplit
first?
