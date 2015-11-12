From: Gioele Barabucci <gioele@svario.it>
Subject: Request: git stash create --include-untracked
Date: Thu, 12 Nov 2015 11:58:56 +0100
Message-ID: <564470F0.7010105@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 12:06:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwphk-0007WU-HO
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 12:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbbKLLGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 06:06:07 -0500
Received: from camelia.svario.it ([164.138.26.129]:42475 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbbKLLGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 06:06:06 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2015 06:06:06 EST
Received: from [172.29.226.151] (natoutside2.wlan.uni-koeln.de [134.95.7.244])
	by mail.svario.it (Postfix) with ESMTPSA id 69CDD22B89
	for <git@vger.kernel.org>; Thu, 12 Nov 2015 10:58:57 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281217>

Hello,

`git stash create` does not accepts the same options that `git stash 
save` accepts.

It would be handy to have `git stash create` accept 
`-u`/`--include-untracked` and `-a`/`--all`. This would allow a very 
simple "freeze-the-world-I-have-to-leave emergency backup" command such as

     git push -f origin $(git stash create 
-u):refs/heads/emergency/$USER-$(date +%s)

(Derived from <https://lwn.net/Articles/664137/> by user nybble41; 
useful for <http://stackoverflow.com/q/10226586/449288>.)

Regards,

-- 
Gioele Barabucci <gioele@svario.it>
