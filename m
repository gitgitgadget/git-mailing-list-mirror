From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 03/12] git p4: gracefully fail if some commits could not
 be applied
Date: Fri, 17 Aug 2012 08:53:35 +0200
Message-ID: <502DEA6F.5080406@viscovery.net>
References: <1345160114-27654-1-git-send-email-pw@padd.com> <1345160114-27654-4-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 08:53:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2GRO-0003Yx-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 08:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694Ab2HQGxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 02:53:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21147 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932639Ab2HQGxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 02:53:40 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1T2GTC-0003Pw-Bq; Fri, 17 Aug 2012 08:55:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9C8551660F;
	Fri, 17 Aug 2012 08:53:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <1345160114-27654-4-git-send-email-pw@padd.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 8/17/2012 1:35, schrieb Pete Wyckoff:
> +++ b/t/t9815-git-p4-submit-fail.sh
> @@ -0,0 +1,93 @@
> +
> +#!/bin/sh

This initial blank line is an accident, right? ;-)

-- Hannes
