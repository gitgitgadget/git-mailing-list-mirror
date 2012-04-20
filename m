From: Samuel Maftoul <samuel.maftoul@gmail.com>
Subject: git clone submodules recursive and reference
Date: Fri, 20 Apr 2012 17:12:29 +0200
Message-ID: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 17:12:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFVj-0006VL-Ph
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 17:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307Ab2DTPMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 11:12:31 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61002 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127Ab2DTPMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 11:12:30 -0400
Received: by qcro28 with SMTP id o28so5902716qcr.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7NxpGT05hBPbrVrECcX7/+PhnpocNy2NHcMtD6NLBio=;
        b=0S5maJ2BjHP7DQSozuZ48ueZC9qHt1ZNr7NjpFTUx2YqLLxt+6LoQ8lFnqLvC0hIxu
         sc1DhSSoONJjzWwdwLBbodVJFT58M59AFK9u5fnqH8yoiqbJHQZPAkfrvk62wu2dZkC+
         sLoUOSdkT3+OtzrwzZqYviBrhV1z2TnPFg8ZE9wAGSv3nNC3137CtKJRQDOuVKq6lYAv
         o78+tCbtXw2DT6nCSeUoiTAyqGM+EbDEdQ0XlEp3VkNK07LQ7wA07DqATe9lcenZ6mH8
         RM4Otd0JObGwKugw4V3vazlT/j92O5goDl75iVLbYWu+zPBBWAnYJb8G52WfS3frPecy
         atQw==
Received: by 10.224.101.10 with SMTP id a10mr7441089qao.5.1334934749878; Fri,
 20 Apr 2012 08:12:29 -0700 (PDT)
Received: by 10.229.82.132 with HTTP; Fri, 20 Apr 2012 08:12:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196003>

Hello,

I'm using git clone --reference, it works like a charm !

Now, I have submodules, so I call git clone with both --recursive and
--reference, works only for the repo itself, submodules are being
cloned without the "--reference" option.

With GIT_TRACE=1 I can see this for the initial repo:

trace: built-in: git 'clone' '--recursive' '--reference' [...]

And this for the submodules:

trace: built-in: git 'clone' '-n' [...]

for every submodules.

Is this an intended behavior ?

How can I force the clones for submodules to be executed with the
--reference option ?

I tried to wrap /usr/lib/git-core/git-clone, but GIT_TRACE states it,
it's a builtin and indeed my wrapped version of git clone is not
executed !

Thanks

--

Samuel MAFTOUL
