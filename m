From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: On "git status"
Date: Fri, 24 Apr 2009 13:40:12 +0200
Message-ID: <49F1A51C.40704@drmicha.warpmail.net>
References: <49F1BD85.16747.5FBF6DC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxJn0-0006Ko-8m
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 13:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbZDXLkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 07:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbZDXLkX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 07:40:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46726 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751732AbZDXLkV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 07:40:21 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B7DA631EC48;
	Fri, 24 Apr 2009 07:40:20 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Apr 2009 07:40:20 -0400
X-Sasl-enc: 7T6rt/KaLtRT8o4HQA2362LNe080IuMiPHlNRFIz/nIt 1240573219
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6ABBB38F89;
	Fri, 24 Apr 2009 07:40:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49F1BD85.16747.5FBF6DC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117427>

Ulrich Windl venit, vidit, dixit 24.04.2009 13:24:
> Hi,
> 
> I'm unsure it exists already, but "git status" doesn't display the tracked files. 
> Would it make sense to have those reported with a "git status -v" (for verbose)?
> (You know: I'm thinking about "cvs status"...)

"git status" is basically "git commit --dry-run", which is different
from "cvs/svn/hg status".

"git diff --name-status" gives output similar to those.

"git ls-files" allows to list all tracked files.

Michael
