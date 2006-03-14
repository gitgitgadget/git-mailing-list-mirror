From: Paul Jakma <paul@clubi.ie>
Subject: Re: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 17:04:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
 <Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 14 18:11:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJCyR-0005HT-9S
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbWCNRGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbWCNRGQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:06:16 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:25473 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1752265AbWCNRGQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 12:06:16 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1+yADAEGy3x6o81jt5L4LVreanzToAqji4@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2EH4tDV023416;
	Tue, 14 Mar 2006 17:05:07 GMT
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17590>

On Tue, 14 Mar 2006, Linus Torvalds wrote:

> The simplest thing to do is to do
>
> 	git reset
>
> to reset your index back to your HEAD (but obviously DON'T use the "-f"
> flag, which will also force the working tree!).

Ah, of course! (I knew I was being dumb ;) ).

> Then you can just do
>
> 	git commit -o bar
>
> and everything should be fine, because then git doesn't think you're doing
> something insane.

Yep, thank you!

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
The less a statesman amounts to, the more he loves the flag.
 		-- Kin Hubbard
