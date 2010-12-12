From: Hans-Christoph Steiner <hans@at.or.at>
Subject: native-style key bindings for gitk on Mac OS X
Date: Sun, 12 Dec 2010 17:08:42 -0500
Message-ID: <681947AB-F2D2-4EBC-A635-09E28FC27256@at.or.at>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 23:08:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRu65-0003hd-3C
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 23:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab0LLWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 17:08:43 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53524 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751510Ab0LLWIn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 17:08:43 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A6E3EAD3
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 17:08:42 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 12 Dec 2010 17:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date; s=smtpout; bh=jSsNcRhmRHX5xUKI1cQXNBgx924=; b=Z7R5UpG/YuQS7HQoXatwD2zD4D5Onwf4rl8samBWra6kpY5bOFOPdoKNEqnq+tUxmsriM7STJposMJqUGcvjGbkqNgXu8iSjI67OL4sJLNMpSHXa4ppUWEtZb4O4jUNiN9QpLrQAmjfrV8IrWD2iJ/nhnL82yGD4uGECkgM+Ur0=
X-Sasl-enc: diYJHS6Zr/qKe2bsGiBFf+WbpUWa7M9Nf65noitZRXFC 1292191722
Received: from palatschinken.lan (hq.nycresistor.com [216.254.98.120])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B2274045EA
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 17:08:42 -0500 (EST)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163494>


Hey all,

This is my first post here, hopefully I'm not doing anything  
stupid ;)  I use gitk on Debian, Ubuntu, and Mac OS X.  I'm big on  
having apps feel native on each platform. Currently gitk's key  
bindings are very GNU/Linux-ish when using gitk on Mac OS X.  I'd like  
to submit a patch to make gitk use native-style key bindings and re- 
use common key bindings.  F-keys are really rarely used on Mac OS X,  
so it drives me a little nuts using them in gitk/Mac OS X.

Before starting this, I just wanted to make sure this isn't some hotly  
debated political issue.

.hc


----------------------------------------------------------------------------

Man has survived hitherto because he was too ignorant to know how to  
realize his wishes.  Now that he can realize them, he must either  
change them, or perish.    -William Carlos Williams
