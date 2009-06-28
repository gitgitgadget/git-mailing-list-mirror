From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 7/9] gitweb: picon avatar provider
Date: Sun, 28 Jun 2009 18:03:58 +0200
Message-ID: <cb7bb73a0906280903y3175712bx6923b179a9789a1d@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906281335.40312.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 18:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKwrQ-0004jR-Fg
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 18:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbZF1QD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2009 12:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZF1QD5
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 12:03:57 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:56922 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZF1QD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jun 2009 12:03:56 -0400
Received: by bwz9 with SMTP id 9so2840502bwz.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RQxNURV7B9MVYv0i9aqoSLPH+JmVyPvbWPG47vyWoBA=;
        b=INR3LQQZ00qFD1XQNdexPQTXwHyCJIuIpCK7kUEtOuXmHs4v0lcJWTO++hmdLLO0uv
         ghmAPhtb+cMfjR69LZuUSeRJSAVN4teYHfQM7vBuKWgNkIGqFmmvlzymK65d6yRE4w2W
         LFG2dgSmEfNfSgekoWGNnxalf72btoV6lDibc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XFmZ8vq/waBNL1YloGlpo2nY+FjJse5o2aVZALovB6q6CcsgTkBoa2Qjnw+nMO07sB
         qEQc6koPJ484yqj/qDb8vcdLEeWY2jt5N2Mpf9kOlV10j4ktLeBa0ZyOovs+AcfpJxny
         KBMsJ+03hBm/dgnggWiVnXn4yJFMFh6F6msRQ=
Received: by 10.204.122.200 with SMTP id m8mr6102188bkr.176.1246205038450; 
	Sun, 28 Jun 2009 09:03:58 -0700 (PDT)
In-Reply-To: <200906281335.40312.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122411>

2009/6/28 Jakub Narebski <jnareb@gmail.com>:
> Thoughts for the possible future enhancements: find final URL of an i=
mage
> via http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/$domain=
/$user/users+domains+unknown/up/off/1/order
> by scrapping (parsing) it for .gif link, and store this URL in cache.
> But that most probably isn't worth it. =A0Just feel like mentioning i=
t.

That was my first thought, but since piconsearch offers a link
directly, I decided it was much better to use that rather than html
scraping.

> Should it be stated that <img width=3D"$size" ...> is here because no=
t
> all kinds of avatars (not all avatar providers) support selecting siz=
e
> of avatar, somewhere in this comment?

It is generally good form to have the size specified in advance in
HTML anyway, which is why on later iterations I put the width spec in
the first avatar service commit.

--=20
Giuseppe "Oblomov" Bilotta
