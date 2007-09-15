From: "Brian Scott Dobrovodsky" <brian@pontech.com>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 00:14:26 -0700
Message-ID: <2a8a071a0709150014g3edd08edgb4b63d6130f9db97@mail.gmail.com>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	 <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	 <7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	 <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	 <20070915025129.GY3099@spearce.org>
	 <2a8a071a0709142324i29a863b7x8c164a589c1f1f9a@mail.gmail.com>
	 <7vk5qs8me5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWRrM-0001rI-QH
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbXIOHO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbXIOHO3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:14:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:8152 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbXIOHO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:14:28 -0400
Received: by fk-out-0910.google.com with SMTP id z23so953776fkz
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Vr/gwG9NJHVIbxB+sSkVrwItY4e/FJdSBHEiYT7nEZY=;
        b=Wj2rgGBFzYc1suoRau9MyE3Ia5Kh4GsQMstMfOoUDrJOjA5lB6FBPTa6RCynkwrDFOM6hmYam1KnAxqyEbimlJ5xnRp7f57sAxWMjU8eW1SdqES785Ovp3lUbU5ldBwMPSFWxHSbGBacKVz6f3GtjgIivdI1LGRhafusmg0sTKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oMsRoeQ79Bct9scoL4bsc4yXKG0lDS/XvCxYbACtltbOFX46tpml5MLAlLimdte6MFP0YvvEgQfsQCuMiHiJ02ICwGDxHZwg9SQmHdIwPP2amYwyxgYrAhP0xuFGYQDQCOcw9GEwUG0zdkGvXBKABLijotQkJseAA2GAYeRpgHk=
Received: by 10.82.160.19 with SMTP id i19mr3214601bue.1189840466761;
        Sat, 15 Sep 2007 00:14:26 -0700 (PDT)
Received: by 10.82.161.6 with HTTP; Sat, 15 Sep 2007 00:14:26 -0700 (PDT)
In-Reply-To: <7vk5qs8me5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: f7d208b1d1216480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58222>

> I would not bet you will stay feeling that way as you gain
> experience.  With "git stash create" (will be in 'next' this
> weekend), we could start using stashes more transparently from
> other commands, but I do not think this will ever become the
> default for branch switching, while I do not oppose to have such
> an option.

Stashing as the core default may have been over zealous..

Cheers,
-- 
Brian Scott Dobrovodsky
