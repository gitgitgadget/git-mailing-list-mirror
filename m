From: Daniel White <daniel@whitehouse.id.au>
Subject: Re: [StGit] Debian packaging update
Date: Fri, 22 Aug 2008 23:51:54 +1000
Message-ID: <20080822235154.5e1f979c@whitehouse.id.au>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
	<b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Karl =?UTF-8?B?SGFzc2Vsc3Ryw7Zt?=" <kha@treskal.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWX5E-000362-4M
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYHVNwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYHVNwk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:52:40 -0400
Received: from smtpgw02.myhostguy.com ([216.10.240.236]:3592 "EHLO
	smtpgw02.myhostguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbYHVNwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:52:40 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw02.myhostguy.com with SMTP;
   Fri, 22 Aug 2008 06:52:05 -0700
Received: from ppp118-208-1-137.lns1.bne1.internode.on.net [118.208.1.137] by mx252n.mysite4now.com with SMTP;
   Fri, 22 Aug 2008 06:51:56 -0700
In-Reply-To: <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93299>

On Thu, 21 Aug 2008 23:35:43 +0100
"Catalin Marinas" <catalin.marinas@gmail.com> wrote:
> 
> I'm not that versed in building debian packages but the .changes file
> generated is still reported as "i386" rather than "all". Is this
> expected?
>

I'm seeing the same issue by running dpkg-buildpackage.  However, I
tried building other arch-independent packages from source and still
got the same problem.  I suspect I might not be using the right set of
commands to generate the .changes file.

Since it is now packaged by Debian is it still necessary to be
maintaining Debian packaging?

Having a look at the Debian version, they have made quite a few changes
against our packaging.  It might be worth getting some patches from
them that are not specific to Debian policy (like the setup of bash
completion).

Regardless, it might be best to leave commit cf7b0b90 for now.

> Thanks.
> 

-- 
Daniel White
