From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 15/18] rebase -i: Change function make_squash_message
 into update_squash_message
Date: Thu, 14 Jan 2010 09:20:10 +0100
Message-ID: <4B4ED3BA.5080805@viscovery.net>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <784d63d686a82b93a29531d3079aadbe83258d9f.1263447038.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVKwH-0006PZ-Ps
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab0ANIUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447Ab0ANIUP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:20:15 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15005 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab0ANIUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:20:14 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NVKw7-0003N6-34; Thu, 14 Jan 2010 09:20:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A3A061660F;
	Thu, 14 Jan 2010 09:20:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <784d63d686a82b93a29531d3079aadbe83258d9f.1263447038.git.mhagger@alum.mit.edu>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136963>

Michael Haggerty schrieb:
> Alter the file $SQUASH_MSG in place rather than outputting the new
> message then juggling it around.  Change the function name
> accordingly.

Code churn... Oh...wait... (You get the point ;)

-- Hannes
