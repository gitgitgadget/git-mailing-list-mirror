From: Jerry Seutter <jerry.seutter@pason.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 15:09:56 -0600
Message-ID: <42D58324.6080303@pason.com>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local> <tnxll4bdn7b.fsf@arm.com> <42D55AC9.4000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 23:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsoWY-00036b-DU
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVGMVLT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVGMVJ0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:09:26 -0400
Received: from hemlock.pason.com ([208.38.1.1]:39764 "EHLO
	exch-calgary.int.pason.com") by vger.kernel.org with ESMTP
	id S262378AbVGMVHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 17:07:25 -0400
Received: from [172.16.0.231] ([172.16.0.231]) by exch-calgary.int.pason.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 13 Jul 2005 15:07:24 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42D55AC9.4000506@gmail.com>
X-OriginalArrivalTime: 13 Jul 2005 21:07:24.0302 (UTC) FILETIME=[DDCBE2E0:01C587EE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen wrote:
> Catalin Marinas wrote:
> 
>> An additional thing, can you please convert all the tabs to spaces?
>> That's a better convention for a language like Python where you
>> delimit blocks by indentation.
> 
> 
> I would have hoped that emacs py-mode would "do the right thing". 
> Anybody know how to make it do what Catalin wants?

Yeah, the default emacs mode seems to be to Do The Wrong Thing.  I have 
this in my .emacs, YMMV.

(setq-default indent-tabs-mode nil)     ; Don't insert tab characters.
(setq-default tab-width 4)              ; If there are tabs, display
                                         ; as 4 spaces.

You can set the tab-width to something much larger to make existing tabs 
obvious.

Jerry
