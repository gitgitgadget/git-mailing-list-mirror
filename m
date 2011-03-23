From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: duplicated Working tree
Date: Wed, 23 Mar 2011 14:38:13 +0100
Message-ID: <4D89F7C5.6000900@drmicha.warpmail.net>
References: <002701cbe949$e957f050$bc07d0f0$@go-eknowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Samy Louis <Samy.seif@go-eknowledge.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:41:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2OJu-0003OZ-Fc
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 14:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab1CWNlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 09:41:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52968 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755551Ab1CWNlq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 09:41:46 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4CC64202BE;
	Wed, 23 Mar 2011 09:41:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 09:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=i+RywEVsxK7M8hkR38aQZnS8L8w=; b=IMRdQ8nzYpy8wQ8zzgaiEIaAAxFtZ5Z2w/X0jB3ZfAuxTQTGKXJfx9Ha9rT0JgKhy3HZbSdQvTGFys6EiW1WysLVUwyk+2QCvghmjhPRWL7vsJV2kZq9bI/n0klsJvkueVzun6ODdlhCn3Vja8bDbPiuJsLVDXuoTBurZNRSDjs=
X-Sasl-enc: CRabLjhfCb7ZE/Imz8PoBa9p7vXG/7nqvo7Ft9oGewLw 1300887706
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 818FE408F28;
	Wed, 23 Mar 2011 09:41:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <002701cbe949$e957f050$bc07d0f0$@go-eknowledge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169830>

Samy Louis venit, vidit, dixit 23.03.2011 12:03:
> 
> Hi,
> 
> I have a strange problem and need your support if possible.
> 
> When I clone a  remote GIT repository (LAN)  to  local machine,  I get two
> working  folder one at the GIT local folder (normal) and the other in
>  original path of where the remote repository had been created before it was
> cloned  to remote network.
> 
> How can I overcome this issue to only have one local working folder.
> 
> 
> Step to  reproduce it:
> 
> 1- Create a local GIT repo.  (D:\repositoies\projectname)
> 2- Clone the GIT repo. to network path ( \\server\GIT\ projectname) use a
> bare flag.
> 3- Clone the remote repo ( \\server\GIT\ projectname) to other machine in
> path (C:\GIT\projectname) and create working tree
> 4- We will fine two working tree one at C:\GIT\projectname and the other at
> D:\repositoies\projectname.
> 
> Thanks in advance .

Didn't you create a working tree at D:\repositoies\projectname in step 1
already?

Michael
