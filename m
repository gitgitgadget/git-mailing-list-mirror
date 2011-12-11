From: Gelonida N <gelonida@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 21:27:09 +0100
Message-ID: <4EE5121D.2050002@gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org> <1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 21:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZpzc-0001tq-GG
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 21:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab1LKU1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 15:27:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:46110 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204Ab1LKU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 15:27:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZpzW-0001t3-Jz
	for git@vger.kernel.org; Sun, 11 Dec 2011 21:27:22 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 21:27:22 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 21:27:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186813>

On 12/11/2011 09:14 PM, Stefan Haller wrote:
> Gelonida N <gelonida@gmail.com> wrote:
> 
>> What is the best way to fastforward all fastforwardable tracking
>> branches after a git fetch?
> 
> Here's a script that does this.  It isn't very well tested, I hope I
> didn't miss any edge cases. Use at your own risk.
> 
> (It doesn't fastforward the branch you're on, on the assumtion that if
> you said git fetch instead of git pull, you probably had a reason.)

Agreed. it might be reasonable to ignore the current branch if it wasn't
pulled.


Thanks a lot for the script. I will play with it.

> 
