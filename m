From: Justin Leung <jleung@redback.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Mon, 12 May 2008 11:45:31 -0700
Message-ID: <4828904B.6080708@redback.com>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop> <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop> <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org> <83EE186A7AF140179C6C73B367471EC7@justinuTop> <F975216F-9B61-41FF-A7FE-3D7EF09D137B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, justin0927@hotmail.com
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon May 12 20:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvd2U-0007Bn-6n
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbYELSpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756220AbYELSpc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:45:32 -0400
Received: from prattle.redback.com ([155.53.12.9]:36747 "EHLO
	prattle.redback.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbYELSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:45:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id 718A4A52D90;
	Mon, 12 May 2008 11:45:31 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25505-02; Mon, 12 May 2008 11:45:31 -0700 (PDT)
Received: from [155.53.72.61] (havant.redback.com [155.53.72.61])
	by prattle.redback.com (Postfix) with ESMTP id 58880A52D8E;
	Mon, 12 May 2008 11:45:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <F975216F-9B61-41FF-A7FE-3D7EF09D137B@sb.org>
X-Virus-Scanned: by amavisd-new at redback.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81902>


Thanks Kevin,

   I think i better give svn another serious look . 

but then, my impression from the rest of the people is that p4 and svn 
are not the ultimate tools for hardware development either .

I guess we just do not have the perfect tool for asic dev yet .

 Justin

Kevin Ballard wrote:
> But they come at an expense - no more linear revision numbers, more 
> complex commands, etc. You can't have it both ways.
>
> You could always use a main SVN repo and then use git-svn to maintain 
> your own private git repos, do all the code syncing you want there, 
> and then push it back to SVN when you want to send it back to the main 
> build stream. If you go this route, be careful to maintain a linear 
> history on the branch that tracks the SVN repo, as SVN cannot handle 
> merges the way git can. You'll want to either do rebasing or squashed 
> merges (to avoid multiple parents).
>
> -Kevin Ballard
