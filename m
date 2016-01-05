From: David Greene <greened@obbligato.org>
Subject: [PATCH] Test rebase -Xsubtree
Date: Mon,  4 Jan 2016 22:40:04 -0600
Message-ID: <1451968805-6948-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 05:41:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGJQc-00013w-I2
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 05:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbcAEEkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 23:40:24 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45841 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753913AbcAEEkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 23:40:21 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aGJQk-0000AE-H6; Mon, 04 Jan 2016 22:41:10 -0600
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283348>

Here is a test that finds a bug in rebase -Xsubtree.  With
--preserve-merges, commits are lost.

                    -David
