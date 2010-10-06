From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Error on git clone
Date: Wed, 06 Oct 2010 08:35:51 +0200
Message-ID: <4CAC18C7.8020302@viscovery.net>
References: <193301.7835.qm@web114608.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 08:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Nbc-0001sy-Si
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 08:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127Ab0JFGfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 02:35:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35639 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab0JFGfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 02:35:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P3NbU-0007bl-9D; Wed, 06 Oct 2010 08:35:52 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 087491660F;
	Wed,  6 Oct 2010 08:35:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <193301.7835.qm@web114608.mail.gq1.yahoo.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158269>

Am 10/6/2010 6:20, schrieb Hocapito Cheteamo:
> Hi,
> 
> I'm a newbie on using git. I installed Git 1.7.0.2 on my PC laptop running 
> Windows XP Prof. SP 2.  When I run the command,
>     "git clone git@github.com:......git sss", 
> I got these log messages:

You didn't show the command that you used.

> Initialized empty Git repository in c:/...../.git/
> Enter passphrase for key 'C:\.....\privateKey':
> remote: Counting objects: 478, done.
> remote: Compressing objects: 100% (303/303), done.
> remote: Total 478 (delta 21), reused 436 (delta 3)
> Receiving objects: 100% (478/478), 96.57 MiB | 148 KiB/s, done.
> Resolving deltas: 100% (21/21), done.
> tagging': Invalid argumenttory at 'public/images/tagging
> 
> Does anyone have any clue on what this "Invalid argumenttory" error is all 
> about?  It did not finish unpacking all the files in folder sss.  It aborted 
> after this error.  Thanks so much for the help.

The error is "Invalid argument" and was printed over a line that said
something about a "repository". Can you reproduce the problem?

-- Hannes
