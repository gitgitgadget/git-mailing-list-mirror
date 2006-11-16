X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: how to authenticate with git-svn on a subversion repository
Date: Thu, 16 Nov 2006 07:27:57 -0800
Message-ID: <m24pszbede.fsf@ziti.local>
References: <4559D37E.1070703@archlinuxfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 15:29:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=V9yWWXgDmytLJcnfBrfcFAw9zk5wk+VDfQgRxEHvn3kMZZID6s05/9C34fxSNnfx5GkQiVLGH1nnRp6jAwKgXzzosWxXXIZugKtcSIfmyX2jUBY9O3xAJ3/8GNKEJ/x35lTiffMswqX3YNzDTEWHwTtfNqrRDr43P+yKPaXbEm8=
In-Reply-To: <4559D37E.1070703@archlinuxfr.org> (=?iso-8859-1?Q?Com=E8te's?=
 message of "Tue, 14 Nov 2006 15:32:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31588>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkjAK-0004KH-9z for gcvg-git@gmane.org; Thu, 16 Nov
 2006 16:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424156AbWKPP2J convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 10:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424165AbWKPP2J
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 10:28:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55156 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1424156AbWKPP2G
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006
 10:28:06 -0500
Received: by ug-out-1314.google.com with SMTP id m3so461937ugc for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 07:28:04 -0800 (PST)
Received: by 10.78.139.1 with SMTP id m1mr671275hud.1163690884322; Thu, 16
 Nov 2006 07:28:04 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 y18sm2030916hua.2006.11.16.07.28.03; Thu, 16 Nov 2006 07:28:04 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Com=E8te <comete@archlinuxfr.org> writes:

> hello !
>
> i would like to use git-svn to commit some modifications to a
> Subversion repository but i don't know where i can enter my username
> and password to commit to the repository ? Is there any special file
> to put them.
> For now i get an error:

There may be a better way, but if you just use the svn command line
client to create a small working copy from the repository, you will
have a place to enter credentials and they will be cached in
~/.subversion and git-svn will find them.

