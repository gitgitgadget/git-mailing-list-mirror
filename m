From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 12:44:58 +0200
Message-ID: <4A16822A.2060404@viscovery.net>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>	 <4A1671E5.4030400@op5.se> <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 12:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7SH1-00085w-MK
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 12:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbZEVKpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 06:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZEVKo7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 06:44:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20060 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbZEVKo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 06:44:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M7SFH-0005EU-B2; Fri, 22 May 2009 12:44:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 170486B7; Fri, 22 May 2009 12:44:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119723>

Tim Uckun schrieb:
> I still don't have an answer as to why the renamed test_new directory
> exists master branch and why both the original 'test' directory and
> the renamed 'test_new' directory are missing subdirectories.

Did test_new contain ignored files? In this case, when you checkout the
branch that does not have test_new, only the tracked files are removed;
the ignored (i.e untracked) files remain. Therefore, after the checkout
you still have a test_new directory.

-- Hannes
