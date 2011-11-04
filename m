From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: How to find a commit that introduces (not removes) a string?
Date: Fri, 04 Nov 2011 11:59:20 +0100
Message-ID: <4EB3C588.501@gmail.com>
References: <j8to8h$vqd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, nkreitzinger@gmail.com, laksvij@gmail.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Nov 04 12:01:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMHWe-0000ZM-RS
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 12:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048Ab1KDLBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 07:01:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41302 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1KDLBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 07:01:24 -0400
Received: by bke11 with SMTP id 11so1816176bke.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZjlgWqT4nHH6Yxu89cFOmlqptu9AUmIi97S+5MToorE=;
        b=GzzVvxEdBESfOc6qNTJ24etRW8ZXJTAecX7kmfvLRnx7z/AfQaPHqfcPe1mb5b1s4X
         BuqP62E7uriM/aaIyjXl53q8izhRnG5itbYtXINlsnuJgIPjaQPWry6O4su51XSQsxmz
         dXavm8isGH8OVxACri+BZCjjW+mlMeqr/WVwU=
Received: by 10.204.145.151 with SMTP id d23mr11535151bkv.100.1320404483315;
        Fri, 04 Nov 2011 04:01:23 -0700 (PDT)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id z15sm8486107bkv.4.2011.11.04.04.01.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 04:01:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <j8to8h$vqd$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184767>

On 03.11.2011 10:50, Sebastian Schuberth wrote:

> I know about git log's -S / -G, but I'm unable to make these search through *introduced* strings only. Is there a way to do so?

Thanks for your suggestions. However, I ended up simply doing

$ git diff --no-color FROM..TO | grep ^+[^+] | grep WORD

which works well for my case.

-- 
Sebastian Schuberth
