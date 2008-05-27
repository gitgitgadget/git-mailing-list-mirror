From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Tue, 27 May 2008 23:53:32 +0200
Message-ID: <200805272353.34319.jnareb@gmail.com>
References: <483C4CFF.2070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 23:54:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K177w-0008Bw-NJ
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 23:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758722AbYE0Vxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 17:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758442AbYE0Vxq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 17:53:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:30323 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758349AbYE0Vxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 17:53:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1217620nfc.21
        for <git@vger.kernel.org>; Tue, 27 May 2008 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=fs/MD0oiUlHWEXytxDv/fpK1Zd4E+DTjin7vr466NwM=;
        b=Eul+Le+3/v2LMlYQN1babw6Q+nByp9eXP2i3yzBz2lGIDKTC3WZq0gxsfafj3ISv+kdwX1jLpCgHfVF3kWpllPnvZpbsEIjULXf+pJ3CfThdkC0eFaP5RwTKBK56W/zU9QT+lG7lyVSV3iJgK351msKWYxsXghfzEJpgWE/sSx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SdbdClOSglm6Bw4J79cvAXwPirTgq66VqH/+LXZi55EupZS8hw0jRAYHiXSNpUZzChJev/3GhAUNk17Yl91s/g4BR/gNm3I7M4lwzAg+5tpPZp7ovKs9YxniATMITGlh5270ABk0DGn2/y5RlfS48COxUgyta1eC1gQKAYF8V3M=
Received: by 10.210.41.14 with SMTP id o14mr1260124ebo.156.1211925223480;
        Tue, 27 May 2008 14:53:43 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.174])
        by mx.google.com with ESMTPS id 33sm12848591nfu.7.2008.05.27.14.53.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 14:53:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <483C4CFF.2070101@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83053>

On Tue, 27 May 2008, Lea Wiemann wrote:

> I just wanted to let everyone know that I'm currently getting started on 
> a Google Summer of Code project to improve the caching mechanism in gitweb.
> 
> Sorry for not posting about this earlier...  Anyways, some key data: 
> John 'warthog9' Hawley (who wrote the current caching system for 
> kernel.org) is my mentor, and GSoC is from May 26 to Aug 18, minus a 
> vacation from Jul 19 to Aug 9.

Thanks for the info.

> While I'm planning to keep much of it on the list, if anyone else is 
> particularly interested in helping or providing input, please notify me. 
>   (Looking at the logs, Jakub maybe?  Cc'ing him just in case.)

I'm certainly interested, at least from theoretical point of view, and
I think I can help (as one of main gitweb contributors).

I guess that Petr Baudis would also be interested, because he maintains
repo.or.cz, a public Git hosting site.  Lately he posted a patch
implementing projects list caching, in a bit different way from how it
is done on kernel.org, namely by caching data and not final output:
  http://thread.gmane.org/gmane.comp.version-control.git/77151
AFAIK it is implemented in repo.or.cz gitweb: 
  http://repo.or.cz/w/git/repo.git

This indirectly lead to a bit of research on caching in Perl by yours
truly:
  http://thread.gmane.org/gmane.comp.version-control.git/77529
(mentioned in http://git.or.cz/gitwiki/SoC2008Projects#gitweb-caching).


I think that you can also get some help on caching from Lars Hjemli,
author of cgit, which is caching git web interface written in C.


(I have added both Petr Baudis and Lars Hjemli to Cc:)

> The current plan is basically to get the gitweb caching fork that's been 
> implemented for kernel.org back to the gitweb mainline, and then 
> optimize it (probably move to memcached).  I'm not yet sure how to 
> approach this (e.g. whether to merge from the fork to the mainline or 
> vice versa), but I'll probably figure this out together with John and 
> might post separately about that later.  In any case, expect patches and 
> messages from me on the list. :)

>From what I remember correcly from the discussion surrounding
implementing caching for kernel.org gitweb, the main culprit of having
it remain separate from mainline was splitting gitweb into many, many
files.  While it helped John in understanding gitweb, it made it
difficult to merge changes back to mainline.

Note also that it is easier to make a site-specific changes, than to
make generic, closs-platform and cross-operating system change.

-- 
Jakub Narebski
Poland
