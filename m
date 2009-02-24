From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Addresses with full names in patch emails
Date: Tue, 24 Feb 2009 07:38:44 -0800
Message-ID: <49A41484.1010501@oak.homeunix.org>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org> <1234926043-7471-2-git-send-email-marcel@oak.homeunix.org> <200902182255.13983.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"fg@one2team.net" <fg@one2team.net>,
	"giuseppe.bilotta@gmail.com" <giuseppe.bilotta@gmail.com>,
	"pasky@suse.cz" <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzOW-0004xk-B3
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZBXPjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbZBXPjA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:39:00 -0500
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:28226 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755241AbZBXPi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 10:38:59 -0500
Received: (qmail 55430 invoked from network); 24 Feb 2009 15:38:57 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp126.sbc.mail.sp1.yahoo.com with SMTP; 24 Feb 2009 15:38:57 -0000
X-YMail-OSG: XamrwnsVM1msu5g_OolHJGkha5dOMexFZQbLfJfx8oyGbPlM_EEc8ivXrB0vjkq6qKMmlov3IIPtbuyATLgkYBYOv6NoqrunqK98wCqtJVOQ1_J99Tt8qUQ7Pg6hE32pkhIWgCwvIn_X2Oll.jtiiKoQTecqHcMmlMnJfsHukcbCohrg09VtxJg-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LbzN1-0000Ue-Af; Tue, 24 Feb 2009 07:38:55 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <200902182255.13983.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111298>

Thanks for the two patch tweaks.

Jakub Narebski wrote:
> P.S. Why bare emails (without user names), e.g. "pasky@suse.cz"
> and not "Petr Baudis <pasky@suse.cz>"? Just curious...

I've been using "git send-email" for patches, and have Thunderbird as my
MUA otherwise.  (I'd use (al)pine if I could make it work with
Exchange/NTLM at work, but that's another story...)  I've been
transfering recipients (--to and --cc) from Thunderbird to the
commandline with copy/paste.

In Thurderbird, copying an email address from a message only gets you
the user@domain part, not the "Full Name" <user@domain>.  To get the
"Full Name" <user@domain> I would have to View Message Source and
pickout the CC line, which is marginally harder.

And on the commandline, instead of just pasting an email as a shell
word, I'd have to add single quotes (I think) to keep the whole "Full
Name" <user@domain> as one word and quote the shell meta characters.

Neither piece is all that onerous, I guess.  Sounds like you would see
some value in the full names.  Maybe I'll try including them on my next
patch.  Looks like --cc-cmd or sendemail.aliasesfile might make it
easier, but I'd have to set them up.

Marcel
