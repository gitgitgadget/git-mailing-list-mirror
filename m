From: David Lang <dlang@digitalinsight.com>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 18:31:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz>
References: <20060926233321.GA17084@coredump.intra.peff.net><20060927002745.
  15344.qmail@web51005.mail.yahoo.com><BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1
 A0@CEZ.ICE><20060926205632.5d487cc9.seanlkml@sympatico.ca><Pine.LNX.4.63.06
 09261746160.22495@qynat.qvtvafvgr.pbz> <7vk63qnlc2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 03:45:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSOUO-0000nK-00
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWI0BpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWI0BpU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:45:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:43226 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932234AbWI0BpS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 21:45:18 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 26 Sep 2006 18:45:18 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 26 Sep 2006 18:45:12 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk63qnlc2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27847>

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> David Lang <dlang@digitalinsight.com> writes:
>
>>> You are right that a "Merged Date:" in gitweb would be useful information to
>>> show for each commit, but it's not straightforward given the design of git.
>>
>> would it?
>>
>> remember that a pach could be merged to many trees in any order. which
>> merge date do you want to know about?
>
> The date that repository I am looking at with gitweb first had
> that commit, of course.  What other dates did you have in mind?
>

if that repository is then merged into another one, what date would that second 
one record for that commit? the date it was pulled there?

in many cases this would seem to be useless or distracting information (you 
already display where in the history the merge took place, do you really need to 
attach that date to all changes that arrive from the branch?)

if you have something like

a-b-c-d-e-f-g
              \
h------i------j

or worse

     a
      \
b-----c-d
  \   /   \
   e-f-----g
            \
h-i---------j

do you really want the date of j attached to all the changes a-g?

and if this information really is important, wouldn't you want to export the 
info out (as j then gets merged into m somewhere else)

David Lang
