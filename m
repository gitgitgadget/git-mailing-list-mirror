From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [question] && chaining vs shell loops
Date: Sun, 29 Mar 2015 18:07:39 +0200
Message-ID: <874mp3948k.fsf@igel.home>
References: <20150329154840.GA8771@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 18:07:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcFkb-00089F-R5
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 18:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbC2QHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 12:07:44 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43462 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbC2QHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 12:07:43 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3lFMJX5YDMz3hhgM;
	Sun, 29 Mar 2015 18:07:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3lFMJX0fFNzvh1v;
	Sun, 29 Mar 2015 18:07:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id GXA35boVEDYo; Sun, 29 Mar 2015 18:07:39 +0200 (CEST)
X-Auth-Info: dBDaRMBpDsOMEtTuYpd0ZIDnyzgv3zJtp2LVWYsIihLAy8Ipu8+vuh3tLC7pAJys
Received: from igel.home (host-188-174-198-116.customer.m-online.net [188.174.198.116])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 29 Mar 2015 18:07:39 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3444A2C3D3B; Sun, 29 Mar 2015 18:07:39 +0200 (CEST)
X-Yow: I know th'MAMBO!!  I have a TWO-TONE CHEMISTRY SET!!
In-Reply-To: <20150329154840.GA8771@wheezy.local> (Max Kirillov's message of
	"Sun, 29 Mar 2015 18:48:41 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266440>

Max Kirillov <max@max630.net> writes:

> As far as I can see, loops in shell ignore non-zero exit
> codes of the bodies which are not last. For example, exit
> code of command 'for f in false true; do $f; done' is 0,
> even if there was false.

There is nothing special with loops, that's how the exit code of
compound commands is defined in general: it's the exit code of the last
executed command.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
