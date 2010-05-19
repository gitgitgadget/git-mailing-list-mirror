From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git 1.7.1 freezing during http transport with sideband
Date: Wed, 19 May 2010 08:05:42 +0200
Message-ID: <4BF37FB6.40808@viscovery.net>
References: <AANLkTilHslSYFhxdyebhbatVmA98ZtoPgFDdqLQhLJNH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pedro Belo <pedrobelo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 08:05:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEcPg-0004fY-CH
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 08:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab0ESGFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 02:05:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28847 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752154Ab0ESGFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 02:05:46 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OEcPX-00074R-Ch; Wed, 19 May 2010 08:05:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1ECF61660F;
	Wed, 19 May 2010 08:05:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTilHslSYFhxdyebhbatVmA98ZtoPgFDdqLQhLJNH@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147319>

Am 5/19/2010 3:37, schrieb Pedro Belo:
> Git 1.7.1 is freezing when I push something via http and the hook has
> some output. From the client side, I see the hook output prefixed with
> "remote: " as expected - and then the process just hangs.
> 
> The interesting part is I could work around it by adding a sleep to the hook.
> 
> Tested on debian 5.0.4 and git 1.7.1. Couldn't reproduce on a mac.

We do have a bug (and a fix for it) that causes a hang that might be
related. If you had said what you did, which hooks you use, and what the
output was, perhaps it would have been possible to help you some more.

-- Hannes
