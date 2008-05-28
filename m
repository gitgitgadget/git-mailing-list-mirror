From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] t5700-clone-reference: Quote $U
Date: Tue, 27 May 2008 21:29:41 -0700
Message-ID: <7vlk1vxd8q.fsf@gitster.siamese.dyndns.org>
References: <1211873782-28487-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed May 28 06:31:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1DJu-0000J8-Kf
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 06:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbYE1E35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 00:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbYE1E34
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 00:29:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYE1E34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 00:29:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 568625CE3;
	Wed, 28 May 2008 00:29:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BAB235CE2; Wed, 28 May 2008 00:29:48 -0400 (EDT)
In-Reply-To: <1211873782-28487-1-git-send-email-johannes.sixt@telecom.at>
 (Johannes Sixt's message of "Tue, 27 May 2008 09:36:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B73FC538-2C6E-11DD-935D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83069>

Good eyes.  "! grep $pattern $U" was failing not because we did not emit the
pattern but because we passed a bogus unquoted $U.
