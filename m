From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Real-life kernel debugging scenario
Date: Mon, 7 Nov 2005 16:59:58 -0800 (PST)
Message-ID: <Pine.LNX.4.62.0511071657030.9339@qynat.qvtvafvgr.pbz>
References: <dkosr7$f4s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 02:01:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZHqR-0006BK-Ai
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 02:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVKHBAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 20:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVKHBAK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 20:00:10 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:11986 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964977AbVKHBAH
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 20:00:07 -0500
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 7 Nov 2005 17:00:07 -0800
Received: from wlvexc02.digitalinsight.com ([10.201.10.15]) by wlvims02.corp.ad.diginsite.com with InterScan Messaging Security Suite; Mon, 07 Nov 2005 17:00:02 -0800
Received: by wlvexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <WL40KY2A>; Mon, 7 Nov 2005 16:55:31 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id WLVGS2NZ; Mon, 7 Nov 2005 16:58:44 -0800
To: walt <wa1ter@myrealbox.com>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <dkosr7$f4s$1@sea.gmane.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <dkosr7$f4s$1@sea.gmane.org>
References: <dkosr7$f4s$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11299>

On Mon, 7 Nov 2005, walt wrote:

> My worry:  what happens when I'm not smart enough to guess
> which developer to email?  My first instinct is to back out
> the most recent commits one-by-one until the bug goes away.
>
> First:  is this an optimal tactic?

it will work, but it's not optimal. this is exactly what git bisect is 
designed for.

you tell it that the prior night's version was good and the current 
version is bad. It picks a version 'halfway' in between the two and you 
test that. tell git if the test failed or not and it will then give 
you the next one to try. repeat until you identify exactly which commit 
triggers the problem.

unfortunantly I can't trivially point you at the right place in the docs.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
