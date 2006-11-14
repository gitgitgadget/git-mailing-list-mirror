X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 18:45:18 +0100
Message-ID: <200611141845.18930.jnareb@gmail.com>
References: <20061114134958.5326.qmail@science.horizon.com> <200611141815.24236.jnareb@gmail.com> <20061114173657.GC5453@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 17:44:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=krBZdGwKBloaAgeTM6ybZZMS9qPG5iIf1ujYhRZhV8HuBd32NZbkJptrJ90GTgTNRTjvqpK8z5oLcHBe3E0LYc1YrZuS7tae6pw82CEWd3kjLxP7DRkkdgrbNb44HgyqVqQDqvAOzRmlQY0c6cJZS51WNCIK6Z0YWdcz/hd58ac=
User-Agent: KMail/1.9.3
In-Reply-To: <20061114173657.GC5453@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31355>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk2Ke-0007JB-Ky for gcvg-git@gmane.org; Tue, 14 Nov
 2006 18:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966195AbWKNRoV convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 12:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966207AbWKNRoV
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 12:44:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:46220 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S966195AbWKNRoV
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 12:44:21 -0500
Received: by wr-out-0506.google.com with SMTP id i22so262683wra for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 09:44:20 -0800 (PST)
Received: by 10.78.25.11 with SMTP id 11mr1197209huy.1163526259568; Tue, 14
 Nov 2006 09:44:19 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 37sm10201680hua.2006.11.14.09.44.19; Tue, 14 Nov
 2006 09:44:19 -0800 (PST)
To: Karl =?iso-8859-2?q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Dnia wtorek 14. listopada 2006 18:36, Karl Hasselstr=F6m napisa=B3:
>
> For example, we could skip the "bisect" branch, since
> you aren't supposed to commit to that anyway.

Well, to have "branch" to which you could not commit, just put ref
outside refs/heads.=20

Another solution would be to be able to put non-head ref in HEAD,
but allow to commit only if the prefix is refs/heads/
--=20
Jakub Narebski
