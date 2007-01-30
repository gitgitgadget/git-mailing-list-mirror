From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 13:36:50 -0600
Message-ID: <17855.40530.256749.539318@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<17855.36470.309129.391271@lisa.zopyra.com>
	<Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
	<200701301950.00195.jnareb@gmail.com>
	<Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
	<17855.39008.920685.62837@lisa.zopyra.com>
	<Pine.LNX.4.63.0701302013420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBynG-0001Lk-1L
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbXA3Tgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbXA3Tgy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:36:54 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60288 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbXA3Tgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:36:54 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UJapH04669;
	Tue, 30 Jan 2007 13:36:51 -0600
In-Reply-To: <Pine.LNX.4.63.0701302013420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38196>

On Tuesday, January 30, 2007 at 20:15:37 (+0100) Johannes Schindelin writes:
>On Tue, 30 Jan 2007, Bill Lear wrote:
>> On Tuesday, January 30, 2007 at 11:04:57 (-0800) Linus Torvalds writes:
>> 
>> >Anyway, it's certainly easy to fix. Bill, you can either:
>> >
>> > - just rename the "topic" branch to "master"
>> 
>> I don't think I want this.  I want to know I'm on the topic branch of 
>> that repo, anything else really makes me nervous.
>
>The name in the bare repository does not matter as much as your _local_ 
>name.

Well, being a git newbie, it kinda matters to me.  I need linearity
right now.  Anything that swerves is likely to result in me and my
project stuck in the weeds.

So, I tried a straight fetch:

% GIT_DIR=. git fetch git://source/public/project

This has one branch:

% GIT_DIR=. git branch
  topic

Then a clone of that:

% cd over_there
% git clone /repos/git/project
[...]
% cd project
% git branch
  topic

All is well exactly what I want and expect ... except:

% ls -a
.  ..  .git

No checkout was done.  I'm finding this extremely confusing.

I just want to work on the branch, and I want it identified as such,
and I want it checked out, and I want some candy.

Sorry to whine, just wish I understood this better.


Bill
