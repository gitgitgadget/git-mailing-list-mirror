From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 13:45:55 +0100
Message-ID: <87a9dt981o.fsf@igel.home>
References: <20140214113136.GA17817@raven.inka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Fri Feb 14 13:46:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEI9c-0008M4-70
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 13:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaBNMp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 07:45:59 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:50416 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbaBNMp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 07:45:58 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fQZ843Xbbz4KKF2;
	Fri, 14 Feb 2014 13:45:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fQZ8435N2zbbh4;
	Fri, 14 Feb 2014 13:45:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ln-1E1gZfxWv; Fri, 14 Feb 2014 13:45:55 +0100 (CET)
X-Auth-Info: kOVd4iSOuKYbK00sjK1Z7MLqW/VL62Gtt1vivA5vbOI=
Received: from igel.home (ppp-88-217-32-146.dynamic.mnet-online.de [88.217.32.146])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 14 Feb 2014 13:45:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 1FF042C1485; Fri, 14 Feb 2014 13:45:55 +0100 (CET)
X-Yow: If you STAY in China, I'll give you 4,000 BUSHELS of "ATOMIC MOUSE"
 pencil sharpeners!!
In-Reply-To: <20140214113136.GA17817@raven.inka.de> (Josef Wolf's message of
	"Fri, 14 Feb 2014 12:31:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242099>

Josef Wolf <jw@raven.inka.de> writes:

> Notice the refs/heads _within_ refs/heads!
>
> Now I wonder how I managed to get into this situation and what's the best way
> to recover?

Probably you did something like "git branch refs/heads/master".  You can
remove it again with "git branch -d refs/heads/master".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
