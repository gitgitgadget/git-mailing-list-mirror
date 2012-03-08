From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 08 Mar 2012 12:20:49 +0100
Message-ID: <4F589611.6060106@viscovery.net>
References: <1331203358-28277-1-git-send-email-domq@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:21:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bP1-0005VL-W6
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab2CHLUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 06:20:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3352 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2CHLUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 06:20:54 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5bOs-0001tq-FW; Thu, 08 Mar 2012 12:20:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 354F91660F;
	Thu,  8 Mar 2012 12:20:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1331203358-28277-1-git-send-email-domq@google.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192561>

Am 3/8/2012 11:42, schrieb Dominique Quatravaux:
> +	shortsha1=$(echo $sha1 | cut -c1-7)

> -		sha1=$(git rev-parse $shortsha1)

Why do you call it "optimization" when you spend two or three subprocesses
instead of one?

-- Hannes
