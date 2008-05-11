From: Kevin Ballard <kevin@sb.org>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Sun, 11 May 2008 00:21:32 -0500
Message-ID: <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop> <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <justin0927@hotmail.com>
To: "Justin Leung" <jleung@redback.com>
X-From: git-owner@vger.kernel.org Sun May 11 07:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv41V-0005jM-ST
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbYEKFVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbYEKFVr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:21:47 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:58238 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750810AbYEKFVr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 01:21:47 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id 53BFF90A69;
	Sat, 10 May 2008 22:21:45 -0700 (PDT)
In-Reply-To: <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
X-Priority: 3
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81734>

On May 11, 2008, at 12:08 AM, Justin Leung wrote:

> Hi all,
>
> * This email probably represent the whole hardware ASIC community  
> about git *
>
> I'm evaluating Git as the replacement of CVS for the ASIC group in  
> my company,
> but things are moving along very bumpy.
>
> I (and many others doing the evaluation) love the tool dearly; we  
> love the local repository and inter-db sync'ing .
> I see a lot of potential in productivity and changes in work model  
> that helps efficiency in ASIC dev.
>
> BUT, my managers, some veterans, and directors are EXTREMELY  
> concerned about the ease-of-use..
> so much that they are going to pick SVN !  uh-oh....i m serious =(
>
> Alot of people argued, why not SVN ? it's CVS++ and it's ease of use  
> not a problem when comparing to Git.
>
> here are the things not fitting right in ASIC dev:
>
> - no incremental revision numbers (they are so scared of the 40hex  
> SHA1)
>
> - Inability to reference without SHA1, they want simple numbering  
> (ie, version 100, 120, 120.1, 130.4.5)
>
> - Inability to refer to a file by a simple number
> (the backend guys will be confused by SHA1; they can't work with  
> anything more than 4-5 digits)
>
> - Complexity of commands (although we can have warpper, but real git  
> commands for non-sw guys is not going to happen)
>
> Most hardware chip designers were using CVS since their first job.
> It suited the purpose very well.
>
> Most RTL design veterans only use less then 5-6 cvs commands in  
> their whole life (LOL, i m serious) :
>
> $ cvs checkout
> $ cvs update
> $ cvs log
> $ cvs diff (tkdiff)
> $ cvs status
> $ cvs commit
>
> We don't use branches.
> Our model is strict forward with a centralized, one main branch  
> model to avoid mistakes .
> We see branches as evil ; some merges in Verilog codes means another  
> 10+ hours of simulation and regression.
>
> [snip]

Honestly, it sounds like SVN is actually a good fit here. Just because  
git is awesome for many things does not mean it is the end-all-be-all  
of version control systems. SVN still has its place as the last true  
centralized system. Given your constraints and workflow, why do you  
think git is better than SVN?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
