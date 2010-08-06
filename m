From: Joshua Shrader <jshrader83@gmail.com>
Subject: Decompressing a tree to a location other than the working directory
Date: Fri, 6 Aug 2010 14:43:21 -0400
Message-ID: <AANLkTi=RjcQ_-PNUt781jhYEA-8krqXpdHRenVyR_Rc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joshua Shrader <jshrader83@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 06 20:43:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhRtQ-0000V8-SM
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 20:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761687Ab0HFSn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 14:43:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55723 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761670Ab0HFSnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 14:43:23 -0400
Received: by vws3 with SMTP id 3so6395508vws.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=JSe4fTzqpOesRIoTJb0ZxeMcO/uWNQQhsjaYOOZGJJ4=;
        b=GrLjVCCi7r6YSgZmdMbSVmLJJRtQcntPqGE60GML6Nru8dhU6Zndz8sEypHap6/QK8
         noqD0VaaO9dLvTLc770n6nTjBgd6c4LD9/CMkXoNS7VdM4LYr8gRyXWbSr/I2LsQCTGb
         2zcNZEn1C608hDPSymcH+vxaAZ+v1uxrK9xnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=DOZ8lsqVUWLcjh4Lq2HyJ3rX0bf3LpM35nNuSzGa4U+Z3/F+VaVx6YeYZwA3tEQF7i
         M/r8SlaUvtNB/3qbRezyEci86Ybtj8hXeVtJR57ot6D+qS6fYDKIXuZ0NirAUY5AXnpU
         dtPZeaKh0gll3vROqgpkHA4xKfKQK5/sQj4mA=
Received: by 10.220.166.71 with SMTP id l7mr8565990vcy.149.1281120201957; Fri, 
	06 Aug 2010 11:43:21 -0700 (PDT)
Received: by 10.220.171.139 with HTTP; Fri, 6 Aug 2010 11:43:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152801>

git checkout allows one to checkout a particular version of a certain
path in the working directory.  Are there accessible plumbing commands
that can be used to accomplish the same thing, but change the target
directory.  For example, if I wanted to checkout a certain path, but
wanted to check it out somewhere external to my working directory /
repository?

Thanks,

Josh
