From: Frederik Schwarzer <schwarzerf@gmail.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 2 Feb 2012 11:04:50 +0100
Message-ID: <201202021104.50534.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 11:05:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RstXV-0006aj-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab2BBKFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:05:06 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36458 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab2BBKFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 05:05:04 -0500
Received: by bkcjm19 with SMTP id jm19so1865357bkc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=to:subject:from:date:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=t7XPpQR8TOEhvBZzV1Ftx1D6RoCzqt8TkCqAViQ6iDU=;
        b=efZUJas5N6Z00tauzmojHCDUSmwxiJETH8nriKn2XFTSd3ZQwbJ6TxJYVjs2+i3FmI
         JFsP8bKGluzz4Srp1qEV/Q3/zKN9qy6+BRSGHXZcbPget6LpRViDNem/0pBDC+4pOly2
         0wcrlRG1/alLdkAVRhmfSGC+1H0Y+OfnCmgTw=
Received: by 10.204.145.82 with SMTP id c18mr970068bkv.121.1328177102793;
        Thu, 02 Feb 2012 02:05:02 -0800 (PST)
Received: from tamaki.localnet (77-23-27-98-dynip.superkabel.de. [77.23.27.98])
        by mx.google.com with ESMTPS id x20sm5483526bka.9.2012.02.02.02.05.01
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 02:05:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189612>

Am Donnerstag, 2. Februar 2012, 09:15:38 schrieben Sie:

(damn, my mail programme always answers to the sender only ...)

Hi,

> Jiang Xin <worldhello.net@gmail.com> writes:
> > 2012/2/2 Junio C Hamano <gitster@pobox.com>:
> > ...
> > 
> >>  (6) From time to time, the l10n coordinator will pull from
> >>  "git.git" when
> >>  
> >>     meaningful number of changes are made to the translatable
> >>     strings.  I hope this would happen much less often than
> >>     once per week, preferably much less frequently. The l10n
> >>     coordinator updates po/git.pot and makes a commit, and
> >>     notifies the l10n teams.
> > 
> > notifies the l10n teams using another mailing list maybe.
> 
> I personally think using the regular git@vger.kernel.org list would
> be preferrable for this.  People who translate would want to learn
> the reasoning that led to the final phrasing of the messages to
> come up with usable translation, and following the main list would
> be one way to do so. Having to follow two separate list will be an
> unnecessary burden.
> 
> But the choice of how to coordinate his or her work with the l10n
> teams is entirely up to the l10n coordinator.

As I see it there are two kinds of people doing translations. 
Developers who also translate and people who want to translate 
software but are not involved in the development.

Translations of the former group are in many cases suboptimal. But the 
latter group will not follow this mailing list. They are not 
interested in all the details. They live in their room, get a piece of 
paper and translate it. In case something is unclear, they aks. But as 
it is now, it would look something like this:
Translators receive 100+ emails per day and are supposed to filter out 
the one email every 10 days that carries useful information for their 
work. In practice I guess interested Translators (who are not 
interested in every code detail) will unsubscribe after a few days and 
then miss all the fun.

A git-i18n mailing list could coordinate that. It would not be a list 
for l10n teams to do their internal coordination, but for the i18n 
coordinator to notify l10n teams about updated POT files (he might 
even merge PO files) and for l10n teams to ask about strings they are 
unsure about. These questions would then be digested by the i18n 
coordinator and brought to the attention of the developers if needed.

How does that sound?

Regards

PS: I would have even put all the POT/PO stuff in an extra Git 
repository. Working with translation is decoupled from development 
cleanly by the msginit/msgmerge process but well, it might not be woth 
that separation for a single project. :)
