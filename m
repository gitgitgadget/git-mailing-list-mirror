From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Improve documentation of git-filter-branch rev-list specification.
Date: Wed, 21 Nov 2007 08:49:29 +0100
Message-ID: <4743E309.4090707@viscovery.net>
References: <877ikc3gzc.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IukLI-0002FU-Sj
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035AbXKUHte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbXKUHte
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:49:34 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58568 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbXKUHtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:49:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IukKJ-0003hR-VO; Wed, 21 Nov 2007 08:48:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 24D746EF; Wed, 21 Nov 2007 08:49:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <877ikc3gzc.wl%cworth@cworth.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65618>

Carl Worth schrieb:
> +The filters can modify the tree content stored in each commit,
> +(e.g. removing a file or running a perl rewrite on all files), or the
> +associated information about each commit, (commit message, author,
> +parent, etc.). Any information not affected by a filter (including
> +original commit times or merge information) will be preserved. If you
> +specify no filters, the commits will be recommitted without any
> +changes.

"... will be recommitted without any changes as long as no grafted parents 
are encountered. Any grafted parents will be written into the commits even 
if no filters are specified."

-- Hannes
