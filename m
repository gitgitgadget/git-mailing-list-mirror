From: Stephen Bannasch <stephen.bannasch@gmail.com>
Subject: problem installing egit into eclipse
Date: Fri, 4 Apr 2008 16:45:40 -0400
Message-ID: <p06240809c41be6319c48@[63.138.152.125]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 22:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhsny-0001db-MZ
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 22:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbYDDUpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 16:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbYDDUpv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 16:45:51 -0400
Received: from hs-out-0708.google.com ([64.233.178.243]:40018 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYDDUpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 16:45:50 -0400
Received: by hs-out-0708.google.com with SMTP id 4so184029hsl.5
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:message-id:date:to:from:subject:content-type;
        bh=YOFkaqWeFGLnmI+S7B+rLattlElw0W0fLnPDoW4fYPk=;
        b=JeZOl9hm6MYp/ywZyebS80WOO+LF4g81rsCB0Nj5Jpe42PuDTrKE+DeLD41SnFoOB1HierV0OvI64rzacfRAeJUGB6IeXzlErLhAbZhNdSNnvgW4lV6n21uNAyjXyd27FdKUqHLEO1uEotBcSj3eN49pJcflzjFfgWltWIPbBYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:message-id:date:to:from:subject:content-type;
        b=bD8qVL4bcPMNk1uJFtOpUXir2kaz7U9KRaIeHoQ7cScwX36CuGmmJqwCt4nitdOOJ0v3KekbaEF6mZi4X9jE4V5CNt9/YOWfCiAEELKmNpg6Xymu714B0FrUdcHpboOoiJeLV7KUJli1gxsRGWuHSLS/eqOIChDWEwK7oxTdnWs=
Received: by 10.100.48.16 with SMTP id v16mr3952135anv.52.1207341947928;
        Fri, 04 Apr 2008 13:45:47 -0700 (PDT)
Received: from ?63.138.152.125? ( [63.138.152.170])
        by mx.google.com with ESMTPS id 5sm6851868agc.14.2008.04.04.13.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Apr 2008 13:45:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78816>

I've been able to build egit but I'm getting these errors when I 
Export the Deployable plug-ins and fragments to my eclipse folder.

BUILD Failed
java.lang.IllegalArgumentException
BUILD Failed
java.lang.IllegalArgumentException

There wasn't anything in the eclipse console so I wasn't exactly sure 
where the java.lang.IllegalArgumentException was being generated.

I'm using Eclipse 3.3.0, MacOS 10.5.2

egit cloned today from git://repo.or.cz/egit.git

No problems building egit in Eclipse.

Tried building egit using Java 1.5.0_13 and Java 1.6.0.

-- 
- Stephen Bannasch
   Concord Consortium, http://www.concord.org
