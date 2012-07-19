From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 09:30:59 +0200
Message-ID: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:31:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlCY-00010j-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab2GSHbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:31:05 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:65012 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab2GSHbD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2012 03:31:03 -0400
Received: by wgbfm10 with SMTP id fm10so4743699wgb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=LtR2Vz70+oetOlTB4/SWdp+kN19uzsHTT73A/Ty/VLk=;
        b=JSBYLg+2iPnHT13ERlKFAkR6HLYdb3EblcaopYYhnXyV77JDDmWoBK/d7ft7jEmRNg
         daHLJojsoTJEs2CIo0KMwCR8E8Px/B45UV3ADdBOppAQMfUrLnY8AgJw/p2yub9qkExo
         XOTkdivLVInROaUKBXgwMecnZRIhGuPIOHTSA4R9vOo1rrHi6ehNaSugRVw5cji5M6oe
         /9rjFaag+jxbMfM5PoisNjuRVrsykUNXd/kXUPzxMNScTlmlvr0xyz9hzw08Ua5XOUmP
         6T3V9wRBup1A8TrClojdWRtjhQ7sRr2B//QVOi+a35+d7l79tzTUsXDk9T6/NbfuSCf6
         uTxg==
Received: by 10.180.100.133 with SMTP id ey5mr2040987wib.4.1342683061920;
        Thu, 19 Jul 2012 00:31:01 -0700 (PDT)
Received: from [192.168.6.130] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id h9sm37060763wiz.1.2012.07.19.00.31.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:31:01 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201715>

Hello,

i would like

`git fetch --prune <remote>`

to be the default behavior of

`git fetch <remote>`

In fact, i think this is the only reasonable behavior.
Keeping copies of deleted remote branches after `fetch` is more confusing than useful.

(Excuse me if this question has already been discussed.)

Thank you.

Alexey Muranov.
