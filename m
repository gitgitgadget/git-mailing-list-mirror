From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: behaviour of .gitignore
Date: Fri, 25 May 2012 17:41:09 -0500
Message-ID: <4FC00A85.9090400@gmail.com>
References: <4FBFB42D.3090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 00:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY3C8-0003KA-Qv
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 00:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab2EYWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 18:41:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41358 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab2EYWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 18:41:11 -0400
Received: by obbtb18 with SMTP id tb18so1799763obb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1N6RRJc4dJlA1n43yeY9cg0ngaSrg2kdES7kZlNzg1A=;
        b=b+ftGzC/ZHyyK52W5RWuVDBAiq6nqjABFkRr68jmxNfDRBr3xo04I4dgwOm3TeaIDv
         /2T1AozaO7Vjn2W5h3bDcrIdBV8VGVMcUrqHDu26BrpnBok/eUSNPV4akju7U4f6cSLY
         m3IcQ9TsIn0pI2RlV71qW/xAHD4F1xipuoQ8sN08xLlyuBj3lZCtIZIU69szjPeuBBhX
         XTi0Ea2cwU6cNTFTYOqBWq9i1kXm8O2sPbCz6/u9Ra0hDb1Q8VDygOMTvmTSoVZowzfe
         zVAH9hBQSq/qoVP/8IImNmX/cTtzfY9/GBS3rrnfqAgTaE1Xt6WT01p3N3ZVp+KMR38J
         GoPg==
Received: by 10.60.14.169 with SMTP id q9mr566508oec.19.1337985670979;
        Fri, 25 May 2012 15:41:10 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id ju5sm3077300obb.23.2012.05.25.15.41.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 May 2012 15:41:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FBFB42D.3090303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198531>

On 5/25/2012 11:32 AM, J.V. wrote:
> On my local machine, I create a /bin/ directory added some bash
> scripts, comitted and then pushed them to the repository.
>
You should be able to click on that commit in gitk and see that the
files were added (confirm you really added them).

> Now today I do a git pull and they are gone but cannot see that
> anyone deleted them in the git log / history, but there is a /bin/
> entry in the .gitignore file.
>
If that ignore entry was there when you did the commit then maybe you
never really committed them.

> Does this mean, the files are still in the shared repository (orgin)
>  that I could get them back?
>
The gitk step above will tell you if they are there.

> I tried removing /bin/ from the git ignore and doing a pull but my
> /bin/ directory is still not there.
>
Its not looking like you really committed them like you thought you did.

> Is there anyway to do a pull now and have it look at my local
> gitignore and pull the directory back?
>
If the files were really committed, then you should have that commit in
your history also.  Therefore, you should be able to 'git checkout' 
those files into your worktree.

v/r,
neal
