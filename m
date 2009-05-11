From: Andreas Ericsson <ae@op5.se>
Subject: Re: merging multiple commit into one?
Date: Mon, 11 May 2009 15:31:54 +0200
Message-ID: <4A0828CA.3060405@op5.se>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 15:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Vc3-0003Xa-9y
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 15:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559AbZEKNb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 09:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758114AbZEKNb6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 09:31:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:3602 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758578AbZEKNb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 09:31:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so567085fga.17
        for <git@vger.kernel.org>; Mon, 11 May 2009 06:31:55 -0700 (PDT)
Received: by 10.86.59.18 with SMTP id h18mr6469592fga.71.1242048715727;
        Mon, 11 May 2009 06:31:55 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm4408215fgb.22.2009.05.11.06.31.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 06:31:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118796>

jean-luc malet wrote:
> Hi,
> I often commit "useless" code, for example before going into weekend
> or for saving some state during a dev process
> often thoses commit are simply useless and the commit message looks
> like "COMPILE ERROR - temporary save .... "
> at the end I have LOT of theses commits that are useless and I want to
> save some space/time/tree complexity merge multiple sequential commits
> (without branch) into one
> is it possible?
> according to my knowledge of git, removing the commit and rewriting
> the last commit log so that it better reflect the modification will do
> the job but I'm not sure git allow it...
> thanks


git commit --amend; # to extend last commit only
git merge --squash; # I think. Not sure though, so read the docs
git rebase -i; # replace "pick" with "squash" to combine commits.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
