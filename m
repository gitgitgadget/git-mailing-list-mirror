X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git blame
Date: Fri, 01 Dec 2006 00:08:39 +0100
Organization: At home
Message-ID: <ekno64$ekb$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net> <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net> <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org> <456F21D6.1060200@webdrake.net> <Pine.LNX.4.64.0611301034420.3513@woody.osdl.org> <87d574u2tl.wl%cworth@cworth.org> <Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de> <7v64cwh86r.fsf@assigned-by-dhcp.cox.ne
 t> <Pine.LNX.4.63.0611302350510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 23:08:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 35
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32831>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpv0K-0004yQ-0Z for gcvg-git@gmane.org; Fri, 01 Dec
 2006 00:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967964AbWK3XHk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967968AbWK3XHk
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 18:07:40 -0500
Received: from main.gmane.org ([80.91.229.2]:57058 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S967964AbWK3XHj (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 18:07:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gpuzb-0004mY-9v for git@vger.kernel.org; Fri, 01 Dec 2006 00:06:59 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 00:06:59 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01 Dec 2006
 00:06:59 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Thu, 30 Nov 2006, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>>> On Thu, 30 Nov 2006, Carl Worth wrote:
>>>
>>>> Here's a crazy idea. How about a "git tutorial" builtin or "git example" 
>>>> or something that would create a repository into some useful state for 
>>>> demonstrating something.
>>>
>>> That sounds fine! Actually, it should be very simple to turn the tutorial 
>>> into such a script, displaying the command with an explanation, and 
>>> executing the command. It could even call gitk from time to time, so the 
>>> user can form a mental model of the ancestor graph.
>> 
>> Doesn't one of our existing t/ scripts do that?
> 
> ;-) I did not forget... t1200-tutorial.sh
> 
> But it serves a different purpose: it makes sure that we did not break the 
> commands in the tutorial. (I fear that the script and the tutorial have 
> diverged a little bit, though).
> 
> git-tutorial should not test that, rather it should show the user what is 
> possible, and encourage playing with git.

Something like Cogito tutorial-script?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

