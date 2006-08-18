From: David Rientjes <rientjes@google.com>
Subject: [RFC] adding support for md5
Date: Thu, 17 Aug 2006 23:01:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 18 08:01:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDxQZ-0003XT-9b
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 08:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWHRGBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 02:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWHRGBw
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 02:01:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:28149 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964851AbWHRGBw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 02:01:52 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7I61koV026331
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 23:01:47 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=GeMJXmeSnnGN0wTnRzj1+belgX6rBj1QxpwSmt9AJByzNx0wvmN0eW4vAVFHnnXBq
	Ly4tjnX6/IoqAcPFETSeA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7I61i0l021794
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 23:01:44 -0700
Received: by localhost (Postfix, from userid 24081)
	id B61B687D71; Thu, 17 Aug 2006 23:01:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id B102287D70
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 23:01:44 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25632>

I'd like to solicit some comments about implementing support for md5 as a 
hash function that could be determined at runtime by the user during a 
project init-db.  md5, which I implemented as a configurable option in my 
own tree, is a 128-bit hash that is slightly more recognized than sha1.  
Likewise, it is also available in openssl/md5.h just as sha1 is available 
through a library in openssl/sha1.h.  My patch to move the hash name 
comparison was a step in this direction in isolating many of the 
particulars of hash-specific dependencies.

		David
