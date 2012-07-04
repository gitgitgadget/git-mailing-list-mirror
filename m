From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Wed, 04 Jul 2012 22:14:03 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <1819393.sAuVItIfZO@cs-pc>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com> <2021839.rMjHRWft8I@cs-pc> <CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: trast@student.ethz.ch, jk@jk.gs, worldhello.net@gmail.com,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 22:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmVyV-0008L5-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 22:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299Ab2GDUOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 16:14:19 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:41527 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab2GDUOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 16:14:18 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q64KE9fL002385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 4 Jul 2012 22:14:09 +0200
Received: from cs-pc.localnet (e182111061.adsl.alicedsl.de [85.182.111.61])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q64KE8wq013830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 22:14:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-27;
	t=1341432849; bh=31csAESwWgm2BcuZ0qKAzIAMloqE+wYIgZkjn9Y8ZkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CTsnI74JaqvW8aOiVvsGcnNgFpc8ovFqIdRr6cemDKJnkzYQY1YNEg7SuGxzmbuV1
	 tgAsGo4PRbBGjUl+ihVLNv5xo5Wp4vePQ/Sm9EfUCYQDHmq6jn7wsw0Xz2rcelY3qr
	 LEFsiQWof5xYDamdDb72on8MGjQek5X9EfaV6oNA=
User-Agent: KMail/4.7.3 (Linux/3.0.0-22-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201014>

Hi Ralf,

Am Mittwoch, 4. Juli 2012, 09:20:40 schrieb Ralf Thielow:
> >> -msgstr "Du befindest dich auf keinem Zweig."
> >> +msgstr "Du bist gerade beim Neuaufbau."
> > 
> > Is "rebase" = "Neuaufbau"? My last thought on this wording was "rebase"
> > = "Umpflanzen".
> 
> According to the current state of the glossary on GitHub, "rebase" as a
> verb is translated as "neu aufbauen". There are already translations using
> this. For example:
> 
> #: builtin/remote.c:998
> #, c-format
> msgid "rebases onto remote %s"
> msgstr "baut neu auf externen Zweig %s auf"
> 
> In this translation, "rebase" is used as a noun for the very first time.
> So, I simply translate it with "Neuaufbau". In fact, we can use different
> translations for verbs and nouns. Not really sure whether we should do this
> for "rebase".
> 
> Using "Umpflanzen" for "rebase" as a noun, would result in
> msgstr "Du bist gerade beim Umplanzen."
> Using "Umplanzen" was a verb, would result in
> msgstr "Du planzt gerade um."
> 
> For me, "Umpflanzen" sounds a bit like "working with plants
> in the garden". I do not have a strong opinion on this, though.

That's true. The wording goes very far into gardening, which is an argument 
against it. An argument for it is that it consequently re-uses the tree and 
branch metaphor, which is indeed also related to gardening.

I thought "neu aufbauen" is probably useful in the context of the gc or fsck 
command... no strong opinion on this, too, though.

Thanks for the reminder of the glossary - indeed I forgot to check that first.

Regards,

Christian
