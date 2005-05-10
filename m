From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 08:14:06 -0700
Message-ID: <4280CFBE.6010904@zytor.com>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de> <20050510094538.GE8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 17:10:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVWMZ-000543-WE
	for gcvg-git@gmane.org; Tue, 10 May 2005 17:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEJPQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 11:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVEJPQ1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 11:16:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:25318 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261682AbVEJPOz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 11:14:55 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4AFE6rU020105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 May 2005 08:14:08 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050510094538.GE8176@lug-owl.de>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Tue, 2005-05-10 11:39:24 +0200, Matthias Urlichs <smurf@smurf.noris.de> wrote:
> 
>>Jan-Benedict Glaw:
>>
>>>Ever thought about keeping some important files (of your $HOME) in some
>>>SCM? For sure, some of those are dot files:-)
>>
>>Yeah, but so are various local temporary files.
>>
>>Please don't change that without talking to Linus.
> 
> 
> I won't.  You haven't seen a patch from me "fixing" this, too.  *I*
> consider this as a defect, but that doesn't mean that I'll force others
> to take this view, too.  But maybe I'll talk Linus into this when he's
> back from his trip.
> 

Another vote for fixing this!

	-hpa
