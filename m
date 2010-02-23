From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:19:08 +0100
Message-ID: <4B83D5CC.9030206@viscovery.net>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi> <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjufU-0006Zv-FC
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 14:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab0BWNTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 08:19:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16814 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0BWNTK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 08:19:10 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjufM-0008Fh-Py; Tue, 23 Feb 2010 14:19:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 79FCA1660F;
	Tue, 23 Feb 2010 14:19:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140798>

Johannes Schindelin schrieb:
> May I caution against allowing "+" as part of filenames? On Windows, 
> thanks to the DOS garb^Wheritage, "+" is not really allowed...

I don't think that's true (and I also think it never was).

You may be refering to the copy command, where you can say

   copy a.txt+b.txt+c.txt abc.txt

to concatenate the source files. But this does not restrict how you can
name your files. If you have a file a+b.txt and want to use it with copy,
then you must use double-quotes:

   copy "a+b.txt" elsewhere.txt
   copy "a+b.txt"+c.txt abc.txt

-- Hannes
