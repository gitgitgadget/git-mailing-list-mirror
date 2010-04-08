From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2010, #03; Wed, 07)
Date: Thu, 08 Apr 2010 08:05:28 +0200
Message-ID: <4BBD7228.8080403@viscovery.net>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzkrz-0000bO-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab0DHGFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:05:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5317 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0DHGFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:05:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nzkrp-00045c-5g; Thu, 08 Apr 2010 08:05:29 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C82BA1660F;
	Thu,  8 Apr 2010 08:05:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144321>

Am 4/8/2010 2:48, schrieb Junio C Hamano:
> * np/malloc-threading (2010-04-07) 2 commits
>  - Make xmalloc and xrealloc thread-safe (addendum)
>  - Make xmalloc and xrealloc thread-safe
> 
> Updated with Freku's "init_recursive_mutex()".  The fix should eventually
> go to 'maint' and 'master'.

The addendum does not compile on Windows. I'm working on a replacement.

BTW, are there Unices that do not have a recursive mutex?

-- Hannes
