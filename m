From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Reducing the memory footprint
Date: Fri, 9 Nov 2007 18:38:00 -0500
Message-ID: <9e4733910711091538h260fbcd2s5783f01e7db4b19a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdQg-0005GZ-7e
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759368AbXKIXiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbXKIXiE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:38:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:42981 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbXKIXiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:38:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so760585wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 15:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=uPhxN68Kx6BPUAyIPfdkguHnCNdRIclTQjQuAR8M3wU=;
        b=p58Xsjcskcc4AviDeP49UdE81ycowKOGhpcj05K+gwxe8V7GpPpOE/dLbFV4fWakDB6sDGO5OJdAMsPL0u7x4n7f35FgUL5jJAw27Y97w134Ca4daDrAhYpeWtzGX7qG2O5Vqh0eJzWQutLAcIV9XRUhsGFJ19IyUa2xiHyI/F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mJ+V2ltZvaYgfsYVMzMXD9J4VkSWtvqoTu++MCiLw7Bb4aJhP3TO8wPDuA0UzXU1LXo/YoOjIBCRd9naAxFAMlqDQvfYCaOzyoYbZzGzvnzDAx4Zjmdy7vmfykQUQMsbyjDB2HJ68bUZtiFSLlNZzQ5XmxLwro+t1QqdWHx8Lgc=
Received: by 10.114.59.1 with SMTP id h1mr62128waa.1194651480947;
        Fri, 09 Nov 2007 15:38:00 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 15:38:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64282>

I'm using this config file:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        packedGitWindowSize = 1M
        packedGitLimit = 1M
        deltaBaseCacheLimit = 1M
[pack]
        windowMemory = 1M
        deltaCacheSize = 1M

And I have NO_MMAP compiled in.

git is still using over 200MB of memory or address space, my process
gets killed either way.

Ideas on how to reduce the foot print more?

-- 
Jon Smirl
jonsmirl@gmail.com
