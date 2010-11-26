From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 04/20] rebase: remove unused rebase state 'prev_head'
Date: Fri, 26 Nov 2010 08:54:19 +0100
Message-ID: <4CEF67AB.6050700@drmicha.warpmail.net>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com> <1290715083-16919-5-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 08:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLtAW-0007vI-A9
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 08:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0KZH41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 02:56:27 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45078 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278Ab0KZH41 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 02:56:27 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A3A0425B;
	Fri, 26 Nov 2010 02:56:26 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 26 Nov 2010 02:56:26 -0500
X-Sasl-enc: LmFUwk6APF1xv/S0zDlYjYSsaXXAJa/wzzu7yeIYDDI7 1290758186
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9477D5E52BD;
	Fri, 26 Nov 2010 02:56:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <1290715083-16919-5-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162208>

Martin von Zweigbergk venit, vidit, dixit 25.11.2010 20:57:
> The rebase state 'prev_head' is not used. Remove it.
> 
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---

The actual value of prev_head was never used. But the check for its
non-nullness made sure that git-rev-parse HEAD^0 succeeded when
$merge_dir was created. Have you made sure that we don't need that check?

Michael
