From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: --exec-path not always honored
Date: Tue, 17 Mar 2009 11:34:23 +0100
Message-ID: <49BF7CAF.6060505@viscovery.net>
References: <49BF692B.9020002@viscovery.net> <alpine.DEB.1.00.0903171117480.6393@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWeN-00027y-5S
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbZCQKeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbZCQKea
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:34:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45963 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbZCQKe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:34:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjWcq-0006ua-9T; Tue, 17 Mar 2009 11:34:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CBBAE6C4; Tue, 17 Mar 2009 11:34:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903171117480.6393@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113454>

Johannes Schindelin schrieb:
> On Tue, 17 Mar 2009, Johannes Sixt wrote:
> 
>> I noticed this failure if I run git from the build directory:
>>
>> $ ./git --exec-path=. gc
> 
> I am not sure if "." is what you think it is; I imagine it would be 
> $GIT_DIR by the time the PATH variable is adjusted.

This would be *very* bogus, wouldn't it?

> Could you try again with
> 
> 	$ ./git --exec-path="$(pwd)" gc
> 
> ?

It fails in the same way:

$ ./git --exec-path=$(pwd) gc
usage: git pack-objects blah blah...
error: failed to run repack

-- Hannes
