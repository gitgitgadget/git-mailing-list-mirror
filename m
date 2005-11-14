From: Andreas Ericsson <ae@op5.se>
Subject: ./configure script prototype
Date: Mon, 14 Nov 2005 13:18:00 +0100
Message-ID: <43788078.4040403@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 13:19:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbdHn-0006lx-LA
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 13:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVKNMSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 07:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKNMSE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 07:18:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24769 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751104AbVKNMSC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 07:18:02 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 8EC466BCBE
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 13:18:00 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11793>

I've started writing up a configuration script to move some of the logic 
out of the Makefile and make it a bit easier to enable/disable certain 
stuff.

I'm not exactly fluent in what sh flavours accept what syntax and the 
uname -m output is a bit of a mystery for some architectures (PowerPC, 
notably) so the SHA1 method selection stuff might not work.

Thoughts? Comments? Patches?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
