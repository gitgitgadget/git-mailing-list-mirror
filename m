From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Fri, 26 Sep 2008 11:31:52 +0200
Message-ID: <48DCAC08.9060004@viscovery.net>
References: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se> <48DC815C.6030401@viscovery.net> <48DCA5F3.4090009@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 26 11:33:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj9hL-0008Gw-5E
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 11:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbYIZJb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 05:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbYIZJb7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 05:31:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47879 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbYIZJb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 05:31:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kj9g1-0001IY-JS; Fri, 26 Sep 2008 11:31:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 517D36B7; Fri, 26 Sep 2008 11:31:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48DCA5F3.4090009@isy.liu.se>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96842>

Gustaf Hendeby schrieb:
> On 09/26/2008 08:29 AM, Johannes Sixt wrote:
>> Gustaf Hendeby schrieb:
>>> On windows, git gui fails to correctly extract the aspell version
>>> (experienced with aspell version 0.50.3) due to scilent white space at
>>> the end of the version string.  Trim the obtained version string to
>>> work around this.
>> With this I've partial success here: Aspell 0.50.3 alpha (downloaded from
>> http://aspell.net/win32/) is recognized, but
>>
>> - it only ever checks the first line of the commit message;
> 
> Hmm, strange, I just had it mark my whole first like red, I think it
> took an enter at the end of the line to get everything started though.
> Does it check the rest of the lines for you?  I know spell checking is
> disabled for too early versions of Aspell, due to some change in the
> interface I think.

My situation is this: I fire up git-gui, and because I have some stale
.git/GITGUI_MSG file, the commit message box is not empty. Aspell begins
its work, and git-gui correctly marks spelling mistakes in the first line.
Even if I type new text, delete old text, or change the whole text by
clicking "Amend", no new spelling mistakes are marked for the whole session.

-- Hannes
