X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: How to prepend data when formatting patches ?
Date: Thu, 30 Nov 2006 17:19:42 +0100
Message-ID: <38b2ab8a0611300819k74da17dcw2e3db376d2cc165b@mail.gmail.com>
References: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com>
	 <tnx1wnk53ht.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 16:20:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZNm87JBvZpqvNOaWCACsHf5Zwb/HFMa8dmQzCsF/RTC7JYLwVLVtBcZBZmDFTgTzX+14xRoRLX3/iQoLcZlNWkLhYqgPq3Md+zzGu62n+c4sav7ye9a+Ei+U/c+pFtvOAKdntN1h7DnH58CjbaAVbZCxAk2WaQhFTUVjg7QoFMw=
In-Reply-To: <tnx1wnk53ht.fsf@arm.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32768>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpodY-0008Eu-5L for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030686AbWK3QTo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWK3QTo
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:19:44 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:24405 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1030686AbWK3QTn
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:19:43 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2709572wxd for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 08:19:42 -0800 (PST)
Received: by 10.90.30.10 with SMTP id d10mr3806113agd.1164903582157; Thu, 30
 Nov 2006 08:19:42 -0800 (PST)
Received: by 10.90.55.9 with HTTP; Thu, 30 Nov 2006 08:19:42 -0800 (PST)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Hi

On 11/30/06, Catalin Marinas <catalin.marinas@arm.com> wrote:
> "Francis Moreau" <francis.moro@gmail.com> wrote:
> > I'd like to add to all patchs created by "git-format-patch" command
> > the following line:
> >
> >         From: xxx.yyy <foo@crazy.com>
>
> In the headers or in the message body?

Johannes adviced me to use:

        [format]
                headers = "Organization: git-foo\n"

configuration. And it works both for mail header and message body.

thanks
-- 
