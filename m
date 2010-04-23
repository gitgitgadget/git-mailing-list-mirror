From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: multiple .gitignore and friends in same workdir possible?
Date: Fri, 23 Apr 2010 17:51:18 +0200
Message-ID: <4BD1C1F6.9070908@drmicha.warpmail.net>
References: <4526533254752708319@unknownmsgid> <y2kfabb9a1e1004230601zcede9e2ah2db8cb0f082bcbb4@mail.gmail.com> <7537.06050240925$1272033186@news.gmane.org> <4BD1B3AD.50407@drmicha.warpmail.net> <16960.9152632349$1272035032@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Konrad Karl <kk_konrad@gmx.at>
X-From: git-owner@vger.kernel.org Fri Apr 23 17:54:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5LD8-0003AD-RC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773Ab0DWPy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 11:54:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55078 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757622Ab0DWPy2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 11:54:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D16B7EE063;
	Fri, 23 Apr 2010 11:54:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 23 Apr 2010 11:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tzc29b9XsQKmLnI+odKzZUsLa8Q=; b=th8MpibtkG3d0HQi/VyltkQeknsP1CbsnUK17P0lwHaENt5ArnxjZwaJWG6lBq+KHXE4PpqWRcKlFvxd98BEU+5uYoqWbcB8DrWaMy7MxCVWxL0hMR9izN0PT/98Xh6mHF8QKkredMKMgmgMeWYXIivlWolNVv20UR3WAZPUQ5M=
X-Sasl-enc: qr6ocWD7qCc8MSbiyWYHmAEl0sLVrtry97iqSiN7szQn 1272038067
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3340513B31;
	Fri, 23 Apr 2010 11:54:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <16960.9152632349$1272035032@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145625>

Konrad Karl venit, vidit, dixit 23.04.2010 17:03:
> On Fri, Apr 23, 2010 at 04:50:21PM +0200, Michael J Gruber wrote:
>> Konrad Karl venit, vidit, dixit 23.04.2010 16:32:
>>> Hi
>>>
>>> On Fri, Apr 23, 2010 at 03:01:42PM +0200, Sverre Rabbelier wrote:
>>>> Heya,
>>>>
> [ ...... ]
>>> so if there was some way to _not_ consider the standard .gitignore &friends
>>> I would be happy to live with.
>>
>> If you control the creation of the repos, why don't you simply leave the
>> standard .gitignore empty and use the config as suggested by Sverre?
> 
> Because this information does not getting transfered with git clone.
> 
> People have the chance to forget to set this variable after cloning the
> source repo and they will. 

...and the same is true for setting GIT_DIR appropriately for each repo
- people will commit to the wrong repo, which is even worse. That's why
it's a fragile approach to begin with. Is there no chance you could put
those libs in subdirs and use git modules?

Michael
