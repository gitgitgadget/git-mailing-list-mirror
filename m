From: Timur Tabi <timur@freescale.com>
Subject: How do I make git-format-patch reject 8-bit encodings?
Date: Mon, 21 Feb 2011 16:11:33 -0600
Organization: Freescale
Message-ID: <4D62E315.7040506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 23:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prdyp-00072U-Il
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 23:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab1BUWLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 17:11:41 -0500
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:6145
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752544Ab1BUWLj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 17:11:39 -0500
Received: from mail72-db3-R.bigfish.com (10.3.81.249) by
 DB3EHSOBE002.bigfish.com (10.3.84.22) with Microsoft SMTP Server id
 14.1.225.8; Mon, 21 Feb 2011 22:11:38 +0000
Received: from mail72-db3 (localhost.localdomain [127.0.0.1])	by
 mail72-db3-R.bigfish.com (Postfix) with ESMTP id 234894C022C	for
 <git@vger.kernel.org>; Mon, 21 Feb 2011 22:11:38 +0000 (UTC)
X-SpamScore: 0
X-BigFish: VS0(zzzz1202hzzz2dh2a8h637h668h66h)
X-Spam-TCS-SCL: 5:0
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:de01egw01.freescale.net;RD:de01egw01.freescale.net;EFVD:NLI
Received: from mail72-db3 (localhost.localdomain [127.0.0.1]) by mail72-db3
 (MessageSwitch) id 1298326297723303_3049; Mon, 21 Feb 2011 22:11:37 +0000
 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.251])	by
 mail72-db3.bigfish.com (Postfix) with ESMTP id 7AC1FE4004D	for
 <git@vger.kernel.org>; Mon, 21 Feb 2011 22:11:37 +0000 (UTC)
Received: from de01egw01.freescale.net (192.88.165.102) by
 DB3EHSMHS009.bigfish.com (10.3.87.109) with Microsoft SMTP Server (TLS) id
 14.1.225.8; Mon, 21 Feb 2011 22:11:35 +0000
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1LMBYGn004498	for <git@vger.kernel.org>; Mon, 21 Feb 2011 15:11:34 -0700
 (MST)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id p1LMBXf7019982	for
 <git@vger.kernel.org>; Mon, 21 Feb 2011 16:11:33 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101213 Fedora/2.0.11-1.fc13 SeaMonkey/2.0.11
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167507>

Is there any way to get git-format-patch to refuse to create a patch that has
8-bit characters in it?  That is, if a given commit somehow has an 8-bit
character (e.g. utf-encoded), then I want git-format-patch to refuse to create a
patch for that commit.

Also, how can I do the same thing with git-send-email?  That is, if the patch
requires an 8-bit encoding, how do I get it to refuse to send the patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
