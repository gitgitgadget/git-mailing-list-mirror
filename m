From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Make test broken w/ 180b0d7483711120e28289ff7d9fa346eddd5cb7
Date: Thu, 09 Mar 2006 22:16:59 -0800
Message-ID: <441119DB.3020207@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 07:17:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHaw6-0001Re-Q7
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 07:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWCJGRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 01:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCJGRL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 01:17:11 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:51111 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752038AbWCJGRK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 01:17:10 -0500
Received: by zproxy.gmail.com with SMTP id 14so660619nzn
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 22:17:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=JSEd6tgxEc7tcyjZJqxaV3Y2nR2z3RVjP5pBCfhPjltpaoIUc0pWXRbpb+Cvj69CXMM9wZUjXcbXIzmk6x/jrHNjl4KBGnnpnbXxyiGqINgJKaqzYrlkCFgIbkwlGfhnTMqS3h2NySSab1Zg1k+oKPT+2xDg66XaWZwui+2B5QE=
Received: by 10.37.18.56 with SMTP id v56mr3518727nzi;
        Thu, 09 Mar 2006 22:17:09 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id 6sm4298815nzn.2006.03.09.22.17.08;
        Thu, 09 Mar 2006 22:17:08 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17458>

*** t1200-tutorial.sh ***
*   ok 1: blob
*   ok 2: blob 557db03
*   ok 3: git-diff-files -p
*   ok 4: git diff
*   ok 5: tree
*   ok 6: commit
*   ok 7: git-diff-index -p HEAD
*   ok 8: git diff HEAD
*   ok 9: git-whatchanged -p --root
*   ok 10: git tag my-first-tag
*   ok 11: git checkout -b mybranch
*   ok 12: git branch
*   ok 13: git resolve now fails
*   ok 14: git show-branch
* FAIL 15: git resolve
         cmp resolve.expect resolve.output
*   ok 16: git show-branch
*   ok 17: git repack
*   ok 18: git prune-packed
*   ok 19: -> only packed objects
* failed 1 among 19 test(s)
