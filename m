From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Q. about usage of notes
Date: Tue, 31 Aug 2010 12:15:59 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C7CD65F.10509@atlas-elektronik.com>
References: <4C7CB8AF.5080008@atlas-elektronik.com> <201008311107.32278.johan@herland.net> <4C7CD5B8.20602@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 12:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqNt1-0003du-OS
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 12:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab0HaKQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 06:16:10 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:43404 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345Ab0HaKQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 06:16:09 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 43377138A0
	for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:16:08 +0200 (CEST)
X-AuditID: 0ac86512-000004c0000005d0-93-4c7cd6671602
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 31 Aug 2010 12:16:07 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id B29422717A;
	Tue, 31 Aug 2010 12:16:07 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id A031F2716A;
	Tue, 31 Aug 2010 12:16:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4C7CD5B8.20602@atlas-elektronik.com>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154891>

On 8/31/2010 12:13 PM, Stefan Naewe wrote:
> 
> But if I do:
> 
> $ touch file ; git add file ; git commit -m"add file"
> 
> and then 
> 
> $ for n in 1 2 3; do git rm file; git commit -m"rm file"; done
>  
> I get:
> 
> rm 'file'
> [master 5b24511] rm file
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 file
> fatal: pathspec 'file' did not match any files
> # On branch master
> nothing to commit (working directory clean)
> fatal: pathspec 'file' did not match any files
> # On branch master
> nothing to commit (working directory clean)
> 
> I don't get 4 commits. That's the part I don't understand :-(

Just to be clear:

Of course I do understand why I don't get 4 commits here - I just don't
understand why I get a commit for every 'git notes remove' even if there's
nothing to remove.

Stefan
-- 
----------------------------------------------------------------
/dev/random says: This tagl ineh asto oman yfou rlet terw ords.
