From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: Problem with cogito and Linux tree tags
Date: Thu, 02 Jun 2005 22:19:02 +0200
Message-ID: <429F69B6.4030806@gmail.com>
References: <429F5FA5.2030306@gorzow.mm.pl> <429F6270.50009@gmail.com> <429F6591.8080005@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 02 22:23:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdwBt-0000R9-Mf
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 22:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFBUYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 16:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFBUXd
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 16:23:33 -0400
Received: from main.gmane.org ([80.91.229.2]:45972 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261326AbVFBUXD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 16:23:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ddw8l-0008Hw-Ta
	for git@vger.kernel.org; Thu, 02 Jun 2005 22:18:07 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 22:18:07 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 22:18:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <429F6591.8080005@gorzow.mm.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Radoslaw Szkodzinski wrote:
> Dan Holmsand wrote:
>>It's a tag object. If you cg-pull via http, you won't get any of
>>those, though.
> I thought it was one of these. Seems cogito can't handle them yet.

Ah. I forgot just how old cogito-0.10 has gotten. Current cogito handles 
these just fine. You should be able to read the tag object slightly more 
manually, though:

$ git-cat-file tag 06f6d9e2f140466eeb41e494e14167f90210f89d

which tells you that v2.6.12-rc5 is commit 
2a24ab628aa7b190be32f63dfb6d96f3fb61580a

/dan

