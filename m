From: Bill Lear <rael@zopyra.com>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 14:24:09 -0600
Message-ID: <17875.28649.796301.17874@lisa.zopyra.com>
References: <17875.25882.784307.731860@lisa.zopyra.com>
	<20070214194919.GE28290@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 21:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQfv-0002AV-77
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbXBNUYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXBNUYT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:24:19 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60173 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932565AbXBNUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:24:18 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EKOA115522;
	Wed, 14 Feb 2007 14:24:10 -0600
Cc: git@vger.kernel.org
In-Reply-To: <20070214194919.GE28290@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39739>

On Wednesday, February 14, 2007 at 14:49:19 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> I have not yet figured this one out: I have not tagged anything, but
>> know that I checked in something lame sometime between now and two days
>> ago.  How do I get my working repo to be that as it was, say, yesterday?
>> 
>> Do I do:
>> 
>> % git log --since="2 days ago"
>> 
>> parse, the output for the commit I want, and then do
>> 
>> % git reset <SHA>
>
>No.  This would update your branch and your index to <SHA>, but
>leave your working directory alone.  That's not what you want here.
>
>Use `git checkout <SHA>` which will detach your HEAD and seek to
>the commit, leaving your current commit alone.  Later you can get
>back by `git checkout oldbranch`.

Ah, ok, then, you can use checkout with the SHA...

Junio, I was talking about just getting back to "lame" and inspecting,
fixing, etc., not getting rid of things back to then.


Bill
