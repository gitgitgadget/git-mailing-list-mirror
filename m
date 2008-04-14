From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Interaction between clean/smudge and git status
Date: Mon, 14 Apr 2008 08:48:28 +0200
Message-ID: <4802FE3C.4090306@viscovery.net>
References: <loom.20080413T231611-113@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 08:49:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIVA-0004Hz-IK
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbYDNGsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 02:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbYDNGsb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:48:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23822 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbYDNGsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 02:48:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JlIUO-0000TD-Dj; Mon, 14 Apr 2008 08:48:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 34CB2AFCC; Mon, 14 Apr 2008 08:48:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <loom.20080413T231611-113@post.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79467>

Sergio Callegari schrieb:
> I have tried for the first time the .gitattributes filter option, setting a
> clean and a smudge filter for a certain type of files.
> 
> What makes me wonder is that using filters, after a clean checkout git status
> says that everything is changed.
...
> Is this the expected behaviour of the smudge filter?

I've observed this, too, and I don't think it is expected behavior. But it
hasn't annoyed me enough to look at it in depth. Eventually I will, and I
hope to find out what's wrong. ;)

-- Hannes
