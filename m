From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: Rewrite history then pull repository?
Date: Mon, 13 Jul 2009 11:38:01 +0200
Message-ID: <h3evbh$r8n$1@ger.gmane.org>
References: <h3es3p$ie6$1@ger.gmane.org> <200907131058.15118.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 11:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQI0H-000839-OW
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 11:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbZGMJjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 05:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZGMJjO
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 05:39:14 -0400
Received: from main.gmane.org ([80.91.229.2]:34745 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbZGMJjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 05:39:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MQI05-0002As-CI
	for git@vger.kernel.org; Mon, 13 Jul 2009 09:39:09 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 09:39:09 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 09:39:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <200907131058.15118.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123180>

Thomas Rast wrote:
> 
> See the "Recovering From Upstream Rebase" section in man git-rebase,
> also available online at

Thanks for the link. Luckily I had a clone (backup) of my repository 
before the upstream rebase. So I could play around and see what happens 
to developers downstream. I used the 'gitk --all' to see the history and 
visualize what I had to do. I managed to figure out that 'git rebase 
origin' would solve the problem, and the documentation you mentioned 
confirmed that. :-)

Thanks again for the quick reply.


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
