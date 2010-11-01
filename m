From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: can't redirect git's progress output (stderr)
Date: Mon, 01 Nov 2010 15:42:10 +0100
Message-ID: <m2r5f5cdh9.fsf@igel.home>
References: <4CCEB53E.9080102@azabani.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: delan@azabani.com
X-From: git-owner@vger.kernel.org Mon Nov 01 15:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCvaW-0002qU-GK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 15:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab0KAOmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 10:42:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54767 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab0KAOmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 10:42:12 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 38E491C159F8;
	Mon,  1 Nov 2010 15:42:10 +0100 (CET)
Received: from igel.home (ppp-93-104-139-13.dynamic.mnet-online.de [93.104.139.13])
	by mail.mnet-online.de (Postfix) with ESMTP id CCEEF1C00096;
	Mon,  1 Nov 2010 15:42:10 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 63BCFCA2A0; Mon,  1 Nov 2010 15:42:10 +0100 (CET)
X-Yow: Are we live or on tape?
In-Reply-To: <4CCEB53E.9080102@azabani.com> (Delan Azabani's message of "Mon,
	01 Nov 2010 20:40:30 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160483>

Delan Azabani <delan@azabani.com> writes:

> TL;DR why can't I pipe git's stderr output?

git-clone(1):

       --progress
           Progress status is reported on the standard error stream by default
           when it is attached to a terminal, unless -q is specified. This
           flag forces progress status even if the standard error stream is
           not directed to a terminal.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
