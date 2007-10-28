From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: New features in gitk
Date: Sun, 28 Oct 2007 08:36:10 +0100
Message-ID: <5209A0B4-520E-4EC2-9901-C83C34652313@zib.de>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2g8-0007jz-DH
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXJ1HfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbXJ1HfL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:35:11 -0400
Received: from mailer.zib.de ([130.73.108.11]:62616 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXJ1HfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:35:10 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9S7YhKw012297;
	Sun, 28 Oct 2007 08:34:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9S7Yg40018364
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 08:34:42 +0100 (MET)
In-Reply-To: <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62534>


On Oct 28, 2007, at 8:11 AM, Paul Mackerras wrote:

> Linus Torvalds writes:
>
>> However, that crazy green bar chasing back-and-forth int he "reading"
>> phase is really quite visually distracting. Maybe it looks better in
>> Tk8.5, but it does look pretty annoying in the version I have. Can  
>> you
>> tone that down a bit?

I have the same impression.


> Yeah.  Actually what I'd like is to know how many commits git log is
> going to give me, so that I can do a normal progress bar whose length
> is proportional to commits_read / total_commits.

Can you use something like a rotating wheel, if the total size
of the task is unknown.

Or if you know an upper bound on the number of expected commits,
you could use this as total_commits. And adjust the upper
bound if more information becomes available.

Or you just print the number of commits already read and the
user is happy because something is changing.

	Steffen
