From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Wed, 17 Oct 2007 08:34:12 +0200
Message-ID: <4715ACE4.9080907@viscovery.net>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 08:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii2U6-0007Vo-0x
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 08:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbXJQGeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 02:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbXJQGeP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 02:34:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6106 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbXJQGeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 02:34:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ii2Tg-0001nU-CQ; Wed, 17 Oct 2007 08:34:00 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2C6A9A33B; Wed, 17 Oct 2007 08:34:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1192586150-13743-2-git-send-email-nico@cam.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61338>

Nicolas Pitre schrieb:
> -		start_progress_delay(&progress, "Checking %u files out...",
> -				     "", total, 50, 2);
> +		start_progress_delay(&progress, "Checking files out",
> +				     total, 50, 2);

While you are here, could you make that "Checking out files", please?

-- Hannes
