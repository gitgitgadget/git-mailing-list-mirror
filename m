From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in
 	the case of conflicts.
Date: Wed, 31 Mar 2010 15:51:10 +0200
Message-ID: <4BB3534E.3080803@viscovery.net>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>	 <4BB2F7A0.6020702@viscovery.net>	 <k2p2cfc40321003310412hf4c6d642n4349af3f644829ff@mail.gmail.com>	 <4BB3346C.7070700@viscovery.net> <t2u2cfc40321003310523u8fda9baeo883d2e0b3c6fa807@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 15:51:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwyKF-0002VI-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 15:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407Ab0CaNvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 09:51:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28790 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933397Ab0CaNvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 09:51:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NwyK6-0004oW-LO; Wed, 31 Mar 2010 15:51:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5FDA01660F;
	Wed, 31 Mar 2010 15:51:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <t2u2cfc40321003310523u8fda9baeo883d2e0b3c6fa807@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143675>

Am 3/31/2010 14:23, schrieb Jon Seymour:
> What about the safe (but complicated) diff -c by default (to prevent
> misinformed Use Remote/Local decisions, by default) and a "Conflicts
> Only" option (disabled by default) that shows the diff --cc output for
> those who know what they are doing?

You would like to have the worst of all three?

1. dangerous menu options
2. incomprehensible diff -c output
3. and a config option on top of it

I think we should have none of them.

Yes, I suggested diff -c, but after seeing how it works (better: not
works), I changed my mind.

What sort of user guidance is it to present alluring menu options "Use
local/remote version", but at the same time a scaring amount of diff -c
output.

-- Hannes
