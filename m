From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 10:25:11 +0200
Message-ID: <49F025E7.7090404@drmicha.warpmail.net>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com> <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 10:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwuGr-0000rZ-Lq
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 10:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZDWIZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 04:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbZDWIZW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 04:25:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37134 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753162AbZDWIZV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 04:25:21 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6693A31F35F;
	Thu, 23 Apr 2009 04:25:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 23 Apr 2009 04:25:19 -0400
X-Sasl-enc: Owenbefo9ZyJRzY4hMvwvsg5RPMMYtPip5/mWBa8fySQ 1240475119
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AA0804DB97;
	Thu, 23 Apr 2009 04:25:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117308>

Alex Riesen venit, vidit, dixit 23.04.2009 09:57:
> 2009/4/23 Caleb Cushing <xenoterracide@gmail.com>:
>> so I do the same merge all the time... sorta, I'm not sure rerere
>> would actually work because the file is different each time... I just
>> have to delete it each time. and I want to automate the process.
>> checkout merge rm commmit, problem is commit brings and editor up, I
>> want to commit with the 'auto inserted merge message' that is
>> generated, without seeing the editor, how do I do this?
> 
> See git commit -C <commit-with-fitting-description>,
> git commit -F <message-file> and git commit -m "message text".

I think he wants the auto generated message which may be different for
each merge. Maybe something like

GIT_EDITOR=/bin/true git commit

will do the trick.

Michael
