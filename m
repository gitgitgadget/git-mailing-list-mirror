From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Checkout first version of each file?
Date: Tue, 08 Nov 2011 19:15:14 +0100
Message-ID: <m239dypjkd.fsf@igel.home>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
	<20111108140243.GA4866@kolya>
	<CABLeVKFkSP=2-kwsN4N+oLrPnijkpvV8Ki=Si4dpYXdzc+8ibQ@mail.gmail.com>
	<20111108150007.GA5261@kolya>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dario Rodriguez <soft.d4rio@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 19:15:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNqCh-00038F-EE
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 19:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab1KHSPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 13:15:19 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:56756 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1KHSPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 13:15:18 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id F20A3188A193;
	Tue,  8 Nov 2011 19:16:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 1197E1C00045;
	Tue,  8 Nov 2011 19:15:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id qqpC-po-Axpj; Tue,  8 Nov 2011 19:15:15 +0100 (CET)
Received: from igel.home (ppp-88-217-115-129.dynamic.mnet-online.de [88.217.115.129])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue,  8 Nov 2011 19:15:15 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9948ACA29C; Tue,  8 Nov 2011 19:15:14 +0100 (CET)
X-Yow: Will the third world war keep ``Bosom Buddies'' off the air?
In-Reply-To: <20111108150007.GA5261@kolya> (Fredrik Gustafsson's message of
	"Tue, 8 Nov 2011 16:00:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185103>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> #!/bin/sh
> git reset --hard HEAD
> for f in `find`
            git ls-files
> do
> 	commit=`git log $f | grep commit | tail -1`
                git rev-list HEAD -- $f | tail -1
> 	git checkout $commit $f
> done

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
