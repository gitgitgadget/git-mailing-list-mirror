From: Amos King <amos.l.king@gmail.com>
Subject: [PATCH][v2] http authentication via prompts (with correct line 
	lengths)
Date: Tue, 17 Mar 2009 00:15:12 -0500
Message-ID: <d8c371a80903162215k4c27762cva650ea64d7850afa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 06:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjRfU-0001Kt-Hj
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 06:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZCQFPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 01:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZCQFPQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 01:15:16 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:43800 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbZCQFPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 01:15:14 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2881055qwi.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=LX54FV6gcJgfXyvaycBdCdrvkrfa5ALGnu4gYslmwvY=;
        b=ml3Cuwo8C7YSCVq+bsMKAFjmSFMgzbIeLzMFSw+0gjDLPD0M/HfgNEkFKdMbJQiVfU
         SkBdwUJ19tyQqcQDy7MQ9MfgMmvH9uxYiu/i5WOYYhsILHlp4m8KngOTBOF9/sS9noFR
         FsTUl741vv53s4O4Q85EwMpsLQPqhFdIZImVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ovGo/8Hq+h4zuWPCsZXk5FqISc7oWRPUO46jmCB6LnCBzjx01mb/mzObkXro9NNINu
         EmhfbWmpNFV9qFWNEr5bIPEt/YYeQrdOB3bdPbyZn1/IhZ9cD4k2C8+Pef0uoL8uEb0D
         2PfjtVHXZMZ3DLCDs4mWYSbxwNVFSyYIpN88k=
Received: by 10.229.81.136 with SMTP id x8mr1790874qck.49.1237266912692; Mon, 
	16 Mar 2009 22:15:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113419>

Junio,

I'm working with Mike on the http auth stuff, and I was testing out
your patch.  I can get it to work for fetch but push is giving me some
grief.  Looking through the code I noticed that online 219 of
http-push.c that http_init is being called with NULL instead of a
remote.  If I pass in the remote then there is no remotre-url.  I've
been digging around and can't find where or when that is being set.
It has been a while since I worked with C but I'd love to jump in and
help out here.  Can you point me in the right direction to get the
remote->url[0] set for the http_auth_init to use?

Thanks,

-- 
Amos King
http://dirtyInformation.com
http://github.com/Adkron
--
Looking for something to do? Visit http://ImThere.com
