From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git-gui: Automatically spell check commit messages as the user types
Date: Mon, 4 Feb 2008 09:53:46 +0100
Message-ID: <5ED970B8-0196-4616-8968-6788B803EA7F@wincent.com>
References: <20080204084153.GA9997@spearce.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Flott <adam@npjh.com>, git@vger.kernel.org,
	Christian Stimming <stimming@tuhh.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 09:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLx6X-0001AB-RX
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 09:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbYBDIyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 03:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYBDIyT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 03:54:19 -0500
Received: from wincent.com ([72.3.236.74]:54765 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYBDIyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 03:54:18 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m148rlss007906;
	Mon, 4 Feb 2008 02:53:48 -0600
In-Reply-To: <20080204084153.GA9997@spearce.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72480>

El 4/2/2008, a las 9:41, Shawn O. Pearce escribi=F3:

> As you can see the commit message was rather long.  I used this
> feature the entire time while writing it, and I have to say, it
> saved me from my horrible spelling and typing skills.  It also
> didn't feel like there was any significant lag, although every
> once in a while it will mark a word that you are in the middle
> of typing as misspelled, and catch up and correct that once you
> finish the word.  I guess that's what you get for slowing down
> and taking a few extra milliseconds to move the fingers.  :)


Rather than sending off the text to be spellchecked at intervals, =20
couldn't you refrain from sending it when the cursor hasn't yet moved =20
past a word boundary? This is what most "check spelling as you type =20
implementations do".

eg. If you type "spellnig" and leave the cursor immediately after the =20
"g", the word won't be highlighted until you hit space or otherwise =20
cause the cursor to move beyond the word boundary.

Cheers,
Wincent
