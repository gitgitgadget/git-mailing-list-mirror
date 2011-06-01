From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to make fetch get everything?
Date: Wed, 01 Jun 2011 08:59:35 +0200
Message-ID: <4DE5E357.1050408@viscovery.net>
References: <1306886776234-6425155.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyc618 <gary.carter@eigen.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:59:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRfP4-0008Cb-IN
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 08:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab1FAG7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 02:59:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15794 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab1FAG7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 02:59:37 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QRfOx-0003Ro-KX; Wed, 01 Jun 2011 08:59:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5A05A1660F;
	Wed,  1 Jun 2011 08:59:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1306886776234-6425155.post@n2.nabble.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174851>

Am 6/1/2011 2:06, schrieb garyc618:
> Hi List,
> 
> In one book it says that "git fetch [remote]" pulls down everything you
> don't currently have in your local repository.  However, when I look at
> FETCH_HEAD it only has the master head.  Other branches don't seem to get
> fetched.
> 
> I tried "git fetch [remote] *:*" but that gave fatal error messages.
> 
> Then I tried "git fetch [remote] "*:foo/*" which worked great - I got every
> single branch.

Assuming you have either cloned from the remote or have set it up using
"git remote add origin /where/the/remote/is", you should have tried

   git fetch origin

which would give you all remote branches in [refs/]remotes/origin/*.

-- Hannes
