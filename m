From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-cherry.txt: Change symbol marks in graph.
Date: Thu, 02 Dec 2010 12:05:33 +0100
Message-ID: <4CF77D7D.90507@drmicha.warpmail.net>
References: <1291267093-29855-1-git-send-email-jari.aalto@cante.net> <m31v604nc0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 12:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO716-0008Ls-G5
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 12:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab0LBLHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 06:07:53 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43944 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755440Ab0LBLHw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 06:07:52 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BCC6252F;
	Thu,  2 Dec 2010 06:07:51 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 02 Dec 2010 06:07:51 -0500
X-Sasl-enc: VdDX7bZXlyyXAT3CNmrkB2ct3c8PrvDYdtg+wdD7aS5Z 1291288071
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9FFE6406094;
	Thu,  2 Dec 2010 06:07:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <m31v604nc0.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162692>

Jakub Narebski venit, vidit, dixit 02.12.2010 09:00:
> Jari Aalto <jari.aalto@cante.net> writes:
> 
>> From: Jari Aalto <jari.aalto@cante.net>
>>
>> The common commit were marked with a minus sign (-), but that is
>> usually interpreted as something less or substracted. Use natural
>> equal sign (=). Commits that are not in upstream were marked with plus
>> sign (+) but a question mark (?) is visually a litle more striking
>> (erect) in context where all other signs are "flat". It also helps
>> visually impared to see difference between (* ... ?) as opposed to
>> similar signs (* ... +).
> 
> Reading comprehension FAIL.  The graph in question uses '+' and '-' because
> that is what 'git cherry' *output( uses ('+' included, '-' excluded).  They
> are very natural in git-cherry output (diff-like).

Yep, and I so wished that git-cherry had different output that I even
saw a git-cherry patch where there was none...

So, +1 from me if this comes with an actual code patch.

Michael
