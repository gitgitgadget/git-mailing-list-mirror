From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: git log missing last line of output
Date: Wed, 27 May 2009 18:06:50 -0500
Message-ID: <gvkgrs$hs8$1@ger.gmane.org>
References: <gvhrtf$vpr$1@ger.gmane.org> <4A1D5F70.4030101@drmicha.warpmail.net> <gvjsc9$f40$1@ger.gmane.org> <200905272106.31036.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 01:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9SA5-0006pw-0b
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 01:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbZE0XDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755337AbZE0XDn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 19:03:43 -0400
Received: from main.gmane.org ([80.91.229.2]:57557 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbZE0XDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 19:03:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M9S9u-0002oH-LG
	for git@vger.kernel.org; Wed, 27 May 2009 23:03:42 +0000
Received: from 216-60-24-100.rsss.biz ([216.60.24.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2009 23:03:42 +0000
Received: from neal by 216-60-24-100.rsss.biz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2009 23:03:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 216-60-24-100.rsss.biz
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120127>

$ git --no-pager log

...does display the last line of output.  (The missing last line occurs in 
the SmarTerm terminal emulator.)

$ git log

...does display the last line of output on the same server's desktop when 
connecting via VNC.

Thanks for the help.  (Not sure how to 'reply to all' in Outlook newsreader. 
It only has 'reply to group' and 'reply to sender' options...)

Neal

"Johannes Sixt" <j6t@kdbg.org> wrote in message 
news:200905272106.31036.j6t@kdbg.org...
> Please use "Reply to all" so that Cc list remains.
>
> On Mittwoch, 27. Mai 2009, Neal Kreitzinger wrote:
>> $ git log
>> commit 73170498d68a0011b37d7ee095bf88b8dcb6fbb5
>> Author: tstuser1 <tstuser1@tstuser.com>
>> Date:   Wed May 27 11:48:30 2009 -0500
>>
>>     2nd commit after initial commit
>>
>> commit 9f9ed5663d180caefd0bcaff4578fdb2c542bf17
>> Author: tstuser1 <tstuser1@tstuser.com>
>> Date:   Wed May 27 11:14:38 2009 -0500
>>
>>     1st commit after initial commit
>>
>> commit bee2e0fa066aaa9fed99c15c2ab58744a34fda48
>> Author: tstuser1 <tstuser1@tstuser.com>
>> Date:   Wed May 27 11:13:13 2009 -0500
>>
>> $
>> ***NOTE THAT LAST LINE OF OUTPUT IS MISSING ABOVE (SHOULD BE THE TITLE 
>> LINE
>> OF THE INITIAL COMMIT -- BUT ITS NOT THERE)***
>
> Please try
>
>   git --no-pager log
>
> Do you see the line? Yes? Then your pager and your terminal do not 
> cooperate
> correctly.
>
> -- Hannes 
