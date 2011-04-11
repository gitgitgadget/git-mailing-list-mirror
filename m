From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 05:18:04 +0200
Message-ID: <201104110518.04413.chriscool@tuxfamily.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 05:18:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q97ds-0006ek-Cw
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 05:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab1DKDSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 23:18:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53878 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270Ab1DKDSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 23:18:14 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 092E9A62AC;
	Mon, 11 Apr 2011 05:18:05 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171301>

On Sunday 10 April 2011 17:11:46 Ramkumar Ramachandra wrote:
> Hi,
> 
> I've started working on building a sequencer for Git.  

So you are starting the GSoC early! Great!
When (or before) it really starts, just make sure you put your work on a 
public Git repository and you send status updates regularly (weekly if 
possible).

> 3. From the format of the TODO and DONE files, one more thing should
> be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> format.  This part will go into the sequencer.  Then I'll use a
> cherry-pick specific file to keep the command-line options.  Yes, I'm
> trying to work on Daniel's idea [3] from the very start.  Is this a
> good idea?

I think that the TODO and DONE file format will need at one point to include 
options and it is simpler if this change is done early. Using a cherry-pick 
specific file to keep the options is not very generic for a sequencer that could 
be used for many things.

For example, as we have rebase --interactive, we will probably want to have 
cherry-pick --interactive, and when editing the TODO file we might want to use 
different cherry-pick options when picking different commits.

This would also make the different cherry-pick options available when using 
rebase --interactive once it uses the sequencer.

> [1]:
> http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170908
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/162183 [3]:
> http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170834

[3] is missing here.

Thanks,
Christian.
