From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: What's cooking in git.git (Nov 2011, #02; Sun, 6)
Date: Tue, 08 Nov 2011 13:14:36 +0100
Message-ID: <4EB91D2C.6020504@atlas-elektronik.com>
References: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 13:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNkZh-0001W8-3D
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 13:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab1KHMOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 07:14:40 -0500
Received: from mail96.atlas.de ([194.156.172.86]:16975 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab1KHMOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 07:14:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id A669510074;
	Tue,  8 Nov 2011 13:14:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id IgDkxnIi0L6k; Tue,  8 Nov 2011 13:14:37 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue,  8 Nov 2011 13:14:36 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id CE46E2716A;
	Tue,  8 Nov 2011 13:14:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185084>

Am 06.11.2011 21:17, schrieb Junio C Hamano:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.
> 
> [...]
> 
> With all the topics and integration branches but not todo, html or man:
> 
>         https://github.com/gitster/git
> 
> I will stop pushing the generated documentation branches to the above
> repositories, as they are not sources. 

This breaks the 'quick-install-{doc,html,man}' make targets, btw.
 
> These branches are pushed to their own separate repositories instead:
> 
>         git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
>         git://repo.or.cz/git-{htmldocs,manpages}.git/
>         https://code.google.com/p/git-{htmldocs,manpages}.git/
>         https://github.com/gitster/git-{htmldocs,manpages}.git/

I had to create remotes for those repositories (named htmldocs and manpages) 
and put this into config.mak to make it work again:

  HTML_REF=htmldocs/master
  DOC_REF=manpages/master

Just FYI...

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Brain: The apparatus with which we think that we think.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
