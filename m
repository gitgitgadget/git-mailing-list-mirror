From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Move git-stash from one machine (or working copy) to another
Date: Sun, 23 Jan 2011 11:08:13 +0100
Message-ID: <m2y66caq5u.fsf@whitebox.home>
References: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 23 11:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pgwrw-0002Lf-6K
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 11:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab1AWKIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 05:08:18 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:47732 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1AWKIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 05:08:17 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 8FB3A188A18C;
	Sun, 23 Jan 2011 11:08:15 +0100 (CET)
X-Auth-Info: IZIRF0mCZa8oXO8ImFzE2ojdQqF7c07g71dKZK2wCxk=
Received: from linux.local (ppp-88-217-124-32.dynamic.mnet-online.de [88.217.124.32])
	by mail.mnet-online.de (Postfix) with ESMTPA id 82C3B1C00286;
	Sun, 23 Jan 2011 11:08:15 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 5A6591E52EF; Sun, 23 Jan 2011 11:08:13 +0100 (CET)
X-Yow: I call it a "SARDINE ON WHEAT"!
In-Reply-To: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com>
	(Patrick Doyle's message of "Fri, 21 Jan 2011 09:54:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165421>

Patrick Doyle <wpdster@gmail.com> writes:

> It seems to me that if I could git-stash on machine1, take that stash
> with me (somehow) to machine2, and then pop it there, that would be
> easier.

machine1$ git stash

machine2$ git fetch machine1:/repo refs/stash
machine2$ git checkout FETCH_HEAD .

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
