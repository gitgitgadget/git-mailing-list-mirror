From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 19:09:14 +0200
Organization: At home
Message-ID: <ec4s7p$3is$1@sea.gmane.org>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <44E5ED82.8090904@gmail.com> <ec4r0h$u9m$1@sea.gmane.org> <ec4rsp$2vi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 18 19:10:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7rc-0004w4-Am
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 19:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWHRRKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 13:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWHRRKF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 13:10:05 -0400
Received: from main.gmane.org ([80.91.229.2]:16100 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161044AbWHRRKD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 13:10:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE7ql-0004ha-1m
	for git@vger.kernel.org; Fri, 18 Aug 2006 19:09:39 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 19:09:39 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 19:09:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25682>

Aneesh Kumar K.V wrote:

> Jakub Narebski wrote:
>> Aneesh Kumar K.V wrote:
>> 
>>> Junio C Hamano wrote:
>>>
>>>> * Jeff Garzik reports that the summary page of gitweb does not
>>>>   look at anything other than "master" which is not appropriate
>>>>   for his tree.
>>>>
>>>>   Message-ID: <44D874F0.6000907@garzik.org>
>>>>
>>>>   I probably should bug gitweb gang (Jakub, Luben, Martin Waitz,
>>>>   Aneesh) about this.
>>> I just tried editing HEAD. For the project 
>>>
>>> http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary
>>>
>>> $more HEAD
>>> ref: refs/heads/from-linus
>>> $
>>>
>>> Is this solution fine ?. Or do we want to add a git-rep-config 
>>> variable to indicate which branch to show. 
>> 
>> Err, of course gitweb shows "Last Change" for HEAD, which usually is
>> master.  The solution would be to show "Last Change" date to be the date
>> of last change of all/any branch.
> 
> I didn't quiet understand that. AFAIU what jeff wanted is to make 
> gitweb show some branch other than master by default in the summary page.
> I guess editing HEAD enables that. 

Editing head, well, having other branch checked out would be enough (checked
out before push would be enough I guess for gitweb repository being
"published repository", other that the copy you are working on).

AFAIR the problem was that development was not made at "master", so "Last
Changes" were last changes in master, no last changes as a whole. Last
changes date as a whole would be last change date of latest edited branch.
And for this I'd rather have functioning git-show-refs, for performance (at
least with larger number of heads...). 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
