From: Thomas Anderson <zelnaga@gmail.com>
Subject: moving a remote branch?
Date: Wed, 16 Jun 2010 23:35:00 -0500
Message-ID: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 06:44:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP6xT-00050W-MZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 06:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155Ab0FQEm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 00:42:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33108 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0FQEm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 00:42:56 -0400
Received: by pva4 with SMTP id 4so1021479pva.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 21:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=0+WmsaV3I5IdnmgWuQ2STK9QrLSpveWaTIpOK4BpWsY=;
        b=aYY8W+gbBjLDX1FN9T4LNCwVgONilOvw/vy5j5ta65Qy1N4sRB/Gl0e5+Gh39K0htW
         ZTw5NZoZFio67iXxbXxYW/2HdKIdIb0YRrRTBhfgYN07DLtuQ7ZAVXipD9t6DWdAsB47
         HCyyFD4nrWN0lNdjyBZ0c+pzZsignwFQbyDkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Wnm1nTHRg/CgGRbu0vheoEvzZqUi++PUFYr2fjhxH2olBnMR2NGh/pKFoPYfvqWehw
         NR99/a6hIUKjZ1ovZd7CFnUpVPjK8IAnykAH5aXhUsTZ/mlGYBB3bqq5dlwW4ZBc37BS
         WXKSeGQFBuSEs5VUBNibLB7Ak5ndctOVF/aUQ=
Received: by 10.142.248.7 with SMTP id v7mr9152wfh.234.1276749300779; Wed, 16 
	Jun 2010 21:35:00 -0700 (PDT)
Received: by 10.142.87.4 with HTTP; Wed, 16 Jun 2010 21:35:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149289>

git branch -m origin/zelnaga/featurea origin/zelnaga/featureb doesn't
seem to be working for me.  Instead, I get this error:l

error: refname refs/heads/origin/zelnaga/featurea
fatal: Branch rename failed

Any ideas?
