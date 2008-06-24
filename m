From: Christian Holtje <docwhat@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 15:16:07 -0400
Message-ID: <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBE0u-0005vv-PZ
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYFXTQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYFXTQR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:16:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:22230 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYFXTQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:16:16 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2273081wri.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=86+qGxgSXFLyDIE2AsFih6Pj6zY8yoURzyH6nhtfbkc=;
        b=nxz1GTKSmT72+q9nMm0KY+T8P+H2Hi2Ze0ydl2Ifis6JYXTu8GU0m5C63vfIrTg6EA
         FxjrWdhqIBdE+ht+EjFz6grjMD0jizIaOS2Uu2e3pTONdNEkcbQHL+QgHp3fMCB2fN/t
         DVV9XOIxgNFnzinBV99Sg/QjgQSnQ0r9k7GxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=iifc1QPu+gFmPCPfxqlb1+zfxN1L/JdcbSqWNjvVwmSv8djGO+WKQCQirENuTld4gK
         V7QcQ3jLAom3eRJB4mrxOHGAZQ98QBIkABzKS24R1YnX/RJpDcHOYYDkdsA2W/Hrby4a
         g8nfMHfCZXirulxUCpabeZ0N2TirOHOjOFqqI=
Received: by 10.90.56.5 with SMTP id e5mr3335208aga.21.1214334975091;
        Tue, 24 Jun 2008 12:16:15 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id f45sm139217pyh.24.2008.06.24.12.16.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 12:16:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86115>

On Jun 24, 2008, at 2:26 PM, Ian Hilt wrote:
> Perhaps you want to use printf "foo\r" instead?  echo "foo\r" does not
> produce a CR on my system.

...

> Wouldn't it be less redundant to do a test for \s\r$ here instead of
> testing for \r$ and then \s\r$?


The code is checking for \r$ and then doing a different space check  
depending on that, not one after another.

Thanks for the feedback. I'll put up v2 in a second.

Ciao!
