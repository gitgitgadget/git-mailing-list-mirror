From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] fast-import: do not write bad delta for replaced subtrees
Date: Sat, 20 Aug 2011 11:08:30 +0200
Message-ID: <m262lspi0h.fsf@linux-m68k.org>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
	<1313346744-30340-3-git-send-email-divanorama@gmail.com>
	<20110820010901.GA2512@elie.sbx02827.chicail.wayport.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 11:10:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuhZE-0002Rg-8O
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 11:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab1HTJIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 05:08:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58840 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab1HTJIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 05:08:39 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7D9B7188B5AD;
	Sat, 20 Aug 2011 11:08:36 +0200 (CEST)
X-Auth-Info: u0q1Zksh7IORP1oP4kWLnlJP6y/cG81GCzaC0X++mSE=
Received: from linux.local (ppp-88-217-114-218.dynamic.mnet-online.de [88.217.114.218])
	by mail.mnet-online.de (Postfix) with ESMTPA id 81C8A1C00057;
	Sat, 20 Aug 2011 11:08:36 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 330A11E5329; Sat, 20 Aug 2011 11:08:32 +0200 (CEST)
X-Yow: We place two copies of PEOPLE magazine in a DARK, HUMID mobile home.
 45 minutes later CYNDI LAUPER emerges wearing a BIRD CAGE on her head!
In-Reply-To: <20110820010901.GA2512@elie.sbx02827.chicail.wayport.net>
	(Jonathan Nieder's message of "Fri, 19 Aug 2011 20:09:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179756>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks again for this.  Abusing (S_ISDIR | S_ISUID) still leaves a bad
> taste in my mouth, but after your description I'm convinced that
> behavior-wise it's the right thing to do.

$ git grep S_ISUID
compat/mingw.h:#define S_ISUID 0

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
