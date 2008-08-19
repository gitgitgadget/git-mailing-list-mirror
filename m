From: "Alexander E Genaud" <alex@genaud.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 14:04:42 +0200
Message-ID: <ee521d6f0808190504u12be6195o71eb2f3a38f73a5f@mail.gmail.com>
References: <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
	 <660749.49882.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Peter_Valdemar_M=C3=B8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Mark Struberg" <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Tue Aug 19 14:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVPyB-0003iq-BL
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 14:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbYHSMEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 08:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbYHSMEq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 08:04:46 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:10628 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYHSMEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 08:04:45 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3964735mue.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=2DJSGJsRp5YxbOUSoMo2k+MB1n7XE8ss2CniiocTxW8=;
        b=gb93TxTlvF7VahmfQgV5n401eij8c8yFqv0JrC+BgwqZ3Sel3SQF5drkHC2hF515mZ
         P6pOjeSSnChTeEMGNynuzZSimAUZA10Eo8JlRMYUm7zTPIjEg108pkDVAlaCk8TLcMTK
         qkbLGZMss+3sf2QUMiJaNXSVEfhwUhZopHIwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=l5XPxRNUT/0TJ0/x9S96gjKOqKXnMOjMN5lpCkbmwoRXQiSkNtgDSq7OrWPUFlqTgO
         hVg576N1cGSF24TNZLGQHWI87faRHQl8H7YSmqydbB32nmT1bCwJHOrL1e29pT3b3svb
         WDu9iSItwHiSD1Shpb6wdfEIdyiX5M03hhdEA=
Received: by 10.102.244.1 with SMTP id r1mr4726422muh.25.1219147482173;
        Tue, 19 Aug 2008 05:04:42 -0700 (PDT)
Received: by 10.103.8.1 with HTTP; Tue, 19 Aug 2008 05:04:42 -0700 (PDT)
In-Reply-To: <660749.49882.qm@web27803.mail.ukl.yahoo.com>
Content-Disposition: inline
X-Google-Sender-Auth: 951d24f1cbab38d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92850>

Hi Mark,

Thanks for pointing me to 'git-rm --cached'.

> The changes are "cached" in the "Index". But I wouldn't name
> the "Index" really a "Cache" because it is a lot more. All
> comments for --cached in the manpages mention the Index
> mechanism. Additionally there is a more detailed introduction
> to the Index in section 7 (Git concepts) of the Git User's
> Manual

Funny the first example shows the contents of the index using a '--stage' flag.

$ git ls-files --stage
...
Note that in older documentation you may see the index called the
"current directory cache" or just the "cache".

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#the-index

To my ear, the term cache is a volatile space used for optimization,
while an index is a pointer or reference within a data structure.
Neither are obvious concerns of an end user and using both terms is
plain confusing. Staging implies something more tangible and useful to
the end user.

Cheers,
Alex

-- 
[ alex@genaud.net ][ http://genaud.net ]
[ B068 ED90 F47B 0965 2953 9FC3 EE9C C4D5 3E51 A207 ]
