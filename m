From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Wed, 14 Apr 2010 08:08:19 +0200
Message-ID: <4BC55BD3.3050204@viscovery.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>	 <20100410042609.GA24295@coredump.intra.peff.net>	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>	 <20100411102255.GB20484@coredump.intra.peff.net>	 <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>	 <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>	 <4BC3389C.4090807@viscovery.net>	 <w2t76c5b8581004120828p8e1e5c49m7bcc53c8c3e68d06@mail.gmail.com>	 <4BC3407C.10701@viscovery.net> <p2l76c5b8581004130930rf5558655n4bb1f6d0c659498d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 08:08:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1vm1-0002N3-49
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 08:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab0DNGIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 02:08:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23209 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666Ab0DNGIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 02:08:23 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O1vls-0004OG-Fl; Wed, 14 Apr 2010 08:08:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 201EF1660F;
	Wed, 14 Apr 2010 08:08:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <p2l76c5b8581004130930rf5558655n4bb1f6d0c659498d@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144852>

Am 4/13/2010 18:30, schrieb Eugene Sajine:
> IMHO this "noop" behavior seems to be identical to "git reset --hard
> master" - the result is the same. Frankly, I don't understand what is
> useful in such thing being HIDDEN in "incorrect call" of interactive
> rebase...

This thing is useful when you 'git rebase -i master topic' and all patches
on topic are already in master.

-- Hannes
