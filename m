From: "David A. Greene" <greened@obbligato.org>
Subject: Assorted contrib/subtree Patches
Date: Mon,  4 Feb 2013 22:06:00 -0600
Message-ID: <1360037173-23291-1-git-send-email-greened@obbligato.org>
To: James Nylen <jnylen@gmail.com>, git@vger.kernel.org,
	Techlive Zheng <techlivezheng@gmail.com>,
	Wayne Walter <wayne@tickzoom.com>,
	"Avery Pennarun \"" <apenwarr@gmail.com>,
	Jakub Suder <jakub.suder@gmail.com>,
	John Yani <vanuan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Zp0-0005eE-K9
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 05:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab3BEEHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 23:07:25 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:37992 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754307Ab3BEEHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 23:07:24 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U2ZpV-0003ZD-4c; Mon, 04 Feb 2013 22:08:21 -0600
X-Mailer: git-send-email 1.7.10.4
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  All of the patches I have received from others as well as
   a few of my own follow. Probably the most controversial is a patch to remove
    --annotate. After some discussion on the list it became clear that we really
    want a more general commit rewrite feature. Removing --annotate means we
   don't have to also support --unannotate and carry both forward as backward-compatibility
    baggage. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- ------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215440>

All of the patches I have received from others as well as a few of my
own follow.  Probably the most controversial is a patch to remove
--annotate.  After some discussion on the list it became clear that we
really want a more general commit rewrite feature.  Removing
--annotate means we don't have to also support --unannotate and carry
both forward as backward-compatibility baggage.

Before --annotate was added, git-subtree would force an annotation of
"*" on every split commit message.  It now does no such thing so
there's no need to unannotate anything.

Please review and integrate.  Thanks!

                        -David
