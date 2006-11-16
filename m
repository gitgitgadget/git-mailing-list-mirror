X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Thu, 16 Nov 2006 17:24:01 +0000
Message-ID: <b0943d9e0611160924s55383480x68832ef0a6183780@mail.gmail.com>
References: <eile19$p7r$1@sea.gmane.org>
	 <20061106074532.10376.60478.stgit@localhost>
	 <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com>
	 <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com>
	 <20061111122403.GC11224@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 17:24:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fVXEThZjb8hR1Q/CQRCiyLigtqfdRQX3EzL5Z/iYsmt3KJ1I0YASVIEY3ZiE2QIpuAaZXhZ4/QI51LOReS++iQfL4nD8aPfoyLB0Cg1dceb+4fG1gWBx9wp2mgdmLa04pUAau0FIyX9aItk9neka3/XoESvaZBSO2eABrtFaRa8=
In-Reply-To: <20061111122403.GC11224@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31602>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkky7-0000FX-5d for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161334AbWKPRYD convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 12:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWKPRYD
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:24:03 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:49563 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1161334AbWKPRYC
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006
 12:24:02 -0500
Received: by py-out-1112.google.com with SMTP id a29so358692pyi for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 09:24:01 -0800 (PST)
Received: by 10.35.77.1 with SMTP id e1mr491168pyl.1163697841710; Thu, 16 Nov
 2006 09:24:01 -0800 (PST)
Received: by 10.35.109.8 with HTTP; Thu, 16 Nov 2006 09:24:01 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> One potentially hazardous thing: you encode the mail before letting
> the user edit it (with the -e and -E switches). This means that the
> user can insert non-ascii characters in the body after you've already
> decided it's safe to use 7bit encoding. It also means that the user
> must be careful to rfc2047-encode any changes to the Subject: and
> From: headers.

I changed this to edit the mail before encoding it. You can no longer
see the full headers (those added by StGIT) but even in a normal
e-mail client you can only see the whole headers after sending it (and
if you receive it back).

--=20
