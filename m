From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: How do gmail users try out patches from this list?
Date: Wed, 12 Aug 2009 00:14:08 +0200
Message-ID: <20090811221408.GC12956@vidovic>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 00:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mazbr-0003tJ-8U
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 00:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbZHKWON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbZHKWON
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 18:14:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:34352 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbZHKWOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 18:14:12 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1140159eyd.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=diHubsTK2z1KtjGwbLMZsZEAhvQacTeBjQ2+iubfIrE=;
        b=oL7tbO01FV8yWyjSZH6obZobzXZRtkucr5uUtPfec1sslxCgoA7dUH0X4HQm51nxC6
         zMmZ8SvyxI30CL4FuITrUU4LeH+ufaW5S8l/fxOEOK3cVeT72CpOqzaCWJpn6qMTUb9O
         APrjVOKPTODqLvIzT7uJgBuxPf2Y1/tMZcAW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gYqTRuBeI6Ua+mswESjJl55LGiRusNGR5/QVaL8Vo2PnMrfhtkbQ8qCWcsnZAoDqdC
         cdYx4Vj67RW/Iyk6gdIGxvcU3ZZxydCBm8Wy88oQNgdGAzsmpxdxtB/Mp38nV12loyLk
         nE6UeIMBVsVQjR6F7jAwL6cpJm1lawbV5GVV4=
Received: by 10.210.102.12 with SMTP id z12mr7109875ebb.5.1250028853074;
        Tue, 11 Aug 2009 15:14:13 -0700 (PDT)
Received: from @ (91-164-138-47.rev.libertysurf.net [91.164.138.47])
        by mx.google.com with ESMTPS id 28sm1066591eyg.42.2009.08.11.15.14.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 15:14:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125609>

The 11/08/09, skillzero@gmail.com wrote:

> Sorry if this is dumb question, but I didn't see any good info in my searches.
> 
> How do gmail users normally apply patches that come through the list?

It doesn't rely on your address mail provider but on your local email
workflow/MUA.

> Do you just manually copy and paste the email to patch files and use
> git apply? Do you use a tool to export to mbox files and use git am?

Yes, that's what most users do. As I use local maildirs instead of
mailboxes, I copy the patches (from mutt) into a dedicated maildir (one
per project) and directly 'git am' the e-mails.


-- 
Nicolas Sebrecht
