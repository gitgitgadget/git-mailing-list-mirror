From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: merge smart enough to adapt to renames?
Date: Thu, 19 Feb 2009 21:17:19 -0500
Message-ID: <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
	 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>
	 <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 03:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaKyY-0008GS-Pv
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 03:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZBTCRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 21:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbZBTCRV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 21:17:21 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:55469 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZBTCRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 21:17:20 -0500
Received: by qyk4 with SMTP id 4so1185992qyk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wS1Djdh7S0io6sN55n1KNGqwN5+Ah9T09hw3PrxiFwA=;
        b=bBr0AhsPbTWSOdb23kr4DSbSqDwdz9S9DVb2WvPI3ygrjPH0hYhtdwCEiaPAQiOlqR
         hdXjwPKmKOqihiGIFPavWdO2qgV5NfXCImolpnhHoDEzSk4QRCPJ5ahlFEk6fayeur32
         v+9+2Nrmq8wiTN3I00X9OvwDXFv8p/4hj2WM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d5jsbfAJPMhzt/jgYZo0VgZxRYwVTx3tARIiKyHaikfpTi9smiGqCxUm+dOaZUTdKs
         coget5TYGSQ1UOlyVa6YSFTe8Ilyh7U4rrfkpftNLbDuLSEC9QYDBIONT9EtdmnW9NjQ
         DBkOJ9jJfG4rO5gt0l8qrnpkxtMeumKEXeCKU=
Received: by 10.229.85.21 with SMTP id m21mr119633qcl.9.1235096239414; Thu, 19 
	Feb 2009 18:17:19 -0800 (PST)
In-Reply-To: <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110780>

> Not sure I understood this completely, but I've found it
> helps to make the rename/move as a separate commit, then
> start changing stuff.  In other words, do too many things in
> the same commit, and you could lose this coolness.

well I the problem is.. in a sense I need to unmerge 2 files that I
once merged... they currently have the same name and are in the same
place, and where I merge them from they'll continue to have that  name
(although they are different files with the same purpose) but I want
them to have different names and spots in my tree/repo.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
