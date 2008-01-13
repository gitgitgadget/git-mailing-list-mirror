From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v3] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Mon, 14 Jan 2008 01:13:04 +0300
Message-ID: <20080113221304.GS2963@dpotapov.dyndns.org>
References: <1200241847776-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:24:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEBFO-0006xI-VF
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 23:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbYAMWXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbYAMWXc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 17:23:32 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:51453 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882AbYAMWXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 17:23:24 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id AE0FC1870D00;
	Mon, 14 Jan 2008 01:23:22 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id 00AAC1870D4F;
	Mon, 14 Jan 2008 01:23:21 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEB4i-0003dh-FN; Mon, 14 Jan 2008 01:13:04 +0300
Content-Disposition: inline
In-Reply-To: <1200241847776-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70416>

Hi Steffan,

It looks like I was to quick to ack your patch

On Sun, Jan 13, 2008 at 05:30:47PM +0100, Steffen Prohaska wrote:
> 
> I mentioned earlier that crlf_to_git() would be called twice.  Unfortunately,
> I can't reproduce this behaviour and are not even sure if it ever happend.

that happened to me right now. My setting is autocrlf = input.
and file that I am adding has mixing line-ending:
===
foo
bar\r
===

Dmitry
