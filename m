X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: how to authenticate with git-svn on a subversion repository
Date: Thu, 16 Nov 2006 12:39:58 +1300
Message-ID: <455BA54E.3060007@vilain.net>
References: <4559D37E.1070703@archlinuxfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 23:40:47 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <4559D37E.1070703@archlinuxfr.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31529>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkUMu-0001Xh-K0 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 00:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162076AbWKOXkJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 18:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162074AbWKOXkJ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 18:40:09 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:31422 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1162077AbWKOXkH (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 18:40:07 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 4ACD11380EF;
 Thu, 16 Nov 2006 12:40:05 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id 05CEB1380E0; Thu, 16
 Nov 2006 12:40:02 +1300 (NZDT)
To: =?ISO-8859-1?Q?Com=E8te?= <comete@archlinuxfr.org>
Sender: git-owner@vger.kernel.org

Com=E8te wrote:
> hello !
>
> i would like to use git-svn to commit some modifications to a Subvers=
ion=20
> repository but i don't know where i can enter my username and passwor=
d=20
> to commit to the repository ? Is there any special file to put them.
> For now i get an error:
>
> # git-svn commit remotes/git-svn
> Autorisation refus=E9e: MKACTIVITY de=20
> '/svn/!svn/act/8115f5df-c0da-4a6d-91ef-135dcb76141c': =C9chec =E0=20
> l'autorisation (http://projet.archlinuxfr.org) at /usr/bin/git-svn li=
ne 553
> 512 at /usr/bin/git-svn line 574
> 	main::commit_lib('f45ba41060287fedfcedfb5fc4c29ecfe30a7466') called =
at=20
> /usr/bin/git-svn line 480
> 	main::commit('remotes/git-svn') called at /usr/bin/git-svn line 172
>  =20

Two questions;

 - have you tried this with Git 1.4.4?  There have been some git-svn up=
dates
 - which version of the SVN Perl bindings are you using?

