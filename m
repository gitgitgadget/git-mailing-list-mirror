From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Should git-citool be in mainporcelain in command-list?
Date: Mon, 6 Sep 2010 16:39:37 -0500
Message-ID: <20100906213937.GF26371@burratino>
References: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 23:41:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsjRi-0008CW-U9
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803Ab0IFVlm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 17:41:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37241 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab0IFVll convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 17:41:41 -0400
Received: by qyk33 with SMTP id 33so4700542qyk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jvRdC1jJc5Ur+GjgDMFHJwNmnQ2Lq1BQuhz9C9sVOGI=;
        b=K73GnOsXhet2CDjpQutGt5LLdP381urBtI8JCZBkqg2Y2ApyHPukJjmp9C/mWOrBAt
         br6ww+6Bw8bCEikqDsIP0Uf0rI/6fXyp+W8aJ48ZyQFISQIQEj5PutAV5HVLZ/NwWD40
         r2EPBANjbxc5VSoijL2yXhLD4B5zfpxByOw+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=g46GXtkU0RfRQ19Pa6JceFoBFZN86IWTlPWiRyQU+t1YrufmNwvbgLgwV8/AMM2Ht3
         oWbamWFZPPzNyisDXWZd096R57DYjehCyzqetjBrntLuoursXzGkY3u7qohHFqC8E+Nj
         tvs0+xZwCxKsy6kxHiBD7NFuTmLRJI8PutEpM=
Received: by 10.229.112.21 with SMTP id u21mr3035438qcp.214.1283809300727;
        Mon, 06 Sep 2010 14:41:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id l13sm6120155qck.19.2010.09.06.14.41.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 14:41:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155628>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Maybe there should be an aliases category:
>=20
>     $ grep -e git-gui -e citool command-list.txt
>     git-citool                              mainporcelain
>     git-gui                                 mainporcelain
>=20
> A very minor nit, just something I ran into while gettext-izing and
> wondered "what's that".
>=20
> But I'm probably the only one that's used command-list.txt for
> anything non-Make related in a while :)

Its main purpose is to populate the command list in git.1:

   Main porcelain commands
[...]
	git-citool(1)
	   Graphical alternative to git-commit.
[...]
	git-gui(1)
	   A portable graphical interface to Git.

What do you think this should say?  (Honest question --- I
haven't thought hard about it.)
