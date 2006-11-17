X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 14:45:46 +0100
Organization: At home
Message-ID: <ejkebm$4a2$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <Pine.LNX.4.64.0611151315291.2591@xanadu.home> <20061115184914.GA24122@spearce.org> <455B64F7.9040506@gmx.net> <7vejs4l9wy.fsf@assigned-by-dhcp.cox.net> <455C0033.2020309@gmx.net> <7v1wo3d6g4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 17 Nov 2006 13:45:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31698>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl41f-00023b-SC for gcvg-git@gmane.org; Fri, 17 Nov
 2006 14:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424383AbWKQNoy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 08:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424409AbWKQNox
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 08:44:53 -0500
Received: from main.gmane.org ([80.91.229.2]:23693 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424383AbWKQNow (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 08:44:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl41I-00020G-73 for git@vger.kernel.org; Fri, 17 Nov 2006 14:44:40 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 14:44:40 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 14:44:40 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Marko Macek <marko.macek@gmx.net> writes:
> 
>>>> BTW, currently there's a minor bug: git-diff HEAD doesn't work before
>>>> you make the first commit. Perhaps this should be special cased.
>>>
>>> That's only a _bug_ in your implementation of the synonym for
>>> "svn diff" which blindly used "git diff HEAD".
>>
>> My "implementation" is taken from git-diff man page. It seems obvious
>> that the situation before the first commit is just a special case if
>> we consider git-diff to be Porcelain (which I do).
> 
> Yes, "git diff" is a Porcelain.  No question about it.
> 
> I do not consider the current behaviour of "git diff HEAD" that
> complains instead of giving runs of "foo is a new file and no
> diff is available for it" a bug; you asked for diff from some
> commit but the commit you gave was bogus (does not exist yet).

git diff --root HEAD, perhaps?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

