X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Tue, 7 Nov 2006 09:53:31 +0000
Message-ID: <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com>
References: <eile19$p7r$1@sea.gmane.org>
	 <20061106074532.10376.60478.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 7 Nov 2006 09:53:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d2ntC3jjuG5cjDMPY9zCc6LW3pRyG8bLUQ5L62A9tPV226TrH/fOx5ALKbDawhvJ2HYUQq/y2asrEv9qqiKLsbgzw/G8BHFvRx890Xm4UQyHJ0EiGb+wESwP6Rwwg6UTzp3jYzfsgMABLgqsW6B8mR1moSejY7chUBjkBP9bN5A=
In-Reply-To: <20061106074532.10376.60478.stgit@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31059>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhNeG-0002gj-7R for gcvg-git@gmane.org; Tue, 07 Nov
 2006 10:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754152AbWKGJxd convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006 04:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbWKGJxd
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 04:53:33 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:7573 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1754152AbWKGJxd
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 04:53:33 -0500
Received: by nz-out-0102.google.com with SMTP id z3so1077959nzf for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 01:53:32 -0800 (PST)
Received: by 10.35.128.1 with SMTP id f1mr12569784pyn.1162893211666; Tue, 07
 Nov 2006 01:53:31 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Tue, 7 Nov 2006 01:53:31 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl,

On 06/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> This is required by some mail servers that want to change the transfe=
r
> encoding of the mail.

Thanks for digging into this problem and thanks to everyone else
(especially Linus) for the detailed explanations.

I'll include these patches (maybe modified) and I'll try to fix
"import" as well.

--=20
