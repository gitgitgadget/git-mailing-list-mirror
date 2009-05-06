From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to restrict gitk to show only branch/merge commits?
Date: Wed, 06 May 2009 09:42:34 +0200
Message-ID: <4A013F6A.5010003@op5.se>
References: <20090506072053.GL15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 09:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1bmZ-0002e0-TM
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 09:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZEFHmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 03:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZEFHmi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 03:42:38 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:51926 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbZEFHmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 03:42:37 -0400
Received: by fxm2 with SMTP id 2so5208112fxm.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 00:42:36 -0700 (PDT)
Received: by 10.86.2.16 with SMTP id 16mr1030483fgb.8.1241595756305;
        Wed, 06 May 2009 00:42:36 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e20sm9946801fga.25.2009.05.06.00.42.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 00:42:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090506072053.GL15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118331>

Josef Wolf wrote:
> Hello,
> 
> I would like gitk to show me only the heads, branch-points and
> merge-points of branches.
> 
> For example, given a history like this:
> 
>                    d...e--F--g...h--H
>                   /        \
>  a1--a2...an--b--C          N--o...p--P
>                   \        /
>                    i...j--K--l...m--M
> 
> I would like to see only
> 
>  - a1     because it has no parent
>  - C,F,K  because they are reachable from multiple heads
>  - N      because it has multiple parents
>  - H,M,P  because they are heads
> 
> Ideally, there would be a possibility to add some "context" to the
> list of commits to be shown: with $context==1, all the commits shown
> in the above history would be shown, but the commits indicated by
> the triple-dots would be omitted.
> 
> The reason is that I have some repositories with several really long
> linear history.  It is hard to get a global overview about the branch
> history if you have to scroll constantly.
> 
> Is something like that possible with gitk?

Not today, no. I'm not sure how hard it would be to add, and as I'm a
tcl-analphabet the chances of successfully implementing it marginally
increases if I don't work on it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
