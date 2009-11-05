From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] win32: Improve the conditional inclusion of WIN32
 API   code
Date: Thu, 05 Nov 2009 08:41:54 +0100
Message-ID: <4AF281C2.5010504@viscovery.net>
References: <4AE746C6.9060409@ramsay1.demon.co.uk> <4AEFDE9D.6060200@viscovery.net> <4AF1D8B9.9040603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5wz3-0002ac-54
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 08:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbZKEHmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 02:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbZKEHmF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 02:42:05 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:24123 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750793AbZKEHmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 02:42:04 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5wyg-0001j2-HM; Thu, 05 Nov 2009 08:42:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4DF514E9; Thu,  5 Nov 2009 08:41:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF1D8B9.9040603@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132206>

Ramsay Jones schrieb:
> Johannes Sixt wrote:
>> It may be that I understand something incorrectly; but then I blame the
>> justification that you gave. In this case, it would be helpful to reword
>> the commit message, and perhaps add some results from your experiments.
>>
> 
> The discussion which lead to this patch, including the experiments, can be
> found in the email thread starting here:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/129403
> 
> (along with some other unrelated stuff; but it's not a long read :)
> 
> In the above thread, Marius suggested API_WIN32, but I switched it around, since
> I thought it sounded better! I also thought about GIT_WIN32. Suggestions?

I suggested to treat WIN32 and _WIN32 as synonyms. The commit message
should summarize what you observed in your experiments.

But you can also tell me now why this is not possible. (I recall that your
report about the experiments was rather long; I don't have the time to
read and understand it again and to draw the correct conclusions.)

-- Hannes
