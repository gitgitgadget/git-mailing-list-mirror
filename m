From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GITK)] gitk: Fix transient windows on Win32 and MacOS.
Date: Wed, 12 Nov 2008 09:28:08 +0100
Message-ID: <491A9398.1060100@viscovery.net>
References: <200811112355.43352.angavrilov@gmail.com>	<491A827C.3010000@viscovery.net> <18714.36964.666759.654975@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0B6M-0001ej-EK
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbYKLI2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYKLI2M
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:28:12 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31410 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYKLI2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:28:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L0B57-0007k5-Gb; Wed, 12 Nov 2008 09:28:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 205B44E4; Wed, 12 Nov 2008 09:28:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <18714.36964.666759.654975@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100727>

Paul Mackerras schrieb:
> Johannes Sixt writes:
>> Alexander Gavrilov schrieb:
>>> Transient windows cause problems on these platforms:
>> ...
>>> diff --git a/gitk b/gitk
>>> index 9b2a6e5..e6aafe8 100755
>> I'd appreciate if you could make it a habit to base your patches on
>> versions of gitk etc. that are available from a public repository
> 
> You mean, like, git://git.kernel.org/pub/scm/gitk/gitk.git, for
> instance? :)  That is the primary repository for gitk and it seems to
> be what Alexander bases his patches on.

Yes, I mean exactly this repository. It doesn't have 9b2a6e5:

$ git fetch gitk
$ git show 9b2a6e5 --
fatal: bad revision '9b2a6e5'

I assume that Alexander has another patch applied in addition to the one
that he submitted, which, therefore, is no longer "based on a publically
available version".

-- Hannes
