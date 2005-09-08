From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: gitweb feature request: tarball for each commit
Date: Thu, 08 Sep 2005 10:03:09 -0400
Message-ID: <4320449D.2070306@gmail.com>
References: <46a038f905090721305dcbf61@mail.gmail.com> <20050908084545.GH15165MdfPADPa@greensroom.kotnet.org> <20050908113207.GA30178@vrfy.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 16:05:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDN0P-0006aI-NJ
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 16:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVIHODS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 10:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVIHODS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 10:03:18 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:33223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVIHODR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 10:03:17 -0400
Received: by wproxy.gmail.com with SMTP id i2so1176440wra
        for <git@vger.kernel.org>; Thu, 08 Sep 2005 07:03:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mz6LmAyPSCikr4VoTu+L9oSjnY8iIsyCX1ga04nBzNnXzZzq4iYakPPMtPcUaDCcNOxvD3CgMLYzUvXzANyAhkWJm3G8Ni/ClglQBMCQk2FBkKKKpZRw8xitvS+2edmNNXeX2hVPqUE64yd+PrEKSGng6rg6V4Kz4Wtx4BtSFEc=
Received: by 10.54.29.44 with SMTP id c44mr3060359wrc;
        Thu, 08 Sep 2005 07:03:14 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 35sm492779wra.2005.09.08.07.03.10;
        Thu, 08 Sep 2005 07:03:11 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050908113207.GA30178@vrfy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8199>

Kay Sievers wrote:
> On Thu, Sep 08, 2005 at 10:45:45AM +0200, Sven Verdoolaege wrote:
>>On Thu, Sep 08, 2005 at 04:30:22PM +1200, Martin Langhoff wrote:
>>>Actually... should get it done. I'll see if I can sneak it in sometime soon... 
>>This has been done at least twice already.
>>See e.g., http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary
>>Check the archives for the other implementation.
> 
> Yes, this is nice for smaller projects. But I don't think, that we want
> to do such a thing on the kernel.org servers. We already have the daily
> snapshots and individual patches can be downloaded from gitweb. Anybody
> else should use git/cogito instead of letting the server packaging a huge
> tree for every requested revison, I think.

I think this is a very useful feature for for some, but not all, 
repositories. Default it to off and have a magic file (like git-daemon), 
or a config variable turn it on.
