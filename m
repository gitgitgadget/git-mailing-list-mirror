From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 06 Sep 2007 12:21:46 +0200
Message-ID: <46DFD4BA.2000401@op5.se>
References: <vpq642pkoln.fsf@bauges.imag.fr>	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>	<20070906045942.GR18160@spearce.org> <46DFC490.3060200@op5.se> <7vhcm8b0h8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:22:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEVA-0000v3-0j
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXIFKVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 06:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXIFKVx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:21:53 -0400
Received: from mail.op5.se ([193.201.96.20]:55548 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbXIFKVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 06:21:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7FF4F194472;
	Thu,  6 Sep 2007 12:21:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aRkgRvFx0iOF; Thu,  6 Sep 2007 12:21:49 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 50E4B19446E;
	Thu,  6 Sep 2007 12:21:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vhcm8b0h8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57858>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Git is cheating a bit though. Its primary audience was (and is) the
>> various integrators working on the Linux kernel, all of whom are fairly
>> competent C programmers.
> 
> Do we still have a huge overlap with the kernel people?  I had
> an impression that patches from the kernel folks, with notable
> exception from a handful (you know who you are), have petered
> out rapidly after the first several weeks.

True, but the point I was trying to make is that because git is written
in C, for an audience who are extremely at home with that particular
language, it quickly attracted contributors.

git log --pretty=short | sed -n 's/^Author: \([^<]*\)<.*$/\1/p' | \
	sort | uniq | wc -l

reports 355 unique lines, although some authors are mentioned twice
(Theodore Tso vs Theodore Ts'o). Cross-matching the kernel authors
with the git authors shows that git and linux have 111 developers
in common, again reporting some of them twice. A quick visual scan
shows the figure to be 106, assuming no two authors have the same
name (including email addresses produced more unique contributors as
people change email more often than they change name).

It's not unreasonable to say that git got at least 106 C-programmers
"for free" included in their userbase round about the same second
Linus went public with his intentions of managing the linux kernel
in git, all of which are obviously comfortable enough with C to
poke around in the kernel.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
