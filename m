X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 17:05:35 +0100
Message-ID: <200611271705.36479.jnareb@gmail.com>
References: <200611271516.30425.bruno@clisp.org> <ekesgt$6jq$1@sea.gmane.org> <BAYC1-PASMTP01B6529D1821EEBC0A6E6FAEE60@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 16:04:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rTad+2IoJqHq/SmVvPPUO46a5Egf4KSOtGbc7mmCWtgdywc1GB3JGqclgsznJP7M4VJcs71Uhq5AJmLzqPAp43+WaDkk2LEdOuQsolR/IMY2uHqQirI19IsCps8wpqZuFuybJkBUKSvbCFKKtIwdjhIqO3ADUyigMMMNrvP0UMw=
User-Agent: KMail/1.9.3
In-Reply-To: <BAYC1-PASMTP01B6529D1821EEBC0A6E6FAEE60@CEZ.ICE>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32423>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goixs-0008Df-7E for gcvg-git@gmane.org; Mon, 27 Nov
 2006 17:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758313AbWK0QEL convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006 11:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758342AbWK0QEK
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 11:04:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:59125 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758313AbWK0QEJ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 11:04:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1179357uga for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 08:04:07 -0800 (PST)
Received: by 10.67.19.13 with SMTP id w13mr10076063ugi.1164643447517; Mon, 27
 Nov 2006 08:04:07 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm307288uge.2006.11.27.08.04.06; Mon, 27 Nov
 2006 08:04:07 -0800 (PST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean wrote:
> On Mon, 27 Nov 2006 15:27:20 +0100
> Jakub Narebski <jnareb@gmail.com> wrote:
>=20
>> Bruno Haible wrote:
>>=20
>>> Is this a bug in git-diff? The git-diff-files.html says:
>>>=20
>>> =A0 " When the environment variable GIT_EXTERNAL_DIFF is not set ..=
=2E
>>> =A0 =A0 For example, if you prefer context diff:
>>> =A0 =A0 GIT_DIFF_OPTS=3D-c git-diff-index -p HEAD =A0"
>>>=20
>>> This doesn't work for me with git-1.4.4:
>>=20
>> Yes, the bug in documentation, I think. There is an option '-c' to g=
it-diff,
>> but it means "combined diff" (for merges), not "context diff".
>=20
> Indeed.  That documentation predates built-in diff completely.
>=20
> It appears the only valid options now are "-u XX" and "--unified=3DXX=
".

Which both mean the same.

> These options are never passed to diff, but rather used to control
> the internal diff.  Strangely, it appears that gitk is even passing
> incorrect parameters via GIT_DIFF_OPTS.

Which, in convoluted way is said in documentation (the fact that
GIT_DIFF_OPTS affect internal diff).
=20
> Unless i've really missed something, the above documentation should b=
e
> reworked to remove mention of running diff altogether, and should men=
tion
> that the GIT_DIFF_OPTS only has two valid settings.

=46or now.
--=20
Jakub Narebski
