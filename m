From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to always use --merge option in git rebase?
Date: Thu, 12 Apr 2012 18:33:58 -0500
Message-ID: <4F876666.7080501@gmail.com>
References: <CAGAhT3k4Hztbn8139LBuRFxTJgKxDzZcJR=L2A5o9rQBVuVMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:34:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITWi-0004wI-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902Ab2DLXeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:34:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57012 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934233Ab2DLXeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 19:34:01 -0400
Received: by obbtb18 with SMTP id tb18so3370561obb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uwUH2+Yrja0DJyJEPpTGYEof8wwxtJJrhzZzr3tDyag=;
        b=e5QP5v083nyGvt7HshLkRzL+4Sn2w+3CvX00DOPJvOG3vh/wAm5JV8ma6msFuPwZx/
         glRwpTJVYxBZv9/3zLXWHi6ABqdN0UWPDFx/LCwsNiCGDclNM3/WAR2hZuBaLpRdNiFs
         ygG+Uv8P1i8+HGlxM9QF+3DTS5r/HK44cECsAJvndUcUQNNqCSOBmLmQET2oalJtsoq1
         3tpufY8s+2M2V9VxNFRc6AJbLRw/k6hAXLRM9MeX9mbCGMnMQS4BccUTLjROigRBvi9Z
         mJx5v/cqyfbMI8PGt4JnzyxyHaL3LhcYbhsIZAfkSVXK0ZcwZ26prOa40fhk881BUaST
         u+Dw==
Received: by 10.60.5.231 with SMTP id v7mr45834oev.61.1334273640792;
        Thu, 12 Apr 2012 16:34:00 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id j10sm8411375oba.4.2012.04.12.16.33.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 16:34:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAGAhT3k4Hztbn8139LBuRFxTJgKxDzZcJR=L2A5o9rQBVuVMEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195389>

On 4/12/2012 3:31 PM, Alexander Kostikov wrote:
> Hi,
>
> We have a huge repository ~10 GB. After some integrations the following happens:
>
>> git rebase master
> First, rewinding head to replay your work on top of it...
> fatal: Out of memory, malloc failed (tried to allocate 55012353 bytes)
>
> There is a workaround to use 'git rebase --merge' instead. But I
> couldn't find a way to make the merge-based rebase the default one. Is
> it possible?
> git version 1.7.10.msysgit.1
>
You could make a git alias like "git rebaser" that does 'git rebase 
--merge'.

v/r,
neal
