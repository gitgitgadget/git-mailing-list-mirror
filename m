X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 29 Oct 2006 00:46:23 +0200
Message-ID: <200610290046.23514.jnareb@gmail.com>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <ehvnal$tjg$1@sea.gmane.org> <200610290018.05884.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 28 Oct 2006 22:45:57 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fDwWgyu2ynWAG5wWfE1QUmMZsQGBbTlNVHKtypTBKUyU2CfX5Aqdql3b2VFAEpCTnpW0/yTQ6mzJNO86MsgGRwQYw2GaoFRi+ML6OLumQqhBE3D4qI6ryhoY1RTO7ciARELHfygxYLgmrg94fZ+5eMZDsNWccvycxgJVxDqiGt0=
User-Agent: KMail/1.9.3
In-Reply-To: <200610290018.05884.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30402>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdwvw-0005Iy-Dk for gcvg-git@gmane.org; Sun, 29 Oct
 2006 00:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964897AbWJ1Wpg convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWJ1Wpg
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 18:45:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4270 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932108AbWJ1Wpf
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 18:45:35 -0400
Received: by ug-out-1314.google.com with SMTP id 32so921517ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 15:45:34 -0700 (PDT)
Received: by 10.66.244.11 with SMTP id r11mr1788827ugh; Sat, 28 Oct 2006
 15:45:34 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 32sm1213526ugf.2006.10.28.15.45.33; Sat, 28 Oct
 2006 15:45:33 -0700 (PDT)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Dnia niedziela 29. pa=BCdziernika 2006 00:18, Robin Rosenberg napisa=B3=
:
> l=F6rdag 28 oktober 2006 15:53 skrev Jakub Narebski:
>>
>> But for example git(7) man page lists git commands clearly divided b=
etween
>> low-level commands (plumbing): manipulation commands, interrogation
>> commands, synching commands and high level commands (porcelain): mai=
n
>> commands, ancillary commands. The "git help" and "git --help" shows =
the
>> most commonly used git commands with short description of each comma=
nd
>> ("git help -a" show all commands).
>=20
> I believe people tend to skim through documentation looking for piece=
s of=20
> information rather than read it from start to end. So they find thems=
elves=20
> reading the plumbing documentation first. Simply reordering documenta=
tion to=20
> list the porcelain commands before the plumbing would make the git ma=
n page=20
> less scary to newcomers.

Good idea. Thanks.

Current ordering in git(7) man page is probably the result of bottom-up
git development. First there were plumbing commands (well, first was
repository format AFAICT, but I digress...).

--=20
Jakub Narebski
