From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 11 Nov 2007 07:43:37 +0900
Message-ID: <87ir49afhi.fsf@catnip.gol.com>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
	<Pine.LNX.4.64.0711071110040.4362@racer.site>
	<18225.48553.44088.269677@lisa.zopyra.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:44:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqz3c-0004SK-PM
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbXKJWnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbXKJWnu
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:43:50 -0500
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:57072 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbXKJWnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 17:43:49 -0500
Received: from 203-216-100-114.dsl.gol.ne.jp ([203.216.100.114] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1Iqz3D-0007GZ-H1; Sun, 11 Nov 2007 07:43:39 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 8E2382FF6; Sun, 11 Nov 2007 07:43:37 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <18225.48553.44088.269677@lisa.zopyra.com> (Bill Lear's message of "Wed\, 7 Nov 2007 07\:29\:13 -0600")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64384>

Bill Lear <rael@zopyra.com> writes:
> Why do you find it objectionable?

It bloats the code, and makes it less readable.

[My conjecture is that the latter happens because braces are so visually
striking that they attract the eye; for _long_ blocks, this property of
braces helps, because it makes it easier to find them amongst the rest
of the code, but for _short_ blocks, it hurts, because it draws the eye
away from the actual code, and emphasizes structure at a time when
structure doesn't need emphasizing (because it's utterly obvious already
with such short blocks).]

-Miles

-- 
Run away!  Run away!
