From: Keshetti Mahesh <keshetti.mahesh@gmail.com>
Subject: git error : Unable to write new index file
Date: Fri, 28 Aug 2009 15:36:39 +0530
Message-ID: <829ded920908280306p50ec375dr90f6593fc6b9ea06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 12:07:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgyMN-0005tJ-PB
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 12:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZH1KG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 06:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZH1KG5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 06:06:57 -0400
Received: from mail-px0-f174.google.com ([209.85.216.174]:45075 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbZH1KG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 06:06:56 -0400
Received: by pxi4 with SMTP id 4so1868897pxi.21
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=I/7aCn43ShInzFT7bcBmqNSEBiHUMdQTpZVkQISPfjs=;
        b=DiQqzXQEf+dcrWgt6PQxnAFZXyKZszAflfNFaU1YyqQi/3UuiQvMeXKrvTr1MFpjZH
         X19lOoLAVjrUylyqnvnvBHUGEq2p3LA8qfIW4AIqlhyC+BeWa9Jw+BnsJx4+40MAnFP5
         hpnYcHBuBjy5SkJHx9TF8l8zCVrDc+vC+U7h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=dqrqNgAg1t+9ch7mZuKw0o6g2LzMRE3yl/oM4eeuneFZpeyXgZb0dAi6EG2uXXLLOZ
         hvQNqAUReMvwNGs1zFCX4fmyN3rb+Pxeb9GJdfLwwhqyF0VX9Txm7ko6njtkLPNtWqew
         7V5CLbhCXnYkkgiGYp7JQDeoKdP/OHg/ARtzk=
Received: by 10.140.162.16 with SMTP id k16mr465522rve.208.1251454019081; Fri, 
	28 Aug 2009 03:06:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127284>

Hello all,

I have just started using git for a small project. I have
created empty repository using "git init" and it worked fine.
But after that when I have tried to add a file to the repository
using "git add <file_name>", I am getting the below error.

> fatal: Unable to write new index file

The same error appears not only when adding files but also
whenever I add something (file, branch etc. ) to git repository.

I am using git on windows using cygwin and I have all permissions
(rwx) in the directory where I am running this command. Can anyone
please help me in resolving this issue ?

Thanks,
Mahesh
