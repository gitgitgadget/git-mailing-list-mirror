From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] error out if path is invalid
Date: Mon, 06 Oct 2008 09:02:22 +0200
Message-ID: <48E9B7FE.2000503@viscovery.net>
References: <20081005004036.GO21650@dpotapov.dyndns.org> <1223172881-4948-1-git-send-email-dpotapov@gmail.com> <1223172881-4948-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 09:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmk82-0006X1-Tf
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 09:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbYJFHC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 03:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYJFHC2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 03:02:28 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8341 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYJFHC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 03:02:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kmk6s-0007tl-78; Mon, 06 Oct 2008 09:02:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 863FA4FB; Mon,  6 Oct 2008 09:02:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1223172881-4948-2-git-send-email-dpotapov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97567>

Dmitry Potapov schrieb:
>  	if (!verify_path(path))
> -		return -1;
> +		return error("Invalid path '%s'", path);

Look at this change. Didn't the code error out before, too? Same in the
other cases. Hence, your patch subject does not describe the patch. And
I'd appreciate if you could at least show an example in the description
what the patch fixes.

-- Hannes
