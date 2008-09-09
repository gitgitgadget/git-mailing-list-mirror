From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 09 Sep 2008 09:02:44 +0200
Message-ID: <48C61F94.3060400@viscovery.net>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Sep 09 09:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcxGT-0007yT-Qg
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 09:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbYIIHCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 03:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbYIIHCq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 03:02:46 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:34363 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYIIHCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 03:02:46 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KcxFM-0005sU-Pe; Tue, 09 Sep 2008 09:02:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8E05B69F; Tue,  9 Sep 2008 09:02:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95344>

Peter Krefting schrieb:
> Since OpenOffice doucuments are just zipped xml files, I wondered how
> difficult it would be to create some hooks/hack git to track the files
> inside the archives instead?

You could write a "clean" filter that "recompresses" the archive with
level 0 upon git-add.

-- Hannes
