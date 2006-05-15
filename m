From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 12:10:36 -0700
Message-ID: <20060515190953.GA4368@localdomain>
References: <1147660345772-git-send-email-normalperson@yhbt.net> <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net> <20060515092704.GB6855@localdomain> <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net> <20060515101142.GD6855@localdomain> <46a038f90605150337l3357ce3by22834823eee7b87c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 21:10:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfiSp-0007rJ-Nh
	for gcvg-git@gmane.org; Mon, 15 May 2006 21:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWEOTKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWEOTKj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 15:10:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53927 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965149AbWEOTKi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 15:10:38 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C60652DC01A;
	Mon, 15 May 2006 12:10:36 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 May 2006 12:10:36 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90605150337l3357ce3by22834823eee7b87c@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20078>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Thanks Eric! git-send-email used to default to using local binaries.
> It was only with the switch to Net::SMTP that the default changed to
> localhost:25.

You're welcome.

That's odd, though, looking at Mail::Sendmail, I don't think it actually
uses the sendmail binary, either.  The FAQ
<http://alma.ch/perl/Mail-Sendmail-FAQ.html> confirms this, too.

Of course documentation may be lying and the code I'm looking at may be
*very* well obfuscated :D

-- 
Eric Wong
