From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 05 Sep 2013 08:42:22 +0200
Message-ID: <522827CE.5040303@viscovery.net>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, hvoigt@hvoigt.net
To: Joergen Edelbo <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 08:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHTPc-0003qR-K2
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab3IEGvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:51:25 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254]:55299 "EHLO
	theia.linz.viscovery" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757377Ab3IEGvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:51:24 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2013 02:51:24 EDT
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 73A7916613;
	Thu,  5 Sep 2013 08:42:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233936>

Am 9/2/2013 10:54, schrieb Joergen Edelbo:
> Changes done:
> 
> Remove selection of branches to push - push always HEAD.
> This can be justified by the fact that this far the most
> common thing to do.

What are your plans to support a topic-based workflow? "Far the most
common thing to happen" is that someone forgets to push completed topics.
With this change, aren't those people forced to relinguish their current
work because they have to checkout the completed topics to push them?

-- Hannes
