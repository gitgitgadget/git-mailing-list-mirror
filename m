From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Git.pm
Date: Fri, 11 May 2012 09:56:44 -0700
Message-ID: <86likyy7ub.fsf@red.stonehenge.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
	<CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
	<CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
	<20120426203136.GA15432@burratino>
	<CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 18:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSt9E-0003hu-G1
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 18:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760559Ab2EKQ4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 12:56:51 -0400
Received: from lax-gw16.mailroute.net ([199.89.0.116]:58840 "EHLO
	gw16.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab2EKQ4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 12:56:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw16.lax01.mailroute.net (Postfix) with ESMTP id 4D4635BC4D7;
	Fri, 11 May 2012 16:56:46 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw16.lax01.mailroute.net ([199.89.0.116])
	by localhost (gw16.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id ZCEjxV5mxG-k; Fri, 11 May 2012 16:56:45 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw16.lax01.mailroute.net (Postfix) with ESMTP id 068D25BC4A4;
	Fri, 11 May 2012 16:56:45 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id E85E7270B; Fri, 11 May 2012 09:56:44 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.16; tzolkin = 1 Cib; haab = 19 Uo
In-Reply-To: <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
	(Subho Banerjee's message of "Thu, 10 May 2012 18:49:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197678>

>>>>> "Subho" == Subho Banerjee <subs.zero@gmail.com> writes:

Subho> I have started looking into how the error catching mechanism
Subho> implemented right now. I have looked into the more modern error
Subho> catching/throwing mechanisms in use in perl, and I am of the opinion
Subho> that Try::Simple would probably be the best candidate for being the
Subho> new error catching mechanism. I also wanted to discuss some aspects of
Subho> the changes to be made -

Try::Tiny is preferred to Try::Simple.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
