X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 14:17:10 +0200
Message-ID: <200610261417.10842.jnareb@gmail.com>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <ehpu4t$ch2$1@sea.gmane.org> <20061026120824.GO20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 12:17:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M438nGIIpiC10ei4K2aB4HHunCE0pxrgJPLyyVMP3ugB4P1+qSOa+DQL1MwDHzov+z7KLisdFDHQ2rkTnoH+WXJ0BvXLzB2p8wQ00ASUbNS610TfxV2+Bn4kDz5zO5tAYgLAWShxTX5xICAAZEHD9nj85ADkcKTEo0cD1Axeubk=
User-Agent: KMail/1.9.3
In-Reply-To: <20061026120824.GO20017@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30201>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd4A1-0003qw-IR for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423352AbWJZMQe convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 08:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423354AbWJZMQe
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:16:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12631 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423352AbWJZMQd
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:16:33 -0400
Received: by ug-out-1314.google.com with SMTP id 32so344266ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 05:16:32 -0700 (PDT)
Received: by 10.66.220.17 with SMTP id s17mr2685714ugg; Thu, 26 Oct 2006
 05:16:32 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id q1sm3710207uge.2006.10.26.05.16.31; Thu, 26 Oct
 2006 05:16:32 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Dnia czwartek 26. pa=BCdziernika 2006 14:08, Petr Baudis napisa=B3:
> Dear diary, on Thu, Oct 26, 2006 at 11:12:36AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> This unfortunately means that I cannot test gitweb based on 'master'
>> branch using _released_ git core, git version 1.4.3.3, as it doesn't=
 have
>> git-for-each-ref nor git-show-ref.
>>=20
>> BTW. do people often use latest gitweb with older git binaries? Shou=
ld
>> we try to wait for core feature to mature to released version before=
 using
>> it in gitweb? Or perhaps we should add some kind of version checking=
, and
>> provide workrounds, e.g. using $ENV{GIT_DIR} if git core doesn't sup=
port
>> --git-dir option, pathlimit filtering using git-rev-list piped to=20
>> git-diff-tree --stdin in git_history if there is no --full-history
>> option, show always HEAD activity if there is no git-for-each-ref
>> etc.; well the latest we can do without checking for git core versio=
n, just
>>=20
>>         if -x qx($GIT --exec-path)/git-for-each-ref
>=20
> I can't imagine a situation where you would _want_ to use latest gitw=
eb
> but refuse to use older git binaries - can you explain why do you wan=
t
> to do that?

Theoretically? I could have Perl installed, have installed tools Git
requires to use but not have installed tools Git require to compile.
Hence forced to use pre-compiled binaries.
=20
But that is not my situation.

> If you don't want to install the latest master systemwide, that's
> reasonable, but you can just keep the latest master for the gitweb
> script and/or your personal use.

Well, I'd use compiled 'master' version of git for gitweb, then...
--=20
Jakub Narebski
