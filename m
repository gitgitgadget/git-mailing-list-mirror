From: "Troy Telford" <ttelford.groups@gmail.com>
Subject: Per-file force update
Date: Thu, 25 Jan 2007 10:17:13 -0700
Message-ID: <op.tmpzmzvtzidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 18:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8ES-0006g2-LE
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbXAYRRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbXAYRRU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:17:20 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:5731 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030471AbXAYRRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:17:18 -0500
Received: by nz-out-0506.google.com with SMTP id s1so469969nze
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 09:17:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=RAtMP/K8hs8eYhBvfOvbvZPVKJEGLUlCj9M0KBDT9PmaQRfPyquUMHwQlD3MbrhAZ8w05uR825+15S23TRrAQB73ZFSVAxGMhlemqtvdV8jLT7iWt4a+B60uI5SigKuwHv6nRgIX2kffzZSJKFGCLLJuelL0BnsMl/XPzIl020o=
Received: by 10.64.193.8 with SMTP id q8mr3338817qbf.1169745437910;
        Thu, 25 Jan 2007 09:17:17 -0800 (PST)
Received: from rygel.lnxi.com ( [63.145.151.2])
        by mx.google.com with ESMTP id q14sm2895189qbq.2007.01.25.09.17.16;
        Thu, 25 Jan 2007 09:17:17 -0800 (PST)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37745>

I've got a file that (due to some inner workings) changes whenever it's  
built.

This causes a problem with git, causing merge conflicts.

Is there a way I can configure git to /always/ do the equivalent of 'git  
pull -f', but only for that one file?

Thanks,
-- 
Troy Telford
