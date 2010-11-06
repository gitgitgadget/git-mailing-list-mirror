From: Manuel Strehl <manuel.strehl@physik.uni-regensburg.de>
Subject: Checking out messes up execution bit
Date: Sat, 06 Nov 2010 22:11:20 +0100
Message-ID: <4CD5C478.1010604@physik.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 22:20:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEqBp-0001My-SD
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 22:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab0KFVUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 17:20:40 -0400
Received: from rrzmta5.rz.uni-regensburg.de ([194.94.155.56]:46008 "EHLO
	rrzmta5.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753701Ab0KFVUj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 17:20:39 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Nov 2010 17:20:39 EDT
Received: from rrzmta5.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id F1D192892
	for <git@vger.kernel.org>; Sat,  6 Nov 2010 22:11:21 +0100 (CET)
Received: from [192.168.178.23] (ppp-188-174-19-29.dynamic.mnet-online.de [188.174.19.29])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: stm01875)
	by rrzmta5.rz.uni-regensburg.de (Postfix) with ESMTPSA id 8DF7F2891
	for <git@vger.kernel.org>; Sat,  6 Nov 2010 22:11:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160861>

Hello list,

I asked a question over at superuser.com about git checkouts messing up 
the execution bit of freshly committed files:

http://superuser.com/questions/204757

To put it in a nutshell: I edit and commit a file in branch "master", 
then I check out branch "dev" and the edited file gets the execution bit 
set. This leads to a working copy differing from the content of the 
index. It's especially painful when I try to merge "master" into "dev", 
which fails then. I'm working under ext4 and Samba/CIFS, respectively.

One answerer at superuser thinks that this looks like a bug in git 
itself. Therefore I'd like to check with you, if there is possibly 
another explanation for my observation, before I issue a bug report.

Best,
Manuel
