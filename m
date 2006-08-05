From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 4/4] gitweb: No periods for error messages
Date: Fri, 4 Aug 2006 18:03:07 -0700 (PDT)
Message-ID: <20060805010307.17651.qmail@web31807.mail.mud.yahoo.com>
References: <7vpsfgghi2.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 05 03:03:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9AZN-0007yY-EW
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 03:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWHEBDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 21:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWHEBDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 21:03:09 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:20377 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422691AbWHEBDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 21:03:08 -0400
Received: (qmail 17657 invoked by uid 60001); 5 Aug 2006 01:03:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wFPg1aGdvPlFsGIFwAHQip+sB1FBA/lSdnOZDG9CYB0CdXixxzkzO8oapr8x/PL6c7JGQtKPicst4fOs5kpecIic8ps+HmHJ87Ky8kAeyE3ePpHy/tFZ0FtXDn47hbf89J5JPAoBYIhzEj5gzmMiyccpMjVu6hMYkLFRJHHRVLY=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 18:03:07 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsfgghi2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24873>

--- Junio C Hamano <junkio@cox.net> wrote:

> This and Jakub's [1/5] seem to be going the opposite way.

Not quite.  They both do the same thing, except his patch
does it only half way: 
  - no full stop for error messages ending with some kind
    of variable expansion.
  - full stop for static error messages.

> I tend to prefer ending each sentence with a full stop.

I've never seen this in, among other things,
  - kernel messages
  - errno messages
  - web server messages
  - RFC text describing error messages, (web services),
  - etc.

I was going for was consistency.  I'd say apply Jacob's [6/5].

   Luben
