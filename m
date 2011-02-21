From: Ping Yin <pkufranky@gmail.com>
Subject: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 15:50:09 +0800
Message-ID: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 08:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrQXK-0000A8-RR
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 08:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab1BUHuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 02:50:11 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36787 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1BUHuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 02:50:10 -0500
Received: by gyb11 with SMTP id 11so140779gyb.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 23:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=2AxbM9F7lwdZss+wC9n9JKqA4A9Yb9sonXH9+8rPAkE=;
        b=KZYfmPwtG0T8rT3a/ZUqAOcLMfh3DBg+v2/q9qZiqaYlXI2VHH2AFUqv5R4YcqsreQ
         SBoSnzfT84hQUy9I9WGl7GTvddZ3KPWqw7CRgztXhn6KlUoVErCuDxpKWJ+HQlmnibuV
         OBq6HU3ZBKmf5983kwp4jBBJTXqQtWNe3rbG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DwZfKqtzZdeETADIoqjwnJrIXF4Yj9rOp4fN/Z5YEJZ6S2SrLH42ylzowugpK9txP2
         73a+I0gVHMKsi+B9R9Lx81XdczvoorLj+F+geRmHCEI1awYMExYx2Z+L1w7zO7CRl/nF
         mUxBadJCnfiawcbgraO2S3q91dxMySBBxoFQM=
Received: by 10.150.198.11 with SMTP id v11mr1312863ybf.388.1298274609129;
 Sun, 20 Feb 2011 23:50:09 -0800 (PST)
Received: by 10.146.168.17 with HTTP; Sun, 20 Feb 2011 23:50:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167447>

I have a corrupted git repo, with "git fsck", it shows

missing blob b71eb55f2dbc97dafd4a769fc61f346e69a5e0af
missing blob 282035f3ae964e1e288f352c370be8edd11d3078
missing tree 3c20f556eecc476e3542cc522d46a62a4461fec6
missing blob f321b578edeb452358497e832815d6cae6b36886
missing commit 6d23f5084c975be637f7d748db82116bf84d3872

And i also have a good backup repo. How can i recover the corrupted
repo with the backup repo?

I can do a rsync or fresh "git clone", however, is there any git
related commands to incrementally do this?

btw, "git remote add and then git fetch" doesn't work, it reports

error: refs/heads/bringup does not point to a valid object!
error: refs/heads/fsl_imx_r9.3 does not point to a valid object!
error: refs/heads/bringup does not point to a valid object!
error: refs/heads/fsl_imx_r9.3 does not point to a valid object!
error: refs/heads/bringup does not point to a valid object!
error: refs/heads/fsl_imx_r9.3 does not point to a valid object!
error: refs/heads/bringup does not point to a valid object!
error: refs/heads/fsl_imx_r9.3 does not point to a valid object!
error: missing object referenced by 'refs/tags/v2.6.32'
error: missing object referenced by 'refs/tags/v2.6.32-rc1'
error: missing object referenced by 'refs/tags/v2.6.32-rc2'
