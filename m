X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stephan Feder <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 14:51:49 +0100
Message-ID: <45703375.4050500@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org>
Reply-To: sf@b-i-t.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 13:52:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201133558.GU18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32924>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq8o6-0001tA-Kp for gcvg-git@gmane.org; Fri, 01 Dec
 2006 14:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936388AbWLANv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 08:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936498AbWLANv7
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 08:51:59 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:56281 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S936388AbWLANv6
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 08:51:58 -0500
Received: (qmail 24107 invoked by uid 1011); 1 Dec 2006 13:51:57 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.23391 secs); 01 Dec 2006 13:51:57 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 1 Dec 2006 13:51:57
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 9EF79146C6; Fri,  1 Dec 2006 14:51:51
 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 02:05:33PM +0100, sf wrote:
>> >On Fri, Dec 01, 2006 at 01:09:49PM +0100, sf wrote:
>> >>Martin Waitz wrote:
>> >>>So you not only store your submodule HEAD commit in the supermodule
>> >>>when you do commit to the supermodule, it also means that your
>> >>>submodule HEAD will be updated when you update your supermodule.
>> >>
>> >>Why the magic? The typical workflow in git is
>> >>
>> >>1. You work on a branch, i.e. edit and commit and so on.
>> >>2. At some point, you decide to share the work you did on that branch 
>> >>(e-mail a patch, merge into another branch, push upstream or let it by 
>> >>pulled by upstream)
>> >
>> >3. Other people want to use your new work.
>> 
>> Sorry, if that was not obvious: You actually procceed with one of the 
>> options I listed in Step 2. What I wanted to state is that with git you 
>> do not mix up committing (which is local to your repository and your 
>> branch) and publishing.
> 
> I guess you are refering to not mix up committing to the submodule and
> updating the supermodule index.

The opposite: If you work in the supermodule, even if it is in the code 
of the submodule, you only commit to the supermodule. The submodule does 
not "know" about these changes after step 1.

> These are really two separate steps, I just combined them above because I
> wanted to put emphasis on the other part: it is not a one-way flow, it
> is bidirectional, so your HEAD would have to changed if the supermodule
> gets updated.

Why do you mix up supermodule and submodule? The way I see your proposal 
you cannot change submodule and supermodule independently. That is a 
huge drawback.

Regards

