Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECEA1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfFFOeX (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:34:23 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:49633 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFOeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:34:23 -0400
Date:   Thu, 06 Jun 2019 14:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1559831660;
        bh=+j5FYEdElTkyAxZss3V5u3yRUHW9x9FALP70RC+yxr0=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=BYc10uNqNgYOytefvJ5sQCb6JIWdMyQa5RCRCafmHyjQNy6ts2YO2kujsoBAA9xV5
         5Krqy8PCviTiAU9OXiQc/QpGbJFybD5bmNqYKS+5dhdFzYStpavvKgSK90y3IzqS6v
         zoGTNAj8947fjck6iyu6YMgssCOjKYc0FyB4tLKs=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Andres Llopis <allopis@protonmail.com>
Reply-To: Andres Llopis <allopis@protonmail.com>
Subject: Centos7 compiling git
Message-ID: <_d10F4jbR7a1KdFnFMJF5IkXQ5YxZdCttXeYWn87WkJ3GwHgAgJ4M9KSedHDliZTv9Xt4EDTrWV1YxiHoosF_lqSY_6p8aV563WdG5qMhd4=@protonmail.com>
Feedback-ID: GeNn3rL8p1VBvfym0uDxhlnB_ytZ0aucdEjH9zS9opBcV4ycuLSQLAEAGP5AFQq--dMaf9G0EOXcaqnpwwhlpA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have a problem in my centos 7 machine. I am compiling git 2.18 from sourc=
e. When I use git svn  it works fine with the subversion that comes with th=
e system. However, if I have a different subversion in my path:

PATH=3D/home/tools/sw/subversion/svn-1.8.8/rhel7-x86_64/bin:$PATH
LD_LIBRARY_PATH=3D/home/tools/sw/subversion/svn-1.8.8/rhel7-x86_64/lib:$LD_=
LIBRARY_PATH
then I get the following error:

    Can't load '/usr/lib64/perl5/vendor_perl/auto/SVN/_Core/_Core.so' for m=
odule SVN::_Core: /usr/lib64/perl5/vendor_perl/auto/SVN/_Core/_Core.so: und=
efined symbol: svn_uri__is_child at /usr/lib64/perl5/DynaLoader.pm line 190=
.
     at /usr/lib64/perl5/vendor_perl/SVN/Base.pm line 59.
    BEGIN failed--compilation aborted at /usr/lib64/perl5/vendor_perl/SVN/C=
ore.pm line 5.
    Compilation failed in require at /home/machine/.local/share/perl5/Git/S=
VN/Utils.pm line 6.
    BEGIN failed--compilation aborted at /home/machine/.local/share/perl5/G=
it/SVN/Utils.pm line 6.
    Compilation failed in require at /home/machine/.local/share/perl5/Git/S=
VN.pm line 32.
    BEGIN failed--compilation aborted at /home/machine/.local/share/perl5/G=
it/SVN.pm line 32.
    Compilation failed in require at /home/machine/.local/libexec/git-core/=
git-svn line 22.
    BEGIN failed--compilation aborted at /home/machine/.local/libexec/git-c=
ore/git-svn line 22.

Please help, thanks a lot!






