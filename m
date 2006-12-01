X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 01 Dec 2006 10:31:16 +0100
Message-ID: <456FF664.3060109@xs4all.nl>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>	<87ejrlvn7r.wl%cworth@cworth.org>	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>	<456EBBE7.8030404@op5.se>	<Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>	<20061130164046.GB17715@thunk.org>	<Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>	<Pine.LNX.4.64.0611301229290.9647@xanadu.home>	<87irgwu6e6.wl%cworth@cworth.org>	<ekn8s3$lh6$1@sea.gmane.org> <87fyc0u56z.wl%cworth@cworth.org> <456FEB53.7080703@op5.se>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 09:31:34 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <456FEB53.7080703@op5.se>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32878>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4jt-0005P9-3M for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759281AbWLAJbV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759284AbWLAJbV
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:31:21 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:61957 "EHLO
 smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP id S1759281AbWLAJbU
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:31:20 -0500
Received: from [192.168.0.101] (82-171-213-190.dsl.ip.tiscali.nl
 [82.171.213.190]) (authenticated bits=0) by smtp-vbr10.xs4all.nl
 (8.13.8/8.13.8) with ESMTP id kB19V5Th079087 (version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 1 Dec 2006 10:31:06 +0100
 (CET) (envelope-from hanwen@xs4all.nl)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson escreveu:
> Carl Worth wrote:
>>
>> See? Git _is_ harder to learn, and a user really cannot learn it
>> without being careful about the index right from the very beginning.
>>
> 
> I'm not so sure about that. I came from CVS / SVN, although I've fiddled
> quite a bit with other scm's as well. The two-step commit process of git
> didn't terrify me at all, and I had used git at least a month before I
> joined the mailing-list and found out that there's this thing called an

I still don't know exactly how to operate adds and commits from the
command line. I regularly get bitten by not supplying the -a and -i
options.

I'm coming from darcs, where you can select which each diff hunk
to put in a commit separately.

However, I almost never do that. I operate git like darcs, from the
emacs support mode.  I almost never do -a commits anyway, because with
emacs (M-x git-status) it's more natural to make functionally distinct
commits, at the risk of introducing non-tested tree states in the
repository.

-- 
