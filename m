From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Bizarre problem cloning repo from Codeplex
Date: Mon, 12 Nov 2012 08:44:15 +0100
Message-ID: <m2d2zj2rlc.fsf@linux-m68k.org>
References: <09766c5a-faa0-48dc-8c0a-6551cf3b5db9@zcs>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <admin@game-point.net>, git <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Mon Nov 12 08:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXoh8-0006V6-7K
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 08:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab2KLHoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 02:44:19 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51809 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab2KLHoS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 02:44:18 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Y0P9r5HFWz3hhXw;
	Mon, 12 Nov 2012 08:44:16 +0100 (CET)
X-Auth-Info: suGJ6uoBlrZb7vjmblDKcQlvzpfU5La09cNdRpI6/es=
Received: from linux.local (ppp-93-104-135-112.dynamic.mnet-online.de [93.104.135.112])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Y0P9r25KfzbbgT;
	Mon, 12 Nov 2012 08:44:16 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id D347914EC0E; Mon, 12 Nov 2012 08:44:16 +0100 (CET)
X-Yow: I'm encased in the lining of a pure pork sausage!!
In-Reply-To: <09766c5a-faa0-48dc-8c0a-6551cf3b5db9@zcs> (Enrico Weigelt's
	message of "Mon, 12 Nov 2012 01:59:27 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209469>

Enrico Weigelt <enrico.weigelt@vnc.biz> writes:

>> > Their webserver seems to be configured quite restrictively
>> > (eg. cannot access files like 'packed-refs').
>> 
>> Probably it just doesn't exist.
>
> Aren' these files requied ?

No.  If you've never run git pack-refs it's never created.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
