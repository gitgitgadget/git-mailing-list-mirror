From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable output
Date: Mon, 21 May 2007 22:58:12 +0200
Message-ID: <20070521205812.GO4085@planck.djpig.de>
References: <20070520225953.GK4085@planck.djpig.de> <11797696193384-git-send-email-frank@lichtenheld.de> <20070521195423.GC5082@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 21 22:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqExV-0007lL-B2
	for gcvg-git@gmane.org; Mon, 21 May 2007 22:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbXEUU6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbXEUU6S
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 16:58:18 -0400
Received: from planck.djpig.de ([85.10.192.180]:3631 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbXEUU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 16:58:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 8B36688060;
	Mon, 21 May 2007 22:58:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96Fje8JuTqaP; Mon, 21 May 2007 22:58:12 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id ACC2E880FC; Mon, 21 May 2007 22:58:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070521195423.GC5082@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48050>

On Mon, May 21, 2007 at 09:54:23PM +0200, Jan Hudec wrote:
> On Mon, May 21, 2007 at 19:46:59 +0200, Frank Lichtenheld wrote:
> > This option will enclose key names in quotes (") if they
> > contain a subsection and then escape " and \. It will also
> > escape line breaks in values. Together this should produce
> > an easily parsable output.
> 
> That will lead to either eval (which runs perl parser and probably won't win
> anything) or regexps (which is not big win over parsing the .ini directly
> with them) on the perl side. IMHO only thing that would actually be faster is
> NUL-separated entries.

> Either:
>     KEY <NUL> VALUE <NUL>
> 
> or:
>     KEY <TAB> VALUE <NUL>

Both subsection names and values can contain <TAB> characters, so the
latter isn't possible.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
