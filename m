From: Sam Ravnborg <sam@ravnborg.org>
Subject: Howto send many commits as mail-patches?
Date: Tue, 3 Jan 2006 12:38:59 +0100
Message-ID: <20060103113859.GA15832@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 03 12:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtkVV-0008UP-Tw
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 12:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWACLjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 06:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWACLjL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 06:39:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60690 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751378AbWACLjK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 06:39:10 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 81C661EC32B
	for <git@vger.kernel.org>; Tue,  3 Jan 2006 12:39:06 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 14DC843C050; Tue,  3 Jan 2006 12:38:59 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14147>

Hi all.

I have a collection of commits in my GIT repository that I like to send
out to linux-kernel.
But my initial experiments with git-send-emails.perl fall out bad.

I did the following:

1) First I created a mbox with the patches:
git format-patch -n --mbox --stdout -M -B b286e39207237e2f6929959372bf66d9a8d05a82 > mbox

The mbox looked OK. -M -B were from the man page and since the patchset
includes a number of renames it made the mbox considerably smaller.

So I went on an tried to send the mails:
git-send-email.perl --from "Sam Ravnborg <sam@ravnborg.org>" --to "sam@ravnborg.org" --chain-reply-to "" mbox

It just send out two huge mails containing all of the mbox.
Also it cc:ed all people included in "Signed-off-by". That is sometimes
a nice feature but for testing I like it to be optional.

Can someone give me a nice howto so I can see how to send out the mails.

TIA,
	Sam
