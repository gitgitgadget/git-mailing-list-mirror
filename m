From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Help using Git(-svn) for specific use case
Date: Mon, 15 Sep 2008 23:15:59 +0200
Message-ID: <48CED08F.5040602@drmicha.warpmail.net>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>	 <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com> <bd6139dc0809151359i357987c5vb2544b1b5c99802f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Pico Geyer <picogeyer@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Sep 15 23:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfLRk-00044W-KE
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 23:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765AbYIOVQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbYIOVQH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 17:16:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59594 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754933AbYIOVQG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 17:16:06 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 206BD1632CC;
	Mon, 15 Sep 2008 17:16:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 15 Sep 2008 17:16:04 -0400
X-Sasl-enc: hdDr/+VvpvJLa21IKrbbVEl3fyLgbb8SnlU/PfdH5iV9 1221513363
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EA7C59C5B;
	Mon, 15 Sep 2008 17:16:02 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <bd6139dc0809151359i357987c5vb2544b1b5c99802f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95945>

Sverre Rabbelier venit, vidit, dixit 15.09.2008 22:59:
> On Mon, Sep 15, 2008 at 21:55, Dmitry Potapov <dpotapov@gmail.com> wrote:
>> [...] Another problem with
>> this approach is that the author is not preserved. In SVN, all commits will
>> look like all changes are done by the person who run "git svn dcommit".
> 
> I thought this was fixed in a more recent version of git-svn? Didn't
> it even work both ways?

Kind of. You can't fake a different author when committing to svn. But
"--add-author-from" makes dcommit embed the author in the svn commit
message (if there's no from nor sob), and "--use-log-author" makes fetch
look for that info and use it.

Michael
