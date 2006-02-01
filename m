From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 11:34:47 -0800
Message-ID: <43E10D57.4060307@zytor.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 20:41:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Nq0-0008DW-Nz
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 20:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422899AbWBATkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 14:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWBATkQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 14:40:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:10416 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422899AbWBATkO
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 14:40:14 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k11JYlTt011261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Feb 2006 11:34:48 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15437>

Linus Torvalds wrote:
>>
>>For example, I had a hard time explaining to a friend why a git-add'ed 
>>file is committed when saying "git commit some_other_file", but not 
>>another (modified) file. Very unintuitive.
> 
> I really think you should explain it one of two ways:
> 
>  - ignore it. Never _ever_ use git-update-index directly, and don't tell 
>    people about use individual filenames to git-commit. Maybe even add 
>    "-a" by default to the git-commit flags as a special installation 
>    addition.
> 
>  - talk about the index, and revel in it as a way to explain the staging 
>    area. This is what the old tutorial.txt did before it got simplified.
> 
> The "ignore the index" approach is the simple one to explain. It's 
> strictly less powerful, but hey, what else is new? 
> 

I think both of these are probably the wrong answer, and it's pretty 
much a matter of the git model violating the principle of least 
surprise.  Perhaps added (or removed?) files need to be handled in a 
different way than they currently are.

	-hpa
