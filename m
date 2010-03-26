From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Deleting remote branches
Date: Fri, 26 Mar 2010 08:10:09 +0100
Message-ID: <4BAC5DD1.7050500@viscovery.net>
References: <1269582415273-4802262.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 08:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv3gS-0004Dk-FU
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 08:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab0CZHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 03:10:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4559 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0CZHKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 03:10:11 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nv3gI-0001o7-1t; Fri, 26 Mar 2010 08:10:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C703D1660F;
	Fri, 26 Mar 2010 08:10:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1269582415273-4802262.post@n2.nabble.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143216>

Am 3/26/2010 6:46, schrieb jhapk:
> I had a whole bunch of branches in my local and a remote repository. I
> deleted all the redundant branches to be left with only three now.
...
> Does anyone know why am I still getting branhces like origin/test when I do
> $git branch -a

git remote prune origin

-- Hannes
