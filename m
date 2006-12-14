X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git-fetch fails with error code 128
Date: Thu, 14 Dec 2006 20:25:15 -0300
Message-ID: <200612142325.kBENPF1u001043@laptop13.inf.utfsm.cl>
References: <andyparkins@gmail.com>
NNTP-Posting-Date: Thu, 14 Dec 2006 23:25:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Andy Parkins <andyparkins@gmail.com> 
   of "Thu, 14 Dec 2006 23:08:43 -0000." <200612142308.45376.andyparkins@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 01:12:41 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 14 Dec 2006 20:25:15 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34435>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzxA-000144-S1 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751956AbWLNXZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWLNXZZ
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:25:25 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60172 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751956AbWLNXZZ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:25:25 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kBENPF5Q027844 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 14 Dec 2006 20:25:15 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBENPF1u001043; Thu, 14
 Dec 2006 20:25:15 -0300
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> This is with my big "every linux patch" repository that I talked about in 
> another thread.  To bring you up to speed:

[...]

> This gave me the following output:
> 
> $ git fetch
> remote: Generating pack...
> remote: Done counting 189146 objects.
> remote: Result has 186566 objects.
> remote: Deltifying 186566 objects.
> remote:  100% (186566/186566) done
> Unpacking 186566 objects
> fatal: failed to apply delta
> fatal: unpack-objects died with error code 128
> Fetch failure: /home/andyp/projects/temp/.git

Happened to me yesterday or so pulling the vanilla kernel (big push shortly
before 2.6.20-rc1). Trying again somewhat later went through flawlessly.
Might have been git running out of memory.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
