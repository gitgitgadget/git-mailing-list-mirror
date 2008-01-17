From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 18:52:57 +0000
Message-ID: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZsH-000804-RS
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbYAQSxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 13:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYAQSxD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:53:03 -0500
Received: from mail.sl.pt ([212.55.140.13]:36259 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754446AbYAQSxB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 13:53:01 -0500
Received: (qmail 26203 invoked from network); 17 Jan 2008 18:52:58 -0000
X-Virus-Status: Clean (0.01579 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.05524 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[81.193.151.201])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <mjscod@web.de>; 17 Jan 2008 18:52:58 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 81.193.151.201 as permitted sender)
In-Reply-To: <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70903>

Hi,

On Jan 17, 2008, at 6:42 PM, Linus Torvalds wrote:
> Too many people confuse "character" and "glyph". They are different.

This is very true.


> The fact is that "equivalent" does not mean "same". Why cannot people
> accept that?

I'll shut up now if you can answer me one question,  because it =20
really is a problem for my team.

We have people using windows, people using Macs, and people using =20
several flavors of Linux desktops. They all have different settings =20
and if I add a file like =E1=E9i=F3=FA that happens to be UTF-8 encoded=
, it =20
will reach a iso-latin-1 user as visual garbage. git will track the =20
file perfectly, we know that, because the sequence of bytes that my =20
system used to create the file will be the same on all "sane" =20
systems, but the file will look "funny" to some users, and we get =20
complaints for some less enlightened ones.

The answer is that users should not create filenames with non-ascii =20
characters if they want a consistent experience, right?

This is just so that I can write a best practices document to them...

Best regards,
--=20
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
