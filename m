From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Mon, 05 May 2008 17:12:20 +0200
Message-ID: <481F23D4.2090909@viscovery.net>
References: <20080416062925.8028e952@zebulon.innova-card.com>	 <20080416063739.4B72647879@blf.utvinternet.co.uk>	 <20080505042546.GA7164@shion.is.fushizen.net>	 <200805051608.55200.brian.foster@innova-card.com> <a537dd660805050744h7602e553u21c70168a621fe76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bryan Donlan <bdonlan@fushizen.net>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon May 05 17:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt2NP-0005EE-DT
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 17:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853AbYEEPMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbYEEPMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 11:12:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6620 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbYEEPMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 11:12:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jt2MW-00024b-Ov; Mon, 05 May 2008 17:12:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 76E9F6D9; Mon,  5 May 2008 17:12:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a537dd660805050744h7602e553u21c70168a621fe76@mail.gmail.com>
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81288>

Brian Foster schrieb:
>  What I don't know is the root-cause, that is, WHY
>  this was done.  It wasn't a disc-space issue, and
>  I've no evidence it was a network-bandwidth issue,
>  but there is some anecdotal evidence it was some
>  sort of a CPU-cycles issue, albeit just what the
>  performance hit was is unknown.

How about this theory:

What happens if you fire up gitk as simple as

   $ gitk

in the history if no grafts are present? Some months ago this took ages to
complete, and even today you get a *huge* list of commits in a *short*
window; hence, the scrollbar thumb is tiny, and if you succeed to get hold
of it without a magnifying glass, it scrolls way more than a page of
commits if you move it by only one pixel.

No wonder that $user wants to have a shorter history. So $user, being
smart, truncates the history at a suitable point with a graft.

-- Hannes
