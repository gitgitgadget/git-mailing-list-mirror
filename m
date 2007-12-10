From: Clifford Heath <clifford.heath@gmail.com>
Subject: "remote end hung up unexpectedly"
Date: Mon, 10 Dec 2007 22:49:48 +1100
Message-ID: <CE1FB037-26E3-475E-9F9D-AC3874987B9C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 12:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1hAe-0007xO-LV
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 12:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbXLJLuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 06:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757730AbXLJLuP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 06:50:15 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:49768 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757702AbXLJLuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 06:50:13 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3306538wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 03:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        bh=F80Gn+kPkDIxuKF/pJfbFH5TAOl5gj/CXDwgQrNZPKQ=;
        b=BAxGqTOClayVSnwrPLMWQrQooVoR/EvhPOERKPOOUjv0INpBg0220UGWoGYvkMGUBcEOp+GdjGOCN86i3xMvBDFGvyTAiEaI1lu4hRMoaIgbXTx2GS/7zy55CQc3FjKBEWuPqgpVfnZoDSWBp1PHgJAKYGZn2M1likX1pWOmN8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=IFlUz6iNOQw482L9CaNsN2O2e476Gyowyn6mrzM41UVUrDDattsizhQt16qr0ApCHNbaAkX/PCscAI/B8A8WBdiJeVkFHWUKqy854aM9fVMo9DGPIgHPIMHK/NicXKhesc84zifjmxVL2J7qLf9Qe/0mY1zhmZrF6W0H2XzVvQE=
Received: by 10.114.66.2 with SMTP id o2mr1911962waa.1197287412521;
        Mon, 10 Dec 2007 03:50:12 -0800 (PST)
Received: from ?10.0.0.1? ( [122.107.155.136])
        by mx.google.com with ESMTPS id j6sm6283722wah.2007.12.10.03.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 03:50:11 -0800 (PST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67705>

Be patient with me, it's my first day on git... I like it better than  
svn already,
but I need a bit of help.

After cloning a remote repository, I wanted to update (rebase) an  
existing
remote branch to get the latest master commits, so I switched to it  
using
git checkout, then did a "git merge origin/master" and it updated my  
local
copy so it looked reasonable... I have changes to add to this branch,  
but
I wanted a proper base, so I did a "git commit" and a "git push". The  
push
gave me the above message.

I've checked ssh access (don't have shell) to the other side, my PK  
is set up.

What went wrong? How can I diagnose it further (-v doesn't help)

I understand that to add my further changes, I should set up a local  
branch
to track this updated remote branch. But I'm assuming that the rebase  
must
be done while switched to the remote branch...?

Clifford Heath.
