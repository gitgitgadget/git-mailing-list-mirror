X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Author name and e-mail address in .stgitrc
Date: Sat, 11 Nov 2006 23:02:04 +0000
Message-ID: <b0943d9e0611111502q2f68be67l1a2441d84923a732@mail.gmail.com>
References: <20061111113553.GA11224@diana.vm.bytemark.co.uk>
	 <20061111141530.GF11224@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 23:03:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mDed3RCzr0RYro6c0Xok0jf3sn0iYzKIF2fLXDB06vbOgeGmNNMEBAjEOvZNfOXtZMqcfv4YGIwJ/iBC9mncHJS9SY0OM9O3olJTGjJ+L2gy8kDqOfe4/FPnk3wH3Sha3h0n2ff0zEIU/jKv0loNE0MJ1YGXlYOA+btvlet/I0s=
In-Reply-To: <20061111141530.GF11224@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31247>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj1sN-0003YR-Le for gcvg-git@gmane.org; Sun, 12 Nov
 2006 00:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754897AbWKKXCi convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 18:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbWKKXCi
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 18:02:38 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:24477 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1754897AbWKKXCh
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006
 18:02:37 -0500
Received: by py-out-1112.google.com with SMTP id a29so487056pyi for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 15:02:04 -0800 (PST)
Received: by 10.35.59.5 with SMTP id m5mr7038825pyk.1163286124125; Sat, 11
 Nov 2006 15:02:04 -0800 (PST)
Received: by 10.35.109.8 with HTTP; Sat, 11 Nov 2006 15:02:03 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Is there any particular reason to have the author and committer names
> in ~/.stgitrc? Simply taking them from the same place git does would
> probably be a usability enhancement (unless they're specified on the
> command line, of course).

At the time I added these to .stgitrc, the only place git was taking
them from was the environment variables and I wanted to put them in a
single place. I also didn't like the idea of having the committer
e-mail address be some username@local-machine as I don't think the
name of the machine where I create patches is relevant. I also define
the committer/author per repository in the .git/stgitrc file (i.e. I
use @arm.com for Linux patches and @gmail.com for StGIT).

I use StGIT almost exclusively, even in "maintainer" mode and I would
like not to spread the configuration options over many files. It is on
my todo list to use the same configuration file as git (with a [stgit]
section) since it has a format that should be understood by the Python
config module.

--=20
