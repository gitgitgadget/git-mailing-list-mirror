From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Newbie to git
Date: Sun, 27 Dec 2009 23:34:04 +0100
Message-ID: <m27hs8t5b7.fsf@whitebox.home>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
	<3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
	<26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>
	<0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Sun Dec 27 23:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP1gm-0003Yr-W2
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 23:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZL0WeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbZL0WeK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 17:34:10 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56297 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZL0WeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 17:34:10 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4DF2C1C15681;
	Sun, 27 Dec 2009 23:34:08 +0100 (CET)
X-Auth-Info: 5Cp+UJA9SvRb7injFecOJhkuNV3QcH2gHfoma63Cn9c=
Received: from whitebox.home (p508B7169.dip.t-dialin.net [80.139.113.105])
	by mail.mnet-online.de (Postfix) with ESMTP id E7319903BD;
	Sun, 27 Dec 2009 23:34:07 +0100 (CET)
Received: by whitebox.home (Postfix, from userid 501)
	id A39841E53AB; Sun, 27 Dec 2009 23:34:05 +0100 (CET)
X-Yow: Now that we're in LOVE, you can BUY this GOLDFISH for a 48% DISCOUNT.
In-Reply-To: <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222> (mysql jorge's
	message of "Sun, 27 Dec 2009 21:55:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135718>

<mysql.jorge@decimal.pt> writes:

> then i went to /home/apache/gitprojects and runned:
>
> git init

You probably want to create a bare repository in this directory:

$ git init --bare foo.git

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
