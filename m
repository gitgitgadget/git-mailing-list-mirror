From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 08:26:36 +0200
Message-ID: <48F58D1C.2040208@viscovery.net>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com> <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpzrL-0004Zh-T7
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 08:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYJOG0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 02:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYJOG0k
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 02:26:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19942 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbYJOG0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 02:26:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kpzq9-0005O1-EE; Wed, 15 Oct 2008 08:26:38 +0200
Received: from [127.0.0.1] (unknown [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 395D269F; Wed, 15 Oct 2008 08:26:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98237>

Stefan Karpinski schrieb:
> This led me to wonder if it wouldn't make sense to have this
> conversion ability built into git.

This wouldn't help your case a lot. It is still at the discretion of each
individual repository owner to enable the conversion. (You didn't mean to
make this conversion mandatory, did you?)

BTW, you don't need to change git code to achieve this. It's sufficient to
install a suitable "clean" filter:

echo "*.c filter=c-code" > .git/info/attributes
git config filter.c-code.clean tabs2spaces

where tabs2spaces is your utility that does the conversion.

-- Hannes
