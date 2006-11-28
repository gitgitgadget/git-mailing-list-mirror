X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 08:07:15 -0800
Message-ID: <m2bqmr1rnw.fsf@ziti.fhcrc.org>
References: <loom.20061124T143148-286@post.gmane.org>
	<20061128054448.GA396@soma> <20061128102958.GA5207@soma>
	<20061128105017.GA20366@soma>
	<9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
	<9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 16:08:40 +0000 (UTC)
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=l259PJkGO4LJtVDfeGOtzlX4UgAwhUbA2p8yM91e69q8PIYm6RMpfp7LLxMGDlctSs3dMjyGSp7ZxdOpXr2U95Lxa+ZFqVQ5V5Y51til2QH7DG+s+nXDB6ZRNKk1JA8ZkAhMAoaHPL6T6LTWHtv40XzFNg1BE33b9yYnbkDp64I=
In-Reply-To: <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com> (pazu@pazu.com.br's message of "Tue, 28 Nov 2006 13:32:56 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32542>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp5UI-0001Nk-8y for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935681AbWK1QHK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 11:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758694AbWK1QHK
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:07:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:38073 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758693AbWK1QHG
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 11:07:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1516800uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 08:07:05 -0800 (PST)
Received: by 10.78.172.20 with SMTP id u20mr1101265hue.1164730025134; Tue, 28
 Nov 2006 08:07:05 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id y18sm20172675hua.2006.11.28.08.07.03; Tue, 28 Nov 2006 08:07:04 -0800
 (PST)
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> writes:
> Notice that there's no "CamelEar" directory. For some reason, it
> wasn't fetched in the initial revision. Now, just to make sure this
> isn't svn fault:
>
> mini:~/devel/camel-git pazu$ svn ls -r11143
> https://tech.bga.bunge.com/BungeHomeExt/GLS/trunk/java/bg-cam
> .cvsignore
> BungeIntegrationEar/
> BungeIntegrationService/
> BungeIntegrationServiceClient/
> CamelEar/

Is CamelEar an empty directory (or was it an empty directory in the
first fetch) by any chance?

I think that presently git-svn does not create empty dirs when pulling
from svn.  It would be nice to have such directories created since
some projects will expect the empty dir to be there (no need to track
it in git, IMO).

