From: git@drmicha.warpmail.net
Subject: Re: [PATCH] git-branch.txt: document -f correctly
Date: Tue, 17 Mar 2009 17:51:08 +0100
Message-ID: <49BFD4FC.40707@drmicha.warpmail.net>
References: <450196A1AAAE4B42A00A8B27A59278E70A3FC05C@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 18:07:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjckT-00076M-Lo
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 18:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075AbZCQRFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 13:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757979AbZCQRFJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 13:05:09 -0400
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:55985 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757623AbZCQRFH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 13:05:07 -0400
X-Greylist: delayed 812 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 13:05:07 EDT
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 9CBCF212C38;
	Tue, 17 Mar 2009 17:51:22 +0100 (CET)
Received: from tu-clausthal.de (poseidon [139.174.2.21])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 8E8D6212C37;
	Tue, 17 Mar 2009 17:51:22 +0100 (CET)
Received: from [139.174.44.12] (account mjg HELO localhost.localdomain)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.2.13)
  with ESMTPSA id 41674429; Tue, 17 Mar 2009 17:51:22 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A3FC05C@EXCHANGE.trad.tradestation.com>
X-Enigmail-Version: 0.96a
X-Virus-Scanned: by PureMessage V5.5 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113508>

John Dlugosz venit, vidit, dixit 17.03.2009 17:07:
> ===  Re: ===
> BTW, I noticed that 'git-subcmd' is used everywhere in here which does
> not feel right, but I followed the existing style, leaving a consistent
> clean-up for a later patch. Also, typesetting is inconsistent:
> We have <branch> as well as `<branch>` when the text talks about the
> options. Do we have a style guide or such?
> === end ===
> 
> I would agree that being factually correct and available immediately
> trumps being wrong but pretty.

I can't really make much sense out of this but I guess I doesn't matter.
In any case, by "style guide" I mean something saying "write options as
monospaced", "write git commands without dash unless in links"...

> As an experienced writer and editor, the documentation is something I
> might hack long before I tackle the code.  I see you edited a file with
> .txt extension, and some kind of markup that's not the HTML files I'm
> reading.  Beyond any kind of style guide, is there a guide to the
> documentation _system_ in use?

It's asciidoc. Rather, asciidoc 7ish, current asciidoc is at 8.4.1.
The backticks are used for displaying commands, e.g., and usually come
out as monospaced in html, underlined in man.

Cheers,
Michael
