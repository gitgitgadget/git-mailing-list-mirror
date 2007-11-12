From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git config error message
Date: Tue, 13 Nov 2007 00:09:26 +0100
Organization: At home
Message-ID: <fhamf4$g7t$1@ger.gmane.org>
References: <9e4733910711120735p653c643eveb44627bf4532b1a@mail.gmail.com> <20071112222317.GF2918@steel.home> <Pine.LNX.4.64.0711122224190.4362@racer.site> <20071112222629.GG2918@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 00:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IriPq-0005ix-AS
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 00:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbXKLXJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 18:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbXKLXJp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 18:09:45 -0500
Received: from main.gmane.org ([80.91.229.2]:57517 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbXKLXJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 18:09:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IriPP-0004Wi-KH
	for git@vger.kernel.org; Mon, 12 Nov 2007 23:09:35 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 23:09:35 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 23:09:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64730>

Alex Riesen wrote:

> Johannes Schindelin, Mon, Nov 12, 2007 23:24:54 +0100:
>> Hi,
>> On Mon, 12 Nov 2007, Alex Riesen wrote:
>>> Jon Smirl, Mon, Nov 12, 2007 16:35:07 +0100:
>>>
>>>> I'm not in a git repo, this error message is misleading.
>>>> 
>>>> jonsmirl@terra:~/foo$ git config remote.origin.url
>>>> http://git.digispeaker.com/projects/digispeaker-kernel.git
>>>> could not lock config file
>>>> 
>>> 
>>> Cygwin or any crashes in this repo lately?
>>> If cygwin, than we probably have a file handle leak in config code.
>> 
>> He said that he's not in a git repo.  Thus, .git/config does not exist, 
>> and is not lockable, since not even .git/ exists.
>> 
> 
> Oh.

And neither does per-user config file (I triet to reproduce this error, and
forgot about ~/.gitconfig file).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
