X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 22:24:27 +0100
Organization: At home
Message-ID: <ejqhvi$9kc$1@sea.gmane.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net> <20061118184345.GO7201@pasky.or.cz> <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> <7vac2oefuz.fsf@assigned-by-dhcp.cox.net> <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com> <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com> <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org> <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com> <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com> <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org> <7vbqn38831.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611191310430.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 19 Nov 2006 21:23:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31865>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glu89-0001mT-1e for gcvg-git@gmane.org; Sun, 19 Nov
 2006 22:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933336AbWKSVXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 16:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWKSVXJ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 16:23:09 -0500
Received: from main.gmane.org ([80.91.229.2]:26276 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933336AbWKSVXH (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 16:23:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Glu80-0001l7-UO for git@vger.kernel.org; Sun, 19 Nov 2006 22:23:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 22:23:04 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 19 Nov 2006
 22:23:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> On Sun, 19 Nov 2006, Junio C Hamano wrote:
>> 
>> Did you do this "if (isspace(*line)) return NULL" to have
>> extensibility later, I wonder...
> 
> No, but I try to have a policy of not accepting anything that is even 
> slightly questionable, so it was unintentional in the details but a result 
> of a higher-level principle..
> 
> Of course, even when I wrote it I _also_ knew that I should check 
> everything else too (not just the first character), but I was lazy. That 
> would have been even better - then we could have made the thing be 
> something like
> 
>       <sha1><space><name>[<space><sha1-of-deref>]*
> 
> instead.

So the only reason against this format (IMHO more reasonable, more readable
and more readable, and even easy extendable to the whole chain of derefs)
is code in the wild? 

By the way, do we copy packed refs literaly when fetching or cloning?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

