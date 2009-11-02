From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unhappy git in a jailshell?
Date: Mon, 02 Nov 2009 14:51:14 +0100
Message-ID: <4AEEE3D2.9040905@drmicha.warpmail.net>
References: <130714cd0911020416r6a686026q697d843f47b68692@mail.gmail.com> <20091102124746.GA27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex MDC <alex.mdc@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 14:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4xJh-0000mw-Dn
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 14:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZKBNvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 08:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbZKBNvR
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 08:51:17 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59402 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483AbZKBNvR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 08:51:17 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 70595BAB5E;
	Mon,  2 Nov 2009 08:51:20 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 02 Nov 2009 08:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LeKSxKRIeyzCVmkL+575K/aVzvo=; b=C3dxf/pgXu83/4xPI3lhv+3fNzl7k9AYVtdc2hGZ6p25s2VCfeEFFuWoejuXxYx63p6eStf5mmXS+ZbU1q+gSQ4fQMB/kOxhjszGHX0IAcpZtfYiZJlWqL76UEaGV9UT9ezOsOkAgh2/VGQ6Zp4JQ8qXG1Ga5iQswjzBskfcGg4=
X-Sasl-enc: bbVBGkSiHCBr0xRzVCmqIY0GTK17Iq2HmibVEPBGxHyj 1257169880
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD24A1BCC7;
	Mon,  2 Nov 2009 08:51:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091102 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <20091102124746.GA27126@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131908>

Dmitry Potapov venit, vidit, dixit 02.11.2009 13:47:
> On Mon, Nov 02, 2009 at 11:16:43PM +1100, Alex MDC wrote:
>> Hello,
>>
>> I'm trying to use git on a linux server, but unfortunately I've only
>> been granted jailshelled access. Most of git works, but some commands
>> just fail to run, e.g.
>> git repack
>> git rebase
>> git index-pack
> 
> Most Git commands are builtin, so they are executed by git.exe directly,
> but some commands are implemented as separate binaries or shell files.
> These commands require `git --exec-path` in PATH to run. Normally, git
> adds `git --exec-path` in its environment before running them.
> 
> Apparently, jailshelled access prevents that somehow. So, I suggest you
> contact your system administrator and tell him that you need to be able
> to run files from `git --exec-path` to being able to use git, as git
> needs them internally for normal work.
> 

Can you (Alex) find out whether you are allowed to run those binaries
from that path directly? In that case we could rethink our strategy and
adjust for the case where we can't set the environment.

Michael
