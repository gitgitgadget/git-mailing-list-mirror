From: Peter van der Does <peter@avirtualhome.com>
Subject: git config key bug or by design?
Date: Tue, 27 Nov 2012 22:14:46 -0500
Message-ID: <20121127221446.7f2fbf71@Indy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 04:15:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdY75-0005lg-TB
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab2K1DOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:14:48 -0500
Received: from biast.lunarmania.com ([67.210.100.118]:45566 "EHLO
	biast.lunarmania.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2K1DOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:14:48 -0500
X-Greylist: delayed 1041 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 22:14:48 EST
Received: from c-69-248-87-3.hsd1.nj.comcast.net ([69.248.87.3]:31117 helo=mail.grandprix.int)
	by biast.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <peter@avirtualhome.com>)
	id 1TdY6l-00014p-Ci
	for git@vger.kernel.org; Tue, 27 Nov 2012 19:14:43 -0800
Received: from Indy (indy.grandprix.int [192.168.1.106])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: pdoes)
	by mail.grandprix.int (Postfix) with ESMTPSA id 7024E2E426
	for <git@vger.kernel.org>; Tue, 27 Nov 2012 22:14:46 -0500 (EST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.13; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - biast.lunarmania.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Get-Message-Sender-Via: biast.lunarmania.com: authenticated_id: avirtu2/from_h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210684>

I noticed today I can't create a key starting with a number.

The source code[1] confirms this, but is this a bug or is it by design?


[1]: https://github.com/git/git/blob/master/config.c#L1265

-- 
Peter van der Does

GPG key: CB317D6E

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
