X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] StGIT bash completion
Date: Thu, 16 Nov 2006 14:21:27 +0000
Message-ID: <b0943d9e0611160621g60a0cac2r5205e37ed7d9fe9f@mail.gmail.com>
References: <20061112211813.19959.73406.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 14:22:14 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCqGQVoJMafnyC33vFvnt1ngXuQtaH7aPKw7qOpmD8VE60C9XRsL1orGg7HK8yJexppsKLikfi/fngpTou7980cJ2hWhzDafedhNKOyHf+EaR1tcyepVTWkk0jRiz1p8WQeNT2dANvt+OlVYiHCef18iDijH4b3kFdHonipVvpQ=
In-Reply-To: <20061112211813.19959.73406.stgit@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31586>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gki7j-0002fP-ER for gcvg-git@gmane.org; Thu, 16 Nov
 2006 15:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424098AbWKPOVa convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 09:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424079AbWKPOVa
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 09:21:30 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:15228 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1424093AbWKPOV3
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006
 09:21:29 -0500
Received: by nz-out-0102.google.com with SMTP id l1so291784nzf for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 06:21:28 -0800 (PST)
Received: by 10.35.111.14 with SMTP id o14mr862871pym.1163686887649; Thu, 16
 Nov 2006 06:21:27 -0800 (PST)
Received: by 10.35.109.8 with HTTP; Thu, 16 Nov 2006 06:21:27 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 12/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> A minimal bash completion script for StGIT. It completes the
> subcommand names, and options and patch names for some subcommands.

Thanks for the patch. I modified it slightly to automatically generate
the options for other commands as well (by invoking "stg help
<command>" and it doesn't seem to be slow). I'll try to push it
tonight.

Thanks for the other patches as well. I included some but haven't
finished them yet.

--=20
