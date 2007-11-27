From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 12:35:33 +0100
Message-ID: <474C0105.3010908@viscovery.net>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Kristi?= =?ISO-8859-15?Q?an_H=F8gsberg?= 
	<krh@redhat.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:36:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyjN-0001dY-FA
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbXK0Lfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbXK0Lfh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:35:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16952 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbXK0Lfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:35:37 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IwyiJ-0000pF-LO; Tue, 27 Nov 2007 12:34:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2A0EA6EF; Tue, 27 Nov 2007 12:35:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66193>

Alex Riesen schrieb:
> The option is to enable operation exclusively on the index, without touching
> working tree. Besides speeding up commit process on performance-challenged
> platforms it also has to ensure that the index is commited exactly how
> user sees it.

Huh?

Doesn't git-commit operate only on the index, unless you pass it extra 
arguments?

What am I missing?

-- Hannes
