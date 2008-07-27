From: Daniel White <daniel@whitehouse.id.au>
Subject: Re: [StGit PATCH] Fixed default install location
Date: Sun, 27 Jul 2008 16:27:50 +1000
Message-ID: <20080727162750.25b7cdf3@whitehouse.id.au>
References: <20080724202031.55dec8e8@whitehouse.id.au>
 <b0943d9e0807251446w1e9ed73erfa7c1638191d88a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 08:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN06c-0007vp-9a
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbYG0Gus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbYG0Gus
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:50:48 -0400
Received: from smtpgw02.myhostguy.com ([216.10.240.225]:2957 "EHLO
	smtpgw02.myhostguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbYG0Gur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:50:47 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw02.myhostguy.com with SMTP;
   Sat, 26 Jul 2008 23:46:54 -0700
Received: from UnknownHost [118.107.63.169] by mx252n.mysite4now.com with SMTP;
   Sat, 26 Jul 2008 23:48:09 -0700
In-Reply-To: <b0943d9e0807251446w1e9ed73erfa7c1638191d88a@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90323>

"Catalin Marinas" <catalin.marinas@gmail.com> wrote:
> 
> I also use "python setup.py bdist_rpm" when releasing, I think it will
> get confused by a different prefix.
> 

Not being familiar with distutils, I didn't even see that use case.

Regardless, the instructions are incorrect and the behaviour surprising.
When I installed this in a cygwin environment, it went on to clobber
my system directories.

Would it be more useful to have the Makefile handle the general case and
setup.py for more specialised cases, such as generating an rpm?

I've thrown some patches together that does some of this.  I can tidy
these up and put them in a public repository if this sounds like a
reasonable plan of attack.

-- 
Daniel White
