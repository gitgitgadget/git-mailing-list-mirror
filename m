From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Documentation: fix description for enabling hooks
Date: Wed, 17 Dec 2008 08:44:40 +0100
Message-ID: <4948ADE8.2050804@viscovery.net>
References: <200812170359.24109.markus.heidelberg@web.de> <20081217041312.GZ5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Markus Heidelberg <markus.heidelberg@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 08:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCr6f-0002Ut-Qz
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 08:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYLQHow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 02:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbYLQHov
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 02:44:51 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19131 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYLQHov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 02:44:51 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LCr5E-0006Lu-Nr; Wed, 17 Dec 2008 08:44:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6773854D; Wed, 17 Dec 2008 08:44:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081217041312.GZ5691@genesis.frugalware.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103311>

Miklos Vajna schrieb:
> On Wed, Dec 17, 2008 at 03:59:23AM +0100, Markus Heidelberg <markus.heidelberg@web.de> wrote:
>> Since f98f8cb (Ship sample hooks with .sample suffix, 2008-06-24) hooks
>> are not enabled by making them executable anymore, but by removing the
>> '.sample' suffix from the filename.
> 
> This is true, but having the executable bit is necessary as well. I
> think it would be better to just append this requirement instead of
> replacing the old one with this.

Markus's proposed new wording is correct because the .sample hooks *are*
already executable.

-- Hannes
