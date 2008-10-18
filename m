From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: Excluding files from git-diff
Date: Sat, 18 Oct 2008 05:50:33 +0200
Message-ID: <48F95D09.9070704@pflanze.mine.nu>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net> <48F8BDA7.50901@pflanze.mine.nu> <loom.20081017T173145-53@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 05:52:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr2rD-0001ch-QR
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 05:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbYJRDui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 23:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYJRDuh
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 23:50:37 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:57826 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751183AbYJRDuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 23:50:37 -0400
Received: (qmail 25949 invoked from network); 18 Oct 2008 03:50:35 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 18 Oct 2008 03:50:35 -0000
Received: (qmail 18180 invoked from network); 18 Oct 2008 03:50:33 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 18 Oct 2008 03:50:33 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <loom.20081017T173145-53@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98520>

Eric Raible wrote:
> Christian Jaeger <christian <at> pflanze.mine.nu> writes:
>
>   
>> Michael J Gruber wrote:
>>     
>>> Or put it
>>> in .git/info/excludes.
>>>       
>> Only "git ls-files --others --exclude-from=.git/info/exclude" will exclude
>>     
>
> Could it be a simple as "excludes" vs "exclude"?
>   

Nope.

ln -s exclude .git/info/excludes
git ls-files # still shows files matching the excludes
git ls-files --exclude-from=.git/info/exclude # does not show
git ls-files --exclude-from=.git/info/excludes # does not show

Christian.
