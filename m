From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 17:10:16 -0400
Message-ID: <20060523211016.GB16164@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> <20060523065232.GA6180@coredump.intra.peff.net> <20060523070007.GC6180@coredump.intra.peff.net> <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com> <Pine.LNX.4.64.0605230948280.5623@g5.osdl.org> <Pine.LNX.4.64.0605231232360.5623@g5.osdl.org> <46a038f90605231329w35d10cfdg1ac413ebf8d32e11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 23:10:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fie9B-0003Pg-9l
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWEWVKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWEWVKU
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:10:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11237 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932275AbWEWVKS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 17:10:18 -0400
Received: (qmail 49399 invoked from network); 23 May 2006 21:10:16 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 21:10:16 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 17:10:16 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90605231329w35d10cfdg1ac413ebf8d32e11@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20639>

On Wed, May 24, 2006 at 08:29:07AM +1200, Martin Langhoff wrote:

> Strange! Cannot repro here with v5.8.8 (debian/etch 5.8.8-4) but
> initialising it doesn't hurt, so let's do it:

I can reproduce with debian perl 5.8.8-4. The bug is only triggered by
0-length files, so presumably your test repo doesn't have any.

-Peff
