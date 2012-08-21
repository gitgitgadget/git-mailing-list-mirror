From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] fast_export.c: Fix a compiler warning
Date: Tue, 21 Aug 2012 19:58:33 +0100
Message-ID: <5033DA59.7010403@ramsay1.demon.co.uk>
References: <5031063E.3090405@ramsay1.demon.co.uk> <2715225.vOk3BtNY6o@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:07:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3tnK-0002jx-E2
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417Ab2HUTHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 15:07:11 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:46486 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab2HUTHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 15:07:09 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 44C70A640DC;
	Tue, 21 Aug 2012 20:07:08 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id AEC33A640C9;	Tue, 21 Aug 2012 20:07:07 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Tue, 21 Aug 2012 20:07:06 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <2715225.vOk3BtNY6o@flomedio>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203983>

Florian Achleitner wrote:
> On Sunday 19 August 2012 16:29:02 Ramsay Jones wrote:

> Ok, I'll add it to the next version. This warning only occurs when building 
> for 32bit, thus I never saw it. There would be a format flag for printf that 
> sprecifies the platform's size_t integer type: "z". 
> Probalby we should use it instead? I don't know how widely supported it is.

The git codebase is actually moving in the other direction! :-D
I think the last "%z" modifier was removed by commit 28bd70d8 ("unbreak and
eliminate NO_C99_FORMAT", 16-03-2011).

ATB,
Ramsay Jones
