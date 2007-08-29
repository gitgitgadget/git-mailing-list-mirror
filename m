From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc7
Date: Wed, 29 Aug 2007 17:08:50 +0200
Message-ID: <46D58C02.2070203@eudaptics.com>
References: <7vbqcqr6cz.fsf@gitster.siamese.dyndns.org> <46D57ECF.2050209@eudaptics.com> <Pine.LNX.4.64.0708291516020.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 17:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQPAu-0003Og-I2
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 17:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbXH2PJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 11:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbXH2PJh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 11:09:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35818 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbXH2PJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 11:09:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IQPAl-0004xD-3C; Wed, 29 Aug 2007 17:09:35 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8207B6B7; Wed, 29 Aug 2007 17:09:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0708291516020.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.384, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56960>

Johannes Schindelin schrieb:
> On Wed, 29 Aug 2007, Johannes Sixt wrote:
> 
>> The MinGW port is now at 1.5.3-rc7, too.
> 
> Should we switch from  4msysgit.git's devel branch to your master branch?

No. There are still too many differences.

But I think it is time to rebase 4msysgit on top of 'devel' - without 
the old devel commits, i.e.

	git rebase --onto mingw/devel 382210f715

There is a lot of stuff in 4msysgit.git that is no longer needed or 
superceded by mingw.git.

Side note: If you can live with a test suite does not complete without 
failures you can rebase on top of master and avoid the devel branch. 
(Think of broken repo when I rebase devel again.)

-- Hannes
