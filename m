From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git push stuck
Date: Sun, 22 Apr 2012 11:41:22 +1200
Message-ID: <4F9345A2.3050702@gmail.com>
References: <4F929200.4010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hen vertis <henvertis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 01:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLjvS-000478-F9
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 01:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab2DUXlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 19:41:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab2DUXlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 19:41:04 -0400
Received: by pbcun15 with SMTP id un15so2437126pbc.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Kzn532S25MB7hxa3/xCAk/0vmQQqJjM0MeupjQC1vAA=;
        b=Jh3ujI4YFjEpKDjpU6sueGs8ZcGGyczciVBS7zFsPMvGa2lezOyg6lYnLi6YvZ5J1k
         CJN2HB1y+YhX0OaS3nmD7H7sqBrMMzeTPt2aEuz1BSMsT87XAJsYjD5627Ynn2IL/klR
         LixH66/j4uNSftt9TZDfGCmKacd+16UaNwu/sFOLaVUEmAs2ZjJKcbxZnfkByvvXvOur
         vwVw7MYecZIwdWcRSFJ020lcPQiuKyd2K406nVaz5fxeSHCXVqCpxQA8rL61oVOH3asi
         pdTMIVflhmErhSNzGmOF805tcYtzQq8ibUcknIoDQehJKV6OjISBiU1QUUCyjaJ/iLhL
         l9OQ==
Received: by 10.68.189.231 with SMTP id gl7mr24249401pbc.151.1335051662723;
        Sat, 21 Apr 2012 16:41:02 -0700 (PDT)
Received: from [192.168.1.65] (222-153-35-210.jetstream.xtra.co.nz. [222.153.35.210])
        by mx.google.com with ESMTPS id s7sm9685189pbl.31.2012.04.21.16.40.55
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 16:41:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <4F929200.4010406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196063>

On 04/21/2012 10:54 PM, hen vertis wrote:
> hi
> i working with git version 1.7.10.msysgit.1 on windows 7.
> my repository is on Ubuntu.
> i can make fetch and merge.
> but when i trying to push is not working.
> any idea will be welcomed.
> 
> best regards
> hen
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


To help diagnose your problem could you please provide the output of

  git remote show origin

Also try running you push command like this

  GIT_TRACE=1 git push

This will provide more debugging info that might tell us where git push
is getting stuck.
