From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 10:18:26 +0200
Message-ID: <45012752.4070300@innova-card.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>	<44FED12E.7010409@innova-card.com>	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>	<44FFD00E.5040305@innova-card.com>	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>	<450019C3.4030001@innova-card.com> <7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:18:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLbZ9-00040I-52
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWIHISU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWIHISU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:18:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:64623 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750995AbWIHIST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 04:18:19 -0400
Received: by nz-out-0102.google.com with SMTP id n1so251265nzf
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 01:18:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=nr5Iw9y+xaN+HfmvbKT3YBPstHZOSvnzkYCQ/XdCmhFmCdzNFCtKq0hYtIp6fosKkaxgLHi9A95VDUeyHxQZFp6t2972iUAeinDaqjZCacFk7GRHce4l6BGKYBoMW7iIyugX+Yohg6N3vPuIvRS4Sj/zzGD1UGbHlqRQUu22eqA=
Received: by 10.65.237.19 with SMTP id o19mr1504687qbr;
        Fri, 08 Sep 2006 01:18:18 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id q16sm1663519qbq.2006.09.08.01.18.16;
        Fri, 08 Sep 2006 01:18:18 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26683>

Junio C Hamano wrote:
> Franck Bui-Huu <vagabon.xyz@gmail.com> writes:
>>
>>   2/ Can I remove 'git-upload-tar' command ?
>>   3/ Should I kill 'git-zip-tree' command ?
> 
> We do not deprecate commands that easily.  Notice we have kept
> git-resolve for a long time (we should remove it and by now it
> should be safe)?
> 

heh ? I've just noticed that you removed 'git-upload-tar' from
master branch (commit d9edcbd6061a392c1315ab6f3aedb9992a3c01b1).

Futhermore I was thinking about 'git-zip-tree' removal because
it's a very recent command. It shouldn't hurt to remove it now
and make our life easier, not sure though...

> Especially tar-tree --remote and upload-archive talks different
> protocols, so it is not like not removing it is making your life
> more difficult.  Perhaps after next release (1.4.3 or 1.5?  I

since you removed 'git-upload-tar', it would be good to remove
'--remote' option from 'git-tar-tree' command as well. 

> In any case, don't make removal of them as part of the series
> please.  Let's make sure this new toy works well first, and then
> start talking about removing things that have become obsolete.
> 

OK, I'll let you do that.

		Franck
