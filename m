From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Use case I don't know how to address
Date: Mon, 07 Sep 2009 13:01:54 +0100
Message-ID: <4AA4F632.3070206@chandlerfamily.org.uk>
References: <4AA20CEC.8060408@chandlerfamily.org.uk> <7vk50ccxfj.fsf@alter.siamese.dyndns.org> <4AA3AEA1.7030107@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Sep 07 14:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkcvF-0004fX-Qf
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 14:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZIGMCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 08:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZIGMCD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 08:02:03 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:45791 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088AbZIGMCC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 08:02:02 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Mkcv6-0005EE-0J
	for git@vger.kernel.org; Mon, 07 Sep 2009 13:02:04 +0100
Received: from [77.103.217.152] (helo=wol.chandlerfamily.org.uk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Mkcux-0004dI-DK
	for git@vger.kernel.org; Mon, 07 Sep 2009 13:01:55 +0100
Received: from kanga.local ([192.168.0.30])
	by wol.chandlerfamily.org.uk with esmtp (Exim 4.69)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1Mkcux-0001Op-2F
	for git@vger.kernel.org; Mon, 07 Sep 2009 13:01:55 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
In-Reply-To: <4AA3AEA1.7030107@chandlerfamily.org.uk>
X-SA-Exim-Connect-IP: 192.168.0.30
X-SA-Exim-Mail-From: alan@chandlerfamily.org.uk
X-SA-Exim-Scanned: No (on wol.chandlerfamily.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127920>

Alan Chandler wrote:
> Junio C Hamano wrote:
>> Alan Chandler <alan@chandlerfamily.org.uk> writes:
>>
>>>        2' - 2a - 3' - 4' ----------------- 6' SITE
>>>       /         /    /                    /
>>> 1 -  2  ------ 3  - 4  ------------6'''- 6a TEST
>>>                      \            /
>>>                        5  ------ 6  MASTER
>>>                         \         \
>>>                           5''- 5a- 6'' DEMO
>>>
>>>
>>> What will happen is the changes made in 4->5 will get applied to the
>>> (now) Test branch as part of the 6->6'' merge, and I will be left
>>> having to add a new commit, 6a, to undo them all again.  Given this is
>>> likely to be quite a substantial change I want to try and avoid it if
>>> possible.
>>
>> I presume 6'''-6a has the revert of 4-5?  If so, the next merge should
>> work just fine.
> 
> 
> I think you missed the issue - Yes 6'''-6a is the revert, but the 
> problem is this could be large and complicated, and I wanted to find an 
> automated way rather than manual
> 
> Sort of like doing a diff of 4-5 and somehow applying it backwards.
> 
> 

I just discovered that git-apply has the -R flag.  Is that what I am 
looking for?

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
