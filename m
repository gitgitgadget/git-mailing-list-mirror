From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 14:21:21 +0100
Message-ID: <200702021421.22469.jnareb@gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 14:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCyKu-0004y7-6o
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 14:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045AbXBBNUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 08:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423053AbXBBNUL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 08:20:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:55838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423045AbXBBNUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 08:20:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so756062uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 05:20:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GHrL+hHqVFckZ62zTTti1NORrwUXpe0bgPNtmJMGXsCwantBSX46XWHoHdtpNtqgjls/zV5eKPYhOZix8CjLAoBz5UDFwN/t0Yf66B5xG5FRIoj8F9cc+e9p3PrA1jlJiyHZEKtqh7prNLRSZLXh/rLHqT0VE6BEfJflpg8mZ68=
Received: by 10.66.216.20 with SMTP id o20mr4384301ugg.1170422408932;
        Fri, 02 Feb 2007 05:20:08 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id m1sm5346609uge.2007.02.02.05.20.07;
        Fri, 02 Feb 2007 05:20:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38497>

Lars Hjemli wrote:
> On 2/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Fri, 2 Feb 2007, Jakub Narebski wrote:
>>
>>> Perhaps we should use @{...} to refer to reflog for HEAD, or use yet
>>> another special notation?
>>
>> No.
>>
>> IMHO "bla@{yesterday}" should give you what "bla" pointed to, yesterday.
>> In that sense, the proposed reflog on "HEAD" makes perfect sense.
> 
> Since HEAD is a synonym for "current branch" everywhere else in git,
> while .git/logs/HEAD will be a log of detached HEAD (plus branch
> switches, I guess), I think the following makes perfect sense:
> 
>   "HEAD@{yesterday}" = current branch, yesterday
>   "@{yesterday}"     = detached head (no branch), yesterday

In the counterproposal, we have

   "HEAD@{yesterday}" = where HEAD was at, yesterday
   "@{yesterday}"     = current branch, yesterday

The side with patch wins (well, the one that can convince Junio).
But serously, that decision is work for maintainer.
-- 
Jakub Narebski
Poland
