From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Tue, 22 Sep 2009 08:08:46 +0200
Message-ID: <4AB869EE.1020200@viscovery.net>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 08:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpyYY-0005Zv-B5
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 08:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbZIVGIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 02:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZIVGIo
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 02:08:44 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19278 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbZIVGIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 02:08:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MpyYQ-0000r3-FG; Tue, 22 Sep 2009 08:08:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 39001A4A1; Tue, 22 Sep 2009 08:08:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128920>

Michael Wookey schrieb:
> MSVC builds define UNICODE which results in the "WIDE" variation of
> Win32 API's being used.
> 
> Explicitly use the ANSI variation of the API's for compatibility with
> msysgit.
> 
> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>

Marius,

I would like to understand why you did not have this issue.

The patch itself looks fine.

-- Hannes
