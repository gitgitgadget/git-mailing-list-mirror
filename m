From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified
 submodules.
Date: Mon, 12 Nov 2007 11:03:50 +0100
Message-ID: <47382506.1090106@viscovery.net>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com> <7vabpliz13.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrW9K-0005Te-AO
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbXKLKDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755936AbXKLKDy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:03:54 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7403 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742AbXKLKDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:03:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrW8W-0003qu-6q; Mon, 12 Nov 2007 11:03:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CB43A54D; Mon, 12 Nov 2007 11:03:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vabpliz13.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64589>

Junio C Hamano schrieb:
> I also find "<<< lines then >>> other lines" format very hard to
> read.  Maybe formatting it like this would make it a bit more
> readable and more space efficient?
> 
>  	# * sm1 354cd45...3f751e5:
>  	#   - one line message for C
>  	#   - one line message for B
>  	#   + one line message for D
>  	#   + one line message for E
>  	# * sm2 5c8bfb5...ac46d84:
>  	#   - msg

How about the equivalent of

	git log --left-right --pretty=oneline --topo-order 354cd45...3f751e5

which would be

   	# * sm1 354cd45...3f751e5:
   	#   <one line message for C
   	#   <one line message for B
   	#   >one line message for D
   	#   >one line message for E

-- Hannes
