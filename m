From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH v3] Enable minimal stat checking
Date: Tue, 22 Jan 2013 21:38:47 +0100 (CET)
Message-ID: <1885874971.118014.1358887127633.JavaMail.root@dewire.com>
References: <7va9s19lrb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 21:39:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txkcg-0004zS-TO
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 21:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab3AVUiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 15:38:50 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:57064 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab3AVUit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 15:38:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 7382A8274C;
	Tue, 22 Jan 2013 21:38:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0-KGhGMoJHW; Tue, 22 Jan 2013 21:38:47 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id AEA3A82736;
	Tue, 22 Jan 2013 21:38:47 +0100 (CET)
In-Reply-To: <7va9s19lrb.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214249>



----- Ursprungligt meddelande -----

> Also, even though we settled on "default/minimal", we may regret in
> the future if old implementations died on an unrecognized value, as
> that will forbid users from using an old Git and a new Git on the
> same repository at the same time, so I'd suggest removing the "if
> not default or minimal, die" and replacing it with "treat unknown
> token as a do-no-harm no-op".

I decided on error after looking at how other configuration errors
are handled, but I can change, though I personally prefer to get
configuration mistakes thrown in my face so I know.

-- robin
