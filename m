From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: statistics
Date: Fri, 25 Jul 2008 13:29:22 +0200
Message-ID: <4889B912.9040006@viscovery.net>
References: <4889B66D.4020306@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Fri Jul 25 13:30:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLVC-0005TY-KM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYGYL3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 07:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYGYL3Z
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:29:25 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48285 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYGYL3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:29:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KMLUA-0005Au-TC; Fri, 25 Jul 2008 13:29:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 820E4AFCC; Fri, 25 Jul 2008 13:29:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4889B66D.4020306@keyaccess.nl>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90034>

Rene Herman schrieb:
> Hi.
> 
> Is there a (non-depressing) way of getting "which files did not change
> since <rev>" out of git?

What is "non-depressing"?

Try this if you are using bash:

  comm -13 <(git diff --name-only your-rev-here) <(git ls-files)

-- Hannes
