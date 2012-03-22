From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 18:22:13 -0500
Message-ID: <4F6BB425.2010807@gmail.com>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anjib Mulepati <anjibcs@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArKp-0002IO-CM
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab2CVXWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 19:22:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42817 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab2CVXWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:22:18 -0400
Received: by obbeh20 with SMTP id eh20so1875700obb.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5ZyH3VKpqCAgq20Jbj6OX3GustUXDtIKdkbvL1VdgJs=;
        b=esvpepSHbzvqx38ezXS5YGIlfzLvvYdI5l4/XmS7IdenmxeptRf48Dhxl9H6CrEErF
         IY7rc0PThAlTOyWRtAhS4CL5qt9vSe/0HQ3dzn+s5LLHq8knayWaGGqfwusjqXIpvF9O
         Ez4koSGLi3T4EoQv+GHTSGTntYAuEGhifdNuuERqfTlv2ZbriTCWgjpy2yrjtOk4gilq
         Ckw6TvulGibYfy+NShEgzpnT4Z2cPJK3RS0w4ArYB5nsjFrigvbvw9da7kRABYCpNfO3
         Wp/BZr1xiN98Fs7Sj5WSql26r/R5V3tHBO88Vj5EGQcOhxI1u7C1nb92KoWuSe+CgoW+
         /dBg==
Received: by 10.182.147.35 with SMTP id th3mr12276855obb.29.1332458537471;
        Thu, 22 Mar 2012 16:22:17 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h5sm4440658oea.1.2012.03.22.16.22.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 16:22:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120322225747.GB14874@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193730>

On 3/22/2012 5:57 PM, Jeff King wrote:
> On Thu, Mar 22, 2012 at 06:04:20PM -0400, Anjib Mulepati wrote:
>
>> 2. Can I have a folder structure like (a) /Hello-World (b)
>> /Hello-World/gitVersion/GitVersionFile.txt and (c)
>> /Hello-World/nonGitVersion/NonGitVersionFile.txt where I give git
>> init for (a) and (c). If Itry to push only from (c) is that valid?
>
> You have a repository inside a repository. So when you are in (c),
> you will be pushing the commits from (c), not from (a). I'm not
> really sure what you are trying to accomplish with that.
>
See this thread for the "cons" of nested git repos: (I don't think there 
are any "pros".)
http://thread.gmane.org/gmane.comp.version-control.git/190372

*If* that is really what you meant...

v/r,
neal
