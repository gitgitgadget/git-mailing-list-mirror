From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 14:03:53 +0200
Message-ID: <200610201403.53664.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehaapb$5t7$3@sea.gmane.org> <Pine.LNX.4.63.0610201335420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 14:03:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gat6R-0001Hr-Kn
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 14:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992421AbWJTMDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992548AbWJTMDw
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 08:03:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58927 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992421AbWJTMDv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 08:03:51 -0400
Received: by ug-out-1314.google.com with SMTP id o38so723805ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 05:03:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bPGTuVVduocCxy7npDgog5UTjDH7jZCzTyb3kZXckM1M6tGHvVktCyarOVEaGlPzNmlW0479BwTM+HMwEn5qtEv85ML+wKrmfU2bv80WF+QODmBJNfnZsRC7DclZ7WzMp8GF7M/1abRZqOb9U4BZ0V8qA5AqDHg7Pr1K2J9SuvE=
Received: by 10.67.117.2 with SMTP id u2mr1702650ugm;
        Fri, 20 Oct 2006 05:03:50 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e23sm1326917ugd.2006.10.20.05.03.49;
        Fri, 20 Oct 2006 05:03:49 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0610201335420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29455>

Johannes Schindelin wrote:
> On Fri, 20 Oct 2006, Jakub Narebski wrote:
> 
>> Johannes Schindelin wrote:
>> 
>>> On Fri, 20 Oct 2006, Lachlan Patrick wrote:
>>> 
>>>> How does git disambiguate SHA1 hash collisions?
>>> 
>>> It does not. You can fully expect the universe to go down before that 
>>> happens.
>>  
>> Or you can compile git with COLLISION_CHECK
>> 
>> From Makefile:
>> # Define COLLISION_CHECK below if you believe that SHA1's
>> # 1461501637330902918203684832716283019655932542976 hashes do not give you
>> # sufficient guarantee that no collisions between objects will ever happen.
> 
> You can document your disbelief.
> 
> But it does not change a thing. Since v0.99~653, we do not have any 
> collision check, even if compiled with COLLISION_CHECK.

So why it is left in Makefile? Does defining this change a thing
or not (in which case this section should be removed)?

-- 
Jakub Narebski
Poland
