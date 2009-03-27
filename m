From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 14:35:13 +0100
Organization: Universitaetsklinikum Regensburg
Message-ID: <49CCE421.16918.2582FE84@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <37fcd2780903270524x1987a622wb9e693be41fc02c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:37:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCF2-000166-P2
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbZC0Nfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbZC0Nfa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:35:30 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:15324 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080AbZC0Nf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 09:35:29 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 3BF45AB83A;
	Fri, 27 Mar 2009 14:35:31 +0100 (CET)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id 26192AAE9D;
	Fri, 27 Mar 2009 14:35:31 +0100 (CET)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n2RDZKRk000384;
	Fri, 27 Mar 2009 14:35:20 +0100
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    27 Mar 09 14:35:20 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 27 Mar 09 14:35:15 +0100
In-reply-to: <37fcd2780903270524x1987a622wb9e693be41fc02c4@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589108@20090327.132908Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114888>

On 27 Mar 2009 at 15:24, Dmitry Potapov wrote:

> On Fri, Mar 27, 2009 at 10:21 AM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
> >
> > 1) The ability to use the file's time at the time of add/commit instead of the
> > current time, and the ability tho check outfiles with the times stored in the
> > repository.
> 
> To check out with the times stored in repository is a a bad idea, because it
> will screw up 'make'.

Hi,

I don't understand:
If I modify files, then do a make, then do check-in/check-out (and the file times 
are unchanged), how would that affect make?

If I do an "update/merge from remote" (there is no total ordering of release 
numbers anyway) without a "make clean" before, I'm having a problem anyway.

> 
> >
> > 2) Keyword substitution. I know it's controverse (dealing with binary files),
> > but I'd like to have some automatic version numbering keyword at least:
> > Initial idea is that every commit with a change increments the number by one,
> > and when merging numbers a and b, the resulting number is max(a, b) + 1.
> 
> I am not sure what you want to achieve by having this number. Also, take
> a look at "git describe", it may be close to what you want (or may be not).

Basically I want to support my laziness: The system will increment some number and 
maybe change some text automatically that I'm to lazy to do. OK, there are still 
many commands I'll have to learn. Unfortunately some command names are not as 
"crispy" as they could be (i.e. you cannot easily find the right command name if 
you know what you are looking for, and if you have a command name, it's not very 
clear what it really does). That makes it hard for the beginners.

Regards,
Ulrich
