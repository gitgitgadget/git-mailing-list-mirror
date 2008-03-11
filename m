From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 18:17:01 +0100
Message-ID: <47D6BE8D.3070009@viscovery.net>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com> <alpine.LSU.1.00.0803111352200.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:18:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ86h-00044d-2g
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbYCKRRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYCKRRE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:17:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38747 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbYCKRRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:17:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZ85J-0001tO-Ss; Tue, 11 Mar 2008 18:16:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2A0EF6EF; Tue, 11 Mar 2008 18:17:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LSU.1.00.0803111352200.3873@racer.site>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76882>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 11 Mar 2008, Whit Armstrong wrote:
> 
>> tr: Bad string.
> 
> What string?

It's this tr, which is the implementation of ./rot13.sh:

   tr '[a-zA-Z]' '[n-za-mN-ZA-M]'

I can't tell what's wrong with it on Solaris, though.

-- Hannes
