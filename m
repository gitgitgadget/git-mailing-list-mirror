From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Mon, 25 Apr 2011 10:40:06 +0200
Message-ID: <m2pqoa9121.fsf@linux-m68k.org>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
	<20110421220327.GA3396@elie>
	<BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
	<20110423101500.GB1500@elie>
	<BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
	<20110425075750.GA28172@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEHLA-0008BG-58
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 10:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab1DYIkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 04:40:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43044 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab1DYIkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 04:40:14 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 44299188A17D;
	Mon, 25 Apr 2011 10:40:12 +0200 (CEST)
X-Auth-Info: Lgvy7cDTbZE3yb2MDAA+Qz2nALmIFkWEqWS6GppiHE8=
Received: from linux.local (ppp-88-217-126-29.dynamic.mnet-online.de [88.217.126.29])
	by mail.mnet-online.de (Postfix) with ESMTPA id 419971C0013E;
	Mon, 25 Apr 2011 10:40:12 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 30D761E52B5; Mon, 25 Apr 2011 10:40:11 +0200 (CEST)
X-Yow: Let's go to CHURCH!
In-Reply-To: <20110425075750.GA28172@elie> (Jonathan Nieder's message of "Mon,
	25 Apr 2011 03:00:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172017>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'm not sure what a good meaning for "git merge <repository>" would
> be.

It's equivalent to refs/remotes/<repository>/HEAD if that exists.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
