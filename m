From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Thu, 05 Nov 2009 08:35:22 +0100
Message-ID: <4AF2803A.6020108@viscovery.net>
References: <4AE74408.7080103@ramsay1.demon.co.uk> <4AEFD9E2.6060004@viscovery.net> <4AF1D3A7.2070407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:35:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5wsV-0000Vj-Dc
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 08:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZKEHfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 02:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbZKEHfV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 02:35:21 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:8053 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753222AbZKEHfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 02:35:20 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5wsN-00012k-52; Thu, 05 Nov 2009 08:35:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EE5414E9; Thu,  5 Nov 2009 08:35:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AF1D3A7.2070407@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132205>

Ramsay Jones schrieb:
> Johannes Sixt wrote:
>> I understand that you run into this error if you define NO_MMAP in your
>> config.mak. I don't know whether we support NO_MMAP as a knob for to tweak
>> the builds on all platforms. If this is the case (Junio?), then your
>> justification must be updated.
> 
> AFAICT, the only build to not support NO_MMAP is MSVC (on cygwin *or* msysGit).
> The solution was obvious and low impact, so why not remove this anomaly?

Sure, why not? But then the justification is different, as I said.

-- Hannes
