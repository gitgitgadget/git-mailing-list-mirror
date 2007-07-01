From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 01 Jul 2007 18:53:01 +0200
Message-ID: <20070701165301.GJ7969MdfPADPa@greensroom.kotnet.org>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707011507310.4438@racer.site>
 <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
 <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 18:53:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I52fd-0001XM-Hy
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbXGAQxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbXGAQxG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:53:06 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:54185 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbXGAQxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:53:03 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKI00I80EWDKQ@smtp15.wxs.nl> for git@vger.kernel.org; Sun,
 01 Jul 2007 18:53:02 +0200 (CEST)
Received: (qmail 14010 invoked by uid 500); Sun, 01 Jul 2007 16:53:01 +0000
In-reply-to: <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51311>

On Sun, Jul 01, 2007 at 06:06:06PM +0200, Carlos Rica wrote:
> >> On Sun, 1 Jul 2007, Sven Verdoolaege wrote:
> >>
> >> > gpg: Warning: using insecure memory!
> >> > gpg: [don't know]: invalid packet (ctb=00)
> >> > gpg: read_keyblock: read error: invalid packet
> >> > gpg: enum_keyblocks failed: invalid keyring
> >> > gpg: skipped `C O Mitter <committer@example.com>': invalid keyring
> >> > gpg: signing failed: invalid keyring
> 
> I don't know if it could be due to the deleted t/t7004/trustdb.gpg file,
> you can check the same including it (if you didn't get it already):
> http://article.gmane.org/gmane.comp.version-control.git/51271

Doesn't seem to have any effect.

> Can you verify the other tags, like those from Junio on each version?

Apparently...

bash-3.00$ git-cat-file blob junio-gpg-pub | gpg --import
gpg: Warning: using insecure memory!
gpg: key F3119B9A: public key imported
gpg: Total number processed: 1
gpg:               imported: 1
bash-3.00$ git-verify-tag v1.5.2-rc2
gpg: Warning: using insecure memory!
gpg: Signature made Sun 06 May 2007 10:08:26 AM CEST using DSA key ID F3119B9A
gpg: Good signature from "[image of size 1532]"
gpg:                 aka "Junio C Hamano <junkio@cox.net>"
Could not find a valid trust path to the key.  Let's see whether we
can assign some missing owner trust values.

No path leading to one of our keys found.

gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
gpg: Fingerprint: 3565 2A26 2040 E066 C9A7  4A7D C0C6 D9A4 F311 9B9A
bash-3.00$ 

skimo
