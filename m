From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Mon, 01 Jun 2015 21:26:48 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <3813728.oJDPxEPYet@cs-pc>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com> <556C0BFD.3060806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org,
	sbeller@google.com, tr@thomasrast.ch, jk@jk.gs,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com
To: git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Mon Jun 01 21:35:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzVUe-0000Kw-Ca
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 21:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbbFATfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 15:35:24 -0400
Received: from smtp6.rz.tu-harburg.de ([134.28.205.36]:36503 "EHLO
	smtp6.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbFATfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 15:35:22 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2015 15:35:22 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.tu-harburg.de", Issuer "TUHH CA in DFN-PKI Global - G01" (verified OK))
	by smtp6.rz.tu-harburg.de (Postfix) with ESMTPS id 3m0mhv4k6bzGmT0;
	Mon,  1 Jun 2015 21:26:55 +0200 (CEST)
Received: from mailspring.rz.tu-harburg.de (mailspring.rz.tu-harburg.de [134.28.202.181])
	(user=alucst mech=PLAIN)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id t51JQtJj023287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 21:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2015-23;
	t=1433186815; bh=t/JJ43lQMDQArjT/wUze7yhdUCzYCgj0W/qmyCwFWck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C7MgvRUxsMoqumyRNn+IIcFaqYMg7VibwvwDXPS21TmO3+oaRECUIF698N63BVD/b
	 QjZqZkBO7yTdgBuMzD0WuExzoc2QLFFMd4RRKrY2iDmCMwueazNhLNckS1/zCPeNjt
	 BCtFABDdArgW4KE3dor32qvCX6nDpRi38mZAIaRY=
User-Agent: KMail/4.13 (Linux/3.13.0-52-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <556C0BFD.3060806@drmicha.warpmail.net>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270464>

Am Montag, 1. Juni 2015, 09:38:37 schrieb git@drmicha.warpmail.net:
> Ralf Thielow venit, vidit, dixit 29.05.2015 20:54:
> > The term "index" is translated as "Staging-Area" to
> > not confuse beginners who don't know about Git's index.
> > 
> > Since the term "staging area" doesn't appear in original
> > Git messages (not even in the glossary) and "index" is a
> > well known term for experienced users, we should treat
> > "index" as a Git term and therefore don't translate it.
> 
> Super! :)

Sorry to contradict, but: No, not super.

Again I question the whole point of such a denglish translation. Do you want 
to present the git wording to those experienced users who know git anyway? 
Then you are probably better off suggesting those guys to stick to the 
original English messages. Or do you want to describe what's going on in a 
language that somewhat resembles understandable German? In that case, "Index" 
is a particularly bad choice to keep as an unchanged word. 

To make things even worse, "index" is a particularly bad wording choice in 
English in the first place. Why? Because the e.g. git book of course has an 
"index": That's the page where you can look up certain keywords that will then 
reference you to the place where those words are being used. It never occurred 
to me why anyone on earth ever thought this word might give a good metaphor 
for what it should mean in the git context. Well, maybe some internal code 
gurus will now immediately argue how this is exactly how git's index works 
internally. Guess what? As a git user, this is not a single bit of how the 
index concept is visible to the user. As a git user, the index has something 
to do with "already but not yet", or with "not only in the working copy but 
also already somewhere else", or with "not yet in a commit but somewhat half-
way there". All those points could maybe be captured in some other wording, 
but for sure neither in the English "index" nor (and even less) in a German 
"Index". 

Hence, if the word isn't part of a command name, the translators are free to 
decide which word to use, and you could probably choose some word that is 
actually helpful in the target language. "Index" is not. In case you belong to 
the 0.5% of version control users who are experienced enough with git to know 
and understand the English term "index", feel free to stick with that word. 
But in case you target this translation to the somewhat majority of version 
control users, I suggest you better think again.  Thanks for reading.

Best Regards,

Christian


PS: Just for the record: If I explain git to new users and we reach the 
"index" concept, my explanation routinely says "This concept is called 'index' 
but it has nothing to do with any associations you make with that word. Better 
remember this thingy as *** and replace the termin 'index' with *** every time 
you read about it." where "***" is my preferred translation. The facial 
expressions of the audience regarding "index" regularly confirm this approach 
as the better one. I never encountered anyone who says "Oh, but isn't 'index' 
a much better term for this than what you said..."
