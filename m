From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 4/4] buitin-status: Add tests for submodule summary
Date: Thu, 13 Mar 2008 15:21:41 +0100
Message-ID: <47D93875.1050407@viscovery.net>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com> <1205416085-23431-2-git-send-email-pkufranky@gmail.com> <1205416085-23431-3-git-send-email-pkufranky@gmail.com> <1205416085-23431-4-git-send-email-pkufranky@gmail.com> <1205416085-23431-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZoKA-00081p-Iq
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 15:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbYCMOVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 10:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYCMOVq
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 10:21:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64977 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbYCMOVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 10:21:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZoIi-0005jr-Os; Thu, 13 Mar 2008 15:20:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 55FF86B7; Thu, 13 Mar 2008 15:21:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205416085-23431-5-git-send-email-pkufranky@gmail.com>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77093>

Ping Yin schrieb:
> +cd sm &&
> +head=$(git rev-parse --verify HEAD | cut -c1-7) &&
> +cd ..

I think you can make these three lines into:

test_expect_success 'get short SHA1 of submodule HEAD' '

	head=$(cd sm && git rev-parse --verify HEAD | cut -c1-7)
'

(not tested, though).

> +test_expect_success "status submodule summary (--amend)" '

Thanks for adding this one.

-- Hannes
