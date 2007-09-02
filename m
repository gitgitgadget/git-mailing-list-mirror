From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sun, 02 Sep 2007 12:18:24 +0200
Message-ID: <20070902101825.1938C576FA@dx.sixt.local>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com> <7vir6us1ia.fsf@gitster.siamese.dyndns.org> <200709020152.30070.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Sep 02 12:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRmXP-00058P-UG
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 12:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbXIBKSa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 06:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbXIBKSa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 06:18:30 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52563 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779AbXIBKS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 06:18:29 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 6782D13A2FE;
	Sun,  2 Sep 2007 12:18:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1938C576FA;
	Sun,  2 Sep 2007 12:18:25 +0200 (CEST)
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57312>

Robin Rosenberg wrote:
> +             if [ -d "$g/../.dotest" ]
> +             then
> +                     ...
> +             else
> +                     if [ -d "$g/.dotest-merge" ]
> +                     then
> +                             ...
> +                     else
> +                             if [ -f "$g/MERGE_HEAD" ]
> +                             then
> +                                     ...
> +                             else
> +                                     ...
> +                             fi
> +                     fi
> +             fi

You can use 'elif' to avoid the increasing indentation.

-- Hannes
