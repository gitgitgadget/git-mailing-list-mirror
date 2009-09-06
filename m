From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Use case I don't know how to address
Date: Sun, 06 Sep 2009 13:50:34 +0100
Message-ID: <4AA3B01A.7060005@chandlerfamily.org.uk>
References: <4AA20CEC.8060408@chandlerfamily.org.uk> <200909051923.28831.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Sep 06 14:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkHCe-0003YR-48
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 14:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116AbZIFMue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 08:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756109AbZIFMue
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 08:50:34 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:58985 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756103AbZIFMud (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 08:50:33 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Sep 2009 08:50:33 EDT
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MkHCV-0005ky-N6
	for git@vger.kernel.org; Sun, 06 Sep 2009 13:50:35 +0100
Received: from [77.103.217.152] (helo=wol.chandlerfamily.org.uk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MkHCV-0005tG-6F
	for git@vger.kernel.org; Sun, 06 Sep 2009 13:50:35 +0100
Received: from kanga.local ([192.168.0.30])
	by wol.chandlerfamily.org.uk with esmtp (Exim 4.69)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1MkHCV-0006Vb-0I
	for git@vger.kernel.org; Sun, 06 Sep 2009 13:50:35 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
In-Reply-To: <200909051923.28831.j6t@kdbg.org>
X-SA-Exim-Connect-IP: 192.168.0.30
X-SA-Exim-Mail-From: alan@chandlerfamily.org.uk
X-SA-Exim-Scanned: No (on wol.chandlerfamily.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127854>

Johannes Sixt wrote:
> On Samstag, 5. September 2009, Alan Chandler wrote:
>> The problem comes when I want to now merge back further work that I did
>> on the master branch (the 5-6 transition) to the fan club site
>>
>>
>>         2' - 2a - 3' - 4' ----------------- 6' SITE
>>        /         /    /                    /
>> 1 -  2  ------ 3  - 4  ------------6'''- 6a TEST
>>                       \            /
>>                         5  ------ 6  MASTER
>>                          \         \
>>                            5''- 5a- 6'' DEMO
>>
>>
>> What will happen is the changes made in 4->5 will get applied to the
>> (now) Test branch as part of the 6->6'' merge, and I will be left having
>> to add a new commit, 6a, to undo them all again.  Given this is likely
>> to be quite a substantial change I want to try and avoid it if possible.
>>
>> Is there any way I could use git to remember the 4->5 transition,
>> reverse it and apply it back to the Test branch before hand.
> 
> Basically, your mistake was to rename master to test and continue development 
> on the demo branch. So what you should do instead is this:
> 
>         2' - 2a - 3' - 4' ------ 6' SITE
>        /         /    /         /
> 1 -  2  ------ 3  - 4  ------- 6  MASTER
>                       \         \
>                         5 - 5a - 6'' DEMO
> 


I understand what you are saying.  I think I need to consider a slight 
change to it however.  Master is currently the branch that I push to my 
public repository and that should ideally have my NON FAN CLUB skinning

So actually I think I am like this

          2' - 2a - 3' - 4' ------ 6' SITE
         /         /    /         /
  1 -  2  ------ 3  - 4  ------- 6  MASTER
                        \         \
                          5 - -- - 6'' PUBLIC REPO
                           \        \
                            5'''-5a -6''' DEMO






-- 
Alan Chandler
http://www.chandlerfamily.org.uk
