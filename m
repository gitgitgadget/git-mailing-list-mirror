From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 20:29:06 -0500
Message-ID: <4F6BD1E2.2050607@gmail.com>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anjib Mulepati <anjibcs@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 02:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAtK5-0001Hd-Si
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 02:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab2CWB3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 21:29:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58775 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab2CWB3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 21:29:09 -0400
Received: by obbeh20 with SMTP id eh20so1954035obb.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 18:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BinSP1wGMt2qXa5hSyg4f26cYCejRnYuJ5IJWozu68E=;
        b=PvNYtlZS+PSaWb35J335nXS0FohckzcpA7uKEn5NjsSugsh9mvI+xS0sRxyIQOxgiw
         jUAjPqzkEodN3KSNczhG5Is/mb35mflFbm5vbc7TGkwqtKY3lOeySAqLF0IX7fSNLbNM
         JQtfuX6B4HftYcGWo1h615Fa8Qs8iRFCGov5gRzDeZqIcEB9CO1C0bnim+DBXHvBxUkk
         25gBsjUFGUON9WwnYQKdxGE2LB1mFm/ADIeRCy67Zx3atLfzZGtm9j0UWHHfAbRwpgEb
         p2nEhzklRvIed5WM1hy4kFJbMQ57ERliFJP2ffRq7RSH0qG/+BUrY9mzJGj8UJQgkIeF
         t/sA==
Received: by 10.182.174.101 with SMTP id br5mr12905890obc.0.1332466148181;
        Thu, 22 Mar 2012 18:29:08 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h7sm5059587oeh.9.2012.03.22.18.29.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 18:29:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120322225747.GB14874@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193741>

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
It almost looks like he might be tracking his git installation with git
by tracking the "gitVersion" dir, and the "NonGitVersion" dir is really 
the "normal" git repo containing a dev project.  I'm probably making a 
misinterpretation of the wording and "gitVersion" means "stuff versioned 
by git", but then again "NonGitVersion" is also supposedly being 
versioned by git.  Just curious if he's attempting to use his git 
installation to track itself which would be interesting also.

v/r,
neal
