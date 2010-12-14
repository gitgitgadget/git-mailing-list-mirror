From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Revert-style merge/Working tree-only checkout?
Date: Tue, 14 Dec 2010 20:37:04 +0100
Message-ID: <m2zks89me7.fsf@igel.home>
References: <AANLkTi=ioX25aqXg-yWDA0oXBTATkFe+J25g-dB7-psS@mail.gmail.com>
	<20101214054604.GI3264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yuriy Romanenko <groman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:37:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSagV-0005hW-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260Ab0LNThI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:37:08 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:41444 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533Ab0LNThH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:37:07 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 95F751844266;
	Tue, 14 Dec 2010 20:37:04 +0100 (CET)
Received: from igel.home (ppp-88-217-118-153.dynamic.mnet-online.de [88.217.118.153])
	by mail.mnet-online.de (Postfix) with ESMTP id 90F1E1C0014A;
	Tue, 14 Dec 2010 20:37:04 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 61467CA2A0; Tue, 14 Dec 2010 20:37:04 +0100 (CET)
X-Yow: FROZEN ENTREES may be flung by members of opposing SWANSON SECTS..
In-Reply-To: <20101214054604.GI3264@localhost.localdomain> (Konstantin
	Khomoutov's message of "Tue, 14 Dec 2010 08:46:04 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163682>

Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:

> (2) $ git read-tree --reset master
> (3) $ git checkout-index --all --force

$ git rm -r .
$ git checkout master .

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
