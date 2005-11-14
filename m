From: "Craig Schlenter" <craig@codefountain.com>
Subject: Re:  Balanced packing strategy
Date: Mon, 14 Nov 2005 05:03:06 +0000
Message-ID: <W4340426396265721131944586@webmail12>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 14 06:03:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbWVB-0001IH-Cr
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 06:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVKNFDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 00:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVKNFDO
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 00:03:14 -0500
Received: from mail.networksolutionsemail.com ([205.178.146.50]:38599 "HELO
	mail.networksolutionsemail.com") by vger.kernel.org with SMTP
	id S1750915AbVKNFDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 00:03:14 -0500
Received: (qmail 24855 invoked by uid 78); 14 Nov 2005 05:03:06 -0000
Received: from unknown (HELO webmail12) (205.178.146.50)
  by 10.49.34.58 with SMTP; 14 Nov 2005 05:03:06 -0000
Received: from 196.34.54.66 (unverified [196.34.54.66])
          by webmail12 (VisualOffice 4.01)
          with WEBMAIL id 26572;
          Mon, 14 Nov 2005 05:03:06 +0000
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
Importance: Normal
Sensitivity: Normal
X-Mailer: Mintersoft VisualOffice, Build 4.01.1003
X-Originating-IP: [196.34.54.66]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11767>

Hi

> From: Josef Weidendorfer [mailto:Josef.Weidendorfer@gmx.de]
> [snip]
> AFAICS, the git native protocol (which is nothing more than a pack itself
> for each transfer) even has this problem, too: If you are updating every
> day via git native, the sum of transfered bytes in a month will be a
> multiple of one git transfer for all the month's changes.

Interesting ... is this because in a bigger pack the compression will
be better as there is probably more stuff to "delta" against?

--Craig
