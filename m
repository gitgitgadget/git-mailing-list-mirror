From: David Greene <greened@obbligato.org>
Subject: [PATCH v2] Test rebase -Xsubtree
Date: Sun, 10 Jan 2016 17:08:16 -0600
Message-ID: <1452467297-16868-1-git-send-email-greened@obbligato.org>
References: <1451968805-6948-2-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net,
	sunshine@sunshineco.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 00:08:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIP6G-0004Vt-St
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 00:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594AbcAJXIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 18:08:35 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53781 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757233AbcAJXIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 18:08:34 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIP7C-0004uE-As; Sun, 10 Jan 2016 17:09:38 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1451968805-6948-2-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283624>


Version 2 of the patch to test and expose problems with rebase -Xsubtree.
I've included an additional failure mode John reproduced and responded
to the comments from Eric.  The tests still check the last commit message
for correctness because I'm not sure what would work better.  I'm open
to learning new tricks.  :)

                       -David
