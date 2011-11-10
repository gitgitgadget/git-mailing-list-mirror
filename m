From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: "make quick-install-man" on git.git HEAD has failed for two days
Date: Thu, 10 Nov 2011 17:33:22 +0100
Message-ID: <4EBBFCD2.9060000@atlas-elektronik.com>
References: <861utgymsv.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 17:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROXZ9-0002hV-6N
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 17:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721Ab1KJQdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 11:33:23 -0500
Received: from mail96.atlas.de ([194.156.172.86]:21544 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab1KJQdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 11:33:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id E703710075;
	Thu, 10 Nov 2011 17:33:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id v4wjF3rVxgob; Thu, 10 Nov 2011 17:33:20 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 10 Nov 2011 17:33:20 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 164D427197;
	Thu, 10 Nov 2011 17:33:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <861utgymsv.fsf@red.stonehenge.com>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185238>

Am 10.11.2011 17:17, schrieb Randal L. Schwartz:
> 
> Known issue?  Should I have done something differently?
> 
> "make install quick-install-man" ends with:
> 
>     make[2]: `GIT-VERSION-FILE' is up to date.
>     git-manpages repository must exist at ../../git-manpages
>     make[1]: *** [require-manrepo] Error 1
>     make: *** [quick-install-man] Error 2

This should be fixed with fcbebfd "docs: Update install-doc-quick".
(It's in master)

You need to clone git-manpages.git next to git.git.

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Useless Invention: Fireproof cigarettes.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
