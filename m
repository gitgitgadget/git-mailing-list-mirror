From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 11:56:03 -0400
Message-ID: <1191599763.7117.18.camel@hinata.boston.redhat.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	 <Pine.LNX.4.64.0710042209410.4174@racer.site>
	 <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	 <4705FB52.3030208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:56:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdpXM-0001Xr-Ir
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759340AbXJEP4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759443AbXJEP4P
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:56:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37563 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759340AbXJEP4O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:56:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l95Fu9Fm003467;
	Fri, 5 Oct 2007 11:56:10 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l95Fu9i8022516;
	Fri, 5 Oct 2007 11:56:09 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l95Fu8A4012160;
	Fri, 5 Oct 2007 11:56:08 -0400
In-Reply-To: <4705FB52.3030208@op5.se>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60098>

> I just don't do 'git commit -a' for the same reason I don't do
> 'git commit -m', really. It tends to be habit-forming, and bisect
> has saved my arse enough times for me to *want* my changes to be
> small and isolated. Debugging a 5-line patch is so much more pleasant
> than debugging a 30k-lines one that spans over several different files.

I understand why people like staging and commit without -a, seeing how
it's faster and all, but I have a serious problem with this practice
that I haven't seen brought up on the list.  How do you know what you
commit actually works or even compiles?  The reason that I almost
exclusively use -a with commit is that I want to know that what I just
compiled and tested is what I will be committing.  I don't want to just
commit half the files in my working copy, I want to make sure that the
exact state of my project that I just compiled and tested is what gets
into version controlled history.

git commit -a isn't sloppy to me - eye balling some subset of your
working copy and committing that under the assumption that you don't
make mistakes and don't need to compile what you commit... that is
sloppy.

Kristian
