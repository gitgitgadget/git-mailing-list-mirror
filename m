From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: Re: ANNOUNCE: git2cl
Date: Fri, 2 Mar 2007 11:16:07 +0100
Message-ID: <20070302101607.GA6811@alberich.amd.com>
References: <87mz2wrp9u.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Josefsson" <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:19:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4rP-0003nE-Ce
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 11:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307AbXCBKTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 05:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933308AbXCBKTc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 05:19:32 -0500
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:7126 "EHLO
	outbound4-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933307AbXCBKTb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2007 05:19:31 -0500
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id 4D84E903CF2;
	Fri,  2 Mar 2007 10:19:25 +0000 (UTC)
Received: from mail10-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id 428B5280063;
	Fri,  2 Mar 2007 10:19:25 +0000 (UTC)
Received: from mail10-sin (localhost.localdomain [127.0.0.1])
	by mail10-sin-R.bigfish.com (Postfix) with ESMTP id DCD891600425;
	Fri,  2 Mar 2007 10:19:24 +0000 (UTC)
X-BigFish: VP
Received: by mail10-sin (MessageSwitch) id 1172830764719629_10640; Fri,  2 Mar 2007 10:19:24 +0000 (UCT)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail10-sin.bigfish.com (Postfix) with ESMTP id 12ED38F0065;
	Fri,  2 Mar 2007 10:19:23 +0000 (UTC)
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by ausb3extmailp01.amd.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l22AGOml024276;
	Fri, 2 Mar 2007 04:17:34 -0600
Received: from 163.181.22.102 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 02 Mar 2007 04:19:11 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh2.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 2 Mar 2007 04:19:10 -0600
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 2 Mar 2007 04:19:10 -0600
Received: from amd.com ([165.204.85.18]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.2499); Fri, 2 Mar 2007 11:16:07 +0100
Received: by amd.com (nbSMTP-1.00) for uid 41369 aherrma3@amd.com; Fri,
 2 Mar 2007 11:16:07 +0100 (CET)
In-Reply-To: <87mz2wrp9u.fsf@latte.josefsson.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-OriginalArrivalTime: 02 Mar 2007 10:16:07.0408 (UTC)
 FILETIME=[CAC3CF00:01C75CB3]
X-WSS-ID: 69F925952KW9551440-01-01
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41182>

On Fri, Mar 02, 2007 at 10:03:09AM +0100, Simon Josefsson wrote:
> Hi!  I really need proper GNU ChangeLog functionality for my projects,
> so I ended up writing my own script to do this in Perl.  Below is the
> README, but you can find more information at:
> 
> http://josefsson.org/git2cl/
> 


Hi,

Just for your interest ...
I downloaded git2cl version as of 02-Mar-2007 09:58, gave it a try and
received the following (while running the script for an current git
tree):



  #> git log --pretty --numstat --summary | ~/git2cl
  2007-02-28  Junio C Hamano <junkio@cox.net>

          * : Add recent changes to draft 1.5.1 release notes.



  Usage: POSIX::strftime(fmt, sec, min, hour, mday, mon, year, wday =
  -1, yday = -1, isdst = -1)
     at git2cl line 257, <> line 20.

So it seems that your script needs some improvement.


Regards,

Andreas
