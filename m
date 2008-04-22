From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [regression?] "git status -a" reports modified for empty submodule
 directory
Date: Tue, 22 Apr 2008 14:46:34 +0200
Message-ID: <480DDE2A.3050905@viscovery.net>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>	 <480DD6D8.9040900@viscovery.net> <46dff0320804220539y51c02dedoe181a0eed8599902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:47:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoHuF-00088c-8z
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbYDVMqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYDVMqh
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:46:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2564 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbYDVMqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 08:46:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoHtK-0005lx-Nm; Tue, 22 Apr 2008 14:46:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7CFC46C4; Tue, 22 Apr 2008 14:46:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46dff0320804220539y51c02dedoe181a0eed8599902@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80109>

Ping Yin schrieb:
> It seems that in 1.5.4, both 'git status' and 'git status -a' report
> "no changes added to commit". And i think this is the right behaviour.
> Because when a super project is cloned, all submodule directories are
> empty in the beginning. In this case 'git status' and 'git status -a'
> should report " no changes added to commit".

That makes sense.

-- Hannes
