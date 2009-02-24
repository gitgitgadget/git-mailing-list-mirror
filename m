From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Tue, 24 Feb 2009 09:25:54 -0500
Message-ID: <49A40372.2060600@tedpavlic.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com> <20090223161657.GL22848@spearce.org> <7vab8cpqgl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Marius Storm-Olsen <git@storm-olsen.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 15:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbyG5-0001iS-FI
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 15:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbZBXO0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 09:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756430AbZBXO0J
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 09:26:09 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:32788 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840AbZBXO0I (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 09:26:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 0898F80D8017;
	Tue, 24 Feb 2009 09:19:13 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YzWyfZmRSE2u; Tue, 24 Feb 2009 09:19:12 -0500 (EST)
Received: from TedBook.local (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E45E180D8014;
	Tue, 24 Feb 2009 09:19:12 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7vab8cpqgl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111290>

> Reverting GIT_DIR! ugliness is certainly a possibility.  As long as people
> who chdir into there are the only ones who suffer from the ugliness I do
> not particularly care that much, though ;-)
>
> Will apply anyway.

I only added the "GIT_DIR!" on the advice of Junio, who suggested a 
"danger" flag. I asked for suggestions on replacement text.

Keep in mind that "BARE:master" doesn't make much sense. If you're in a 
git dir, you don't have a working directory. "BARE" alone makes sense. 
Personally, I think it makes more sense to submit a patch that changes 
"GIT_DIR!" to "BARE" in the bare case (and doesn't print any branch).

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
