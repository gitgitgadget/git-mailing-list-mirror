From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: git svn --use-log-author misbehavior?
Date: Fri, 20 Jun 2008 13:04:48 +0100
Message-ID: <485B9CE0.1060600@mircea.bardac.net>
References: <485AF10B.7060202@mircea.bardac.net> <20080620085618.GA27940@frsk.net> <485B82BD.2000404@mircea.bardac.net> <20080620105729.GB27940@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Skolmli <fredrik@frsk.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fO2-0005eq-Hj
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYFTMFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYFTMFl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:05:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:20309 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbYFTMFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:05:41 -0400
Received: by wr-out-0506.google.com with SMTP id 69so916373wri.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 05:05:40 -0700 (PDT)
Received: by 10.90.50.5 with SMTP id x5mr4509614agx.31.1213963540240;
        Fri, 20 Jun 2008 05:05:40 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id c44sm1348857hsc.19.2008.06.20.05.05.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 05:05:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080620105729.GB27940@frsk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85625>

Fredrik Skolmli wrote:
> On Fri, Jun 20, 2008 at 11:13:17AM +0100, Mircea Bardac wrote:
>> My Git commits (not dcommits) already have "Signed-off-by:" at the end, 
>> added with "git commit -s". When I do a "git svn dcommit" they get 
>> pushed to SVN and the entire commit is rewritten. I have 
>> --add-author-from added on git clone, but nothing else is being added to 
>> the commit except the git-svn-id - from my point of view, according to 
>> the documentation, this is the correct behavior (since there already is 
>> a Signed-off-by line)
>  
> Did you mean "git svn clone" here, not "git clone"?

Yes, I meant "git svn clone".

> And if --use-log-author
> is to be used to get retrieve info from the commits, it should be used
> instead of --add-author-from when doing a clone. (Which as far as I can see
> behaves correctly.)

That is right. I am using them like this, but according to Stephen's 
reply the --use-log-author option is not being saved. I assumed they 
were saved as an option of the git svn clone so that they would affect 
all future dcommits.

--
Mircea
http://mircea.bardac.net
