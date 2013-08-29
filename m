From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 09:32:18 -0600
Organization: CAF
Message-ID: <201308290932.18199.mfick@codeaurora.org>
References: <cover.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 17:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4Cw-0002xH-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab3H2PcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:32:22 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:40906 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3H2PcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:32:22 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id C103A13EF03;
	Thu, 29 Aug 2013 15:32:21 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id B4DEF13F01B; Thu, 29 Aug 2013 15:32:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 7359513EF03;
	Thu, 29 Aug 2013 15:32:21 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233277>

On Thursday, August 29, 2013 08:11:48 am Brad King wrote:
> 
>    fatal: Unable to create '....lock': File exists.
>    If no other git process is currently running, this
> probably means a git process crashed in this repository
> earlier. Make sure no other git process is running and
> remove the file manually to continue.

I don't believe git currently tries to do any form of stale 
lock recovery since it is racy and unreliable (both single 
server or on a multi-server shared repo),


-Martin
