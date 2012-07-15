From: "Jonas H." <jonas@lophus.org>
Subject: Implementing authenticated Smart HTTP - which URLs to secure
Date: Sun, 15 Jul 2012 15:43:15 +0200
Message-ID: <5002C8F3.6080400@lophus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 15:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqP79-0002NM-27
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 15:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab2GONnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 09:43:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60908 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2GONnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 09:43:17 -0400
Received: from v216570639.yourvserver.net (static.19.17.47.78.clients.your-server.de [78.47.17.19])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lg6qx-1TedLc4C2l-00oyLB; Sun, 15 Jul 2012 15:43:16 +0200
Received: from [192.168.1.2] (nat-wh-euh.rz.uni-karlsruhe.de [141.70.81.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by v216570639.yourvserver.net (Postfix) with ESMTPSA id AADCBDFAA78
	for <git@vger.kernel.org>; Sun, 15 Jul 2012 15:43:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
X-Provags-ID: V02:K0:mJ9vZdYStwhHVOVjszKvHyj3VxZZDHv+n8VptDmp9mj
 tjdFK/wRAgz6PI/DaaPfDF8JqfnL3LZ2QLFu6snRzJhci19BLb
 GOzlGyUXPHnChENCHhIhUjHskQZL+JX1N9lD+SSwQSKwvqfY8a
 JfGjjH13AOEDUYu/VEaT8PR+HK+ZDtmji5x1tf+MbmkGBw/nDK
 AskgFpZZEvQzd1HkXWwbTOHx3WRyGgB9Mjby1OrZ3ZgzXyQF6a
 R/MtSE/xt2hCM6QfMnTvVC6BRA8nHp8M9SDifYZP0JKnA4FVo0
 PW3tYNVfOrUw7AizjapZ4HL14z06jbqXBbKv/s0POYAxJlSVko
 DbtrpFETl5Pcnh5QbwMQQGHU8C5htA41wqaeqY396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201479>

Howdy!

I'd like to implement HTTP authentication for Git Smart HTTP using 
Dulwich (a Python binding):

1) read-only if unauthenticated and write only if authenticated
2) read/write only if authenticated

I couldn't find any documentation on which URLs need be secured and what 
response codes are expected in case the cloner/pusher is unauthenticated.

Is there any documentation on Smart HTTP workflow?  The C sources 
(vanilla Git and libgit2) didn't help me too much since I found it very 
difficult to follow the code-flow... it's probably just abstracted too 
well :-)

Thanks!
Jonas
