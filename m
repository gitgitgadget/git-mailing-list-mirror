From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] add throughput to progress display
Date: Tue, 30 Oct 2007 08:07:31 +0100
Message-ID: <4726D833.90800@viscovery.net>
References: <alpine.LFD.0.9999.0710291904190.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 08:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImlCb-0003Ng-Aw
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 08:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbXJ3HHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 03:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbXJ3HHi
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 03:07:38 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11165 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbXJ3HHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 03:07:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ImlBu-0004zh-Ip; Tue, 30 Oct 2007 08:07:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B62D7546; Tue, 30 Oct 2007 08:07:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.0.9999.0710291904190.22100@xanadu.home>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre schrieb:
> diff --git a/progress.h b/progress.h
> index 07b56bd..eba457f 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -1,6 +1,21 @@
>  #ifndef PROGRESS_H
>  #define PROGRESS_H
>  
> +#include <sys/time.h>

System headers should be taken care of by git-compat-util.h. In fact, it 
already pulls in <sys/time.h>, hence, it shouldn't be necessary here.

-- Hannes
