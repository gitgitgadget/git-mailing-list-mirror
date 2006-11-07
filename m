X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 13:15:33 +0000
Message-ID: <455086F5.7070205@shadowen.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <45503553.3020605@gmail.com> <455055DD.2090903@shadowen.org> <4550772B.1040308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 13:16:02 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <4550772B.1040308@gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31070>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhQnp-0004cx-Tz for gcvg-git@gmane.org; Tue, 07 Nov
 2006 14:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932106AbWKGNPm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 08:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWKGNPm
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 08:15:42 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:44046 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S932106AbWKGNPm
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 08:15:42 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GhQn2-0000EH-DF; Tue, 07 Nov 2006 13:14:57 +0000
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:
> Andy Whitcroft wrote:
>>
>> One thing to remember, when you merge the destination into which you
>> merge will be HEAD^1, so by just following that you can get junio's view
>> of his branch as he made it.
>>
>> This is doesn't terminate properly, sucks the performance of your
>> machine and generally should be erased rather than run; but you get the
>> idea:
>>
>> let n=0
>> while git-show --pretty=one -s "next~$n"
>> do
>>         let "n=$n+1"
>> done | less
>>
>> -apw
>>
> This is not a right way to view a branch track in git, see Junio's
> explanation
> about this from http://marc.theaimsgroup.com/?l=git&m=116279354214757&w=2

Well in fact that message tells us more why a branch centric view is
likely not useful.  This output is still the majority of the time the
view from the branch integrators point of view.  If that is something
you care about, I am not sure it is something I care about.

