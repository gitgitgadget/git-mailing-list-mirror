From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-daemon enabled on kernel.org
Date: Wed, 19 Oct 2005 09:33:26 -0700
Message-ID: <43567556.1010506@zytor.com>
References: <43554D4F.7040403@zytor.com> <20051019083542.GA31526@harddisk-recovery.com> <20051019084056.GL22986@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Erik Mouw <erik@harddisk-recovery.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 18:36:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESGtA-0006LS-IL
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 18:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVJSQdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 12:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVJSQdq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 12:33:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20136 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751015AbVJSQdp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 12:33:45 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JGXQvm018391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 09:33:28 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051019084056.GL22986@schottelius.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10295>

Nico -telmich- Schottelius wrote:
> Erik Mouw [Wed, Oct 19, 2005 at 10:35:42AM +0200]:
> 
>>On Tue, Oct 18, 2005 at 12:30:23PM -0700, H. Peter Anvin wrote:
>>
>>>After getting gitweb behind mod_cache, the load on kernel.org has gotten 
>>>down into the tolerable range, so I have enabled git-daemon in an 
>>>attempt to fix that :)
>>>
>>>The URL, obviously, is git://git.kernel.org/pub/scm/...
>>>
>>>(or, to specify a specific server, git1.kernel.org or git2.kernel.org.)
>>
>>How do I tell git to change the default repository to pull from?
> 
> 
> Do you mean cg-branch-add perhaps? Afaik there is no real 'default' repository, but
> the branches you specified. So adding a new branch will fix what you want.
> 

With cogito, you want "cg-branch-chg origin".

	-hpa
