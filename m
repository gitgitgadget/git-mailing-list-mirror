From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Pulling tags from git.git
Date: Mon, 20 Mar 2006 19:30:18 +0100
Message-ID: <87lkv5ynnp.fsf@mid.deneb.enyo.de>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
	<440D7A7D.8070507@op5.se> <87zmk0dq75.fsf@mid.deneb.enyo.de>
	<441064DD.2010903@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 21:07:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLQeb-0008RA-UT
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 21:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCTUGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 15:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWCTUGt
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 15:06:49 -0500
Received: from mail.enyo.de ([212.9.189.167]:2026 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932158AbWCTUGs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 15:06:48 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1FLQeM-0006Kt-IY; Mon, 20 Mar 2006 21:06:47 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1FLP90-0000UT-UQ; Mon, 20 Mar 2006 19:30:19 +0100
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <441064DD.2010903@op5.se> (Andreas Ericsson's message of "Thu, 09
	Mar 2006 18:24:45 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17765>

* Andreas Ericsson:

>> The current implementation is rather counter-intuitive because it's
>> much easier to create lightweight tags, and you wonder why they aren't
>> replicated by fetches (but some other tags are).

> Well, you wouldn't want to go through the trouble of writing a
> tag-message for a temporary tag, but signing and writing a short note
> for a tag that you intend those who share your workload to have is not
> that much of a bother imo.

It's not obvious from the git-tag documentation that signing makes a
difference down the road in terms of replication.  IOW, I don't
question the distinction per se, but it's counter-intuitive if you
aren't told about it.
