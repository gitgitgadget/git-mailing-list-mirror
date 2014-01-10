From: Francis Moreau <francis.moro@gmail.com>
Subject: git-log --cherry-pick gives different results when using tag or tag^{}
Date: Fri, 10 Jan 2014 14:15:40 +0100
Message-ID: <52CFF27C.1090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 14:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1bvH-0003AG-T1
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 14:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbaAJNOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 08:14:48 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:56379 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaAJNOr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 08:14:47 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so4122082wes.27
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 05:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=FwQRLnpY34Rj7FcP7MjRGff0MOKHErw1bHAN01JXXmw=;
        b=tHElxyoXE4DNjbpam3pw7HgfDMUxAVoaIubAdxPAL6dB3UDqpcAgxVUEgc/jEuJ6F3
         sHHR8N5QwZ+tNQuuyXfpTzdJ5CHuqChr9gZaDdmXvTUD7+NO3HVrcppiDUepvtf+nXlO
         +sXqJo0e9nehF3AXQi86n6MsxYSOeYY1AJkvJSikd0eyLg+/W1Eo/2vG+j64K9XkiwZK
         ss3I83q499EMqe+FamksbujMLQpofCtUX1r3awnxpoynsT00/lShXT17nDwXRXPogE9q
         ELfsLapmTQZmGTjcS8kaD98USOcnFD/b++JVQXIU+LzArq5eR7kCyymOMSKOJ3AO36mf
         3Zbw==
X-Received: by 10.194.234.65 with SMTP id uc1mr8523173wjc.39.1389359685941;
        Fri, 10 Jan 2014 05:14:45 -0800 (PST)
Received: from [192.168.7.31] (au213-1-82-235-205-153.fbx.proxad.net. [82.235.205.153])
        by mx.google.com with ESMTPSA id jw4sm4106834wjc.20.2014.01.10.05.14.44
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 Jan 2014 05:14:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240302>

Hello,

In mykernel repository, I'm having 2 different behaviours with git-log
but I don't understand why:

Doing:

    $ git log --oneline --cherry-pick --left-right v3.4.71-1^{}...next

and

    $ git log --oneline --cherry-pick --left-right v3.4.71-1...next

give something different (where v3.4.71-1 is a tag).

The command using ^{} looks the one that gives correct result I think.

Could anybody enlight me ?

Thanks.
