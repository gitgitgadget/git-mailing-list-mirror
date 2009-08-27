From: demerphq <demerphq@gmail.com>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 00:21:42 +0200
Message-ID: <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
References: <20090827203402.GC7168@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 00:22:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnLs-0006oE-Ui
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZH0WVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZH0WVm
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:21:42 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:63653 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbZH0WVl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 18:21:41 -0400
Received: by ewy2 with SMTP id 2so1660143ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=w4Bw9uaZmyAKujzeMx5SnXfFSu1oJrT8/LvkdlqipaQ=;
        b=ZdPt52NcqkGzierVRtQvd/wCF4CDpZj5uxX5ebGBmiwWHQOTfZM7UIRU2/zWG/SN8u
         J6AHGwgcbMF+Qy99HiB4nI75/0NTqkycC0pNDv5UgnnN6n29ZL1kaZAIyFs5xxzALpkX
         XpGR6i4G7vlB7bSmGG73fSxBrjTOQVVCmGFkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cf/r6lBP28sPbaR21JTbo0al5FLWG84k20CyTPnmkmOy4YDijkl461nAHzKTcR6+bA
         SChx64unrfNxFPEzyj3e9vdKYdk8aUQ2a/HeL3d7XCm35JLQ0iALoivuGhTTRTm+Ijxv
         8wXg0s/ynQ7byhrIZtAzV7NTZHyGf7UrrpVVI=
Received: by 10.216.52.76 with SMTP id d54mr71160wec.119.1251411702722; Thu, 
	27 Aug 2009 15:21:42 -0700 (PDT)
In-Reply-To: <20090827203402.GC7168@kisimul>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127226>

2009/8/27 seanh <seanh.nospam@gmail.com>:
> 2. They don't want to look at the latex source but the PDFs built from
> it, which they're going to annotate with their comments. So I need an
> easy way for them to get the PDF of each commit from gitweb without
> having to checkout the repo and build it themselves. Normally I
> wouldn't commit the PDF files into the repo because they're compiled
> files not source files, but it seems that just building a PDF and
> committing it along with each commit to trunk would be by far the
> easiest way to achieve this. But will git store the PDFs efficiently, or
> will the repo start to get really big?

As you can generate the PDF's from the latex then just hack gitweb to
let them download it from there.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
