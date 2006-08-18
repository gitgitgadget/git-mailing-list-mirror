From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 22:33:21 +0530
Message-ID: <ec4rsp$2vi$1@sea.gmane.org>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <44E5ED82.8090904@gmail.com> <ec4r0h$u9m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 18 19:04:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7lY-0003KB-7K
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 19:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWHRREN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 13:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWHRREM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 13:04:12 -0400
Received: from main.gmane.org ([80.91.229.2]:44472 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030279AbWHRREL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 13:04:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE7lH-0003Fr-CV
	for git@vger.kernel.org; Fri, 18 Aug 2006 19:03:59 +0200
Received: from 59.92.199.81 ([59.92.199.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 19:03:59 +0200
Received: from aneesh.kumar by 59.92.199.81 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 19:03:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.199.81
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <ec4r0h$u9m$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25680>

Jakub Narebski wrote:
> Aneesh Kumar K.V wrote:
> 
>> Junio C Hamano wrote:
>>
>>> * Jeff Garzik reports that the summary page of gitweb does not
>>>   look at anything other than "master" which is not appropriate
>>>   for his tree.
>>>
>>>   Message-ID: <44D874F0.6000907@garzik.org>
>>>
>>>   I probably should bug gitweb gang (Jakub, Luben, Martin Waitz,
>>>   Aneesh) about this.
>> I just tried editing HEAD. For the project 
>>
>> http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary
>>
>> $more HEAD
>> ref: refs/heads/from-linus
>> $
>>
>> Is this solution fine ?. Or do we want to add a git-rep-config 
>> variable to indicate which branch to show. 
> 
> Err, of course gitweb shows "Last Change" for HEAD, which usually is master.
> The solution would be to show "Last Change" date to be the date of last
> change of all/any branch.
> 

I didn't quiet understand that. AFAIU what jeff wanted is to make gitweb show some branch other than master
by default in the summary page.  I guess editing HEAD enables that.

-aneesh
