From: Christian Stimming <stimming@tuhh.de>
Subject: Re: Translation process (was: [PATCH 3/5] Internationalization of git-gui)
Date: Sat, 21 Jul 2007 20:50:48 +0200
Message-ID: <200707212050.48568.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707211437.43524.stimming@tuhh.de> <85ps2l98eq.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 20:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICK2Y-0006qF-9N
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 20:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbXGUSuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbXGUSuk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 14:50:40 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45683 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbXGUSuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 14:50:39 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6LIoYJU021761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Jul 2007 20:50:34 +0200
Received: from [192.168.2.102] (p5490088F.dip0.t-ipconnect.de [84.144.8.143])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6LIoXrW032103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Jul 2007 20:50:34 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <85ps2l98eq.fsf@lola.goethe.zz>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53179>

Am Samstag, 21. Juli 2007 15:46 schrieb David Kastrup:
> Christian Stimming <stimming@tuhh.de> writes:
> > And a new German translation, so far 100% but many more strings are to
> > come.
>
> I have somewhat different proposals which sound less awkward, I
> think.  Of course, it is always a matter of taste whether a technical
> term should really be translated always, but assuming that, I'll make
> some German proposals.  Some may be tongue in cheek.

Thanks for the suggestions. However, I don't think it is of much worth to 
discuss individual message translations *right now*; instead, here's what I 
would propose instead:

The most difficult issue in a program translation is to find good translation 
wordings for those key words which are used each and every time throughout 
the program. Once you've decided on a particular translation for each of 
these words, the rest is just grunt work. So the important part is to 
translate these key words. Incidentally, I've added the file po/glossary.cvs 
for exactly this purpose. In there you find my current collection of key 
words that occur throughout git-gui (and git, for that matter), including a 
set of proposed translations to German language. This should be the place 
where the keyword translations should be discussed first. The discussion of 
the actual translations should be deferred until after the glossary 
translations have been discussed and agreed upon.

(I'm unsure whether the translations should be kept in the same glossary file; 
in the glossary for the gnucash project [1] we've actually added an extra 
directory and encourage translators to add an extra po file for their 
glossary translations. However, the glossary of gnucash has more than 150 
terms and many of them require to be defined clearly as well, as translators 
would otherwise be unable to translate them concisely. In git-gui, the 
glossary is 25 terms so far and I think the git documentation already 
contains enough definitions of all of them. Nevertheless, maybe it would make 
a better structure if the translations of the glossary are kept in a separate 
po file for each language. Hm.)

In short: Please discuss the glossary first, and not the actual de.po message 
file. Once the glossary has been decided upon, the de.po will be adapted, and 
*after that* a discussion of de.po makes sense. But not before that.

Regards,

Christian

[1] 
http://svn.gnucash.org/trac/browser/gnucash/trunk/po/glossary/gnc-glossary.txt
