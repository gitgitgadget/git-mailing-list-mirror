From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Sun, 30 Mar 2008 16:46:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:48:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7Fs-0005pl-6r
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbYC3XrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYC3XrW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:47:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58044 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751941AbYC3XrV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Mar 2008 19:47:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2UNkqYT020641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Mar 2008 16:46:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2UNkpmF013288;
	Sun, 30 Mar 2008 16:46:52 -0700
In-Reply-To: <20080330232612.GA23063@atjola.homenet>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.34 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78529>



On Mon, 31 Mar 2008, Bj?rn Steinbrink wrote:
> 
> The /proc stuff is already deprecated IIRC, the new file to check on
> Linux is /sys/class/power_supply/AC/online.

I would *seriously* suggest making this soem kind of generic callback and 
not Linux-specific. 

How about making it more akin to a pre-auto-gc "hook" - run a script 
instead of hardcoding something like this!

		Linus
