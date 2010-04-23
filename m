From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: multiple .gitignore and friends in same workdir possible?
Date: Fri, 23 Apr 2010 16:50:21 +0200
Message-ID: <4BD1B3AD.50407@drmicha.warpmail.net>
References: <4526533254752708319@unknownmsgid> <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com> <7537.06050240925$1272033186@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Konrad Karl <kk_konrad@gmx.at>
X-From: git-owner@vger.kernel.org Fri Apr 23 16:53:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5KG9-0005V3-H0
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 16:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab0DWOxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 10:53:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46298 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755000Ab0DWOxb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 10:53:31 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 74CBCEBB4F;
	Fri, 23 Apr 2010 10:53:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 Apr 2010 10:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=v4ElfgJtVrIyiosp+/lw2CDOvNQ=; b=OZCLLQbLF27zaM9zo0ceNqbYUTTgfZfDU0/+p7gQ6y+PP0xmMngE+kvy5dL7aZtaCmUaYrPK/CJ6iqiAXKcs3uPC/T0ruMOMcJKxgi6RMDRhK0zshqgKXPQMTgAe+W/lflQrGB6CN04TyUG7X3hWy/sWk0/DXOOd9VPDWOlfRJw=
X-Sasl-enc: 9+QZsENPNWQ4GxMfKXk05sePJtrpZQ/JwSgOFiY7tUim 1272034409
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5E1414BB578;
	Fri, 23 Apr 2010 10:53:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <7537.06050240925$1272033186@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145619>

Konrad Karl venit, vidit, dixit 23.04.2010 16:32:
> Hi
> 
> On Fri, Apr 23, 2010 at 03:01:42PM +0200, Sverre Rabbelier wrote:
>> Heya,
>>
>> On Fri, Apr 23, 2010 at 14:46, Konrad Karl <kk_konrad@gmx.at> wrote:
>>> Is this currently possible or am I missing something? It would ease
>>> my task a lot.
>>
>> I assume that each repo has it's own gitdir, in which case it has it's
>> own config file, so you could just use "git config core.excludesfile
>> .gitignore.one"?
> 
> yes I could (i confess I was not aware of this config var) but
> the fine manual says:
> 
>   In _addition_ to .gitignore (per-directory) and .git/info/exclude, 
>   git looks into this file for patterns of files which are not meant to be tracked.
> 
> 
> so if there was some way to _not_ consider the standard .gitignore &friends
> I would be happy to live with.

If you control the creation of the repos, why don't you simply leave the
standard .gitignore empty and use the config as suggested by Sverre?

Michael
