From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 01:54:48 -0400
Message-ID: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 07:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOS8G-0005oc-6Y
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 07:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbXHXFyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 01:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbXHXFyu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 01:54:50 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:31777 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbXHXFyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 01:54:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so571766rvb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 22:54:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BPrONgNueULcoIylMf08DNYS8RUQwqdf5aLro0+PJ31Vze1gzlXlLuReOsAwTKxmJZCCLbfUNO6yv4P80we9N/UDAVmEjfDzy42b3WzzQj3Ca4pq7YDN86tmEOhc/A3zFPKuogMrRUJWb/UxueGCSv5e95RwNl08iaNu8yYhtQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=prUGpVm2WFEvGlmPEGUXEeYpDwb373YFEQ7DV4kGvdvr+Nc8TbRdsypA2UcASMMyFnpfEYChFN4zx1KaSFKHYTvuuA5DdF4PkAR6xsZmOFETyRr7T9Mpe9TWttGNh0DVe6ktgWMf2PkUlzs18xrele+gbPbBDs4uVbxaJ0dgJC0=
Received: by 10.114.133.1 with SMTP id g1mr1090442wad.1187934888920;
        Thu, 23 Aug 2007 22:54:48 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Thu, 23 Aug 2007 22:54:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56547>

Any ideas on why git protocol clone is failing?

2007-08-24_20:51:33.85649 [9758] Connection from 72.74.92.181:19367
2007-08-24_20:51:33.85828 [9758] Extended attributes (33 bytes) exist
<host=git.jonsmirl.is-a-geek.net>
2007-08-24_20:51:33.96990 [9758] Request upload-pack for
'/home/git/mpc5200b.git'
2007-08-24_20:51:45.00789 fatal: Out of memory? mmap failed: Cannot
allocate memory
2007-08-24_20:51:45.08746 error: git-upload-pack: git-rev-list died with error.
2007-08-24_20:51:45.08771 fatal: git-upload-pack: aborting due to
possible repository corruption on the remote side.

NSLU2 ($70) is 266Mhz ARM with 32MB memory.
It's running Debian on a 250GB disk with 180MB swap.

Watching top the process runs up to about 60MB in virtual size and exits.
Setting the window down made no difference  packedGitWindowSize = 4194304

-- 
Jon Smirl
jonsmirl@gmail.com
