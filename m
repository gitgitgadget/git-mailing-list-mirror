From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Show patch in gitk --first-parent ?
Date: Wed, 30 Oct 2013 18:55:47 +0100
Message-ID: <874n7yiqxo.fsf@igel.home>
References: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZzn-0003YG-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab3J3Rzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:55:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55463 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3J3Rzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:55:50 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3d8y511CbPz4KSCY;
	Wed, 30 Oct 2013 18:55:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3d8y510TG3zbbgC;
	Wed, 30 Oct 2013 18:55:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id NdG4BCF0IXuO; Wed, 30 Oct 2013 18:55:48 +0100 (CET)
X-Auth-Info: lmVVmkiX0qETEhP9c0+bE4M9T1Jl32GXcau1naFY+Q8=
Received: from igel.home (ppp-88-217-106-98.dynamic.mnet-online.de [88.217.106.98])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 30 Oct 2013 18:55:48 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id CFA872C0596; Wed, 30 Oct 2013 18:55:47 +0100 (CET)
X-Yow: I smell like a wet reducing clinic on Columbus Day!
In-Reply-To: <CAFAOj7p49pQo=hXZT3TmMFF+KThKY-PZ2cgsZasH=e8rgjri1A@mail.gmail.com>
	(Karl Wiberg's message of "Wed, 30 Oct 2013 13:39:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237050>

Karl Wiberg <kha@treskal.com> writes:

> With "gitk --first-parent", I get a graph that only follows the first
> parent of every merge---perfect if you always merge topic branches
> into the main branch. However, the diff shown is still the normal
> merge diff, and not the diff between the new tree and the first
> parent's tree---is it possible to make it do that instead?

While not automatic, you can right click on the parent and select
Diff this->selected.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
