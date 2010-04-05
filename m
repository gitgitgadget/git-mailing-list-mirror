From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Mon, 5 Apr 2010 12:58:22 -0500
Message-ID: <20100405175822.GA32083@progeny.tock>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
 <20100405055139.GA28730@coredump.intra.peff.net>
 <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 19:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyqYp-0000j0-Id
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 19:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab0DER6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 13:58:01 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:38665 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0DER56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 13:57:58 -0400
Received: by pzk31 with SMTP id 31so758793pzk.33
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VzJn1UwXO5uoScYEWd7Am47uccxW2mjZfavy1pNYeiI=;
        b=S+xrOUchl8olo59pkRGZbPrZBHCDSgld/DGwQly01Zo6oAliiBLoGc3TqtaQMfsqBY
         G8h693h13hGBJqPtEg06Uehq+CCR5C1gW9wJnHnqz20Zbd1tDflNQ6a7V8D+vBkAm8Rj
         qp0T8FPW6T37bJnBA55JlshAwDEVadzD+3s48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F89dRWV5z0HQrwa59P1/eQj5ZE03Effy02LkHENLDe58REibliBBK4oz6ZgFtqbiIJ
         Wh06nXyhM8w7Q0idkNCsPkBURLO3MxonfL8I7VH1kF0b5F9IfOoXz4yfkCinBErBS5SB
         BC4xENE2wV8XJw5ctK9zPVrWN/4yQ0B0yj9Uc=
Received: by 10.143.20.39 with SMTP id x39mr2052430wfi.236.1270490277471;
        Mon, 05 Apr 2010 10:57:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4729384iwn.5.2010.04.05.10.57.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 10:57:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143996>

Hi,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Learning to use and switching to
> something like git-fast-import(1) or git-commit-tree(1) is too big of
> a hurdle for small throwaway scripts that take ~1m to write and aren'=
t
> big dedicated importers like snerp-vortex.
>=20
> There's probably a lot of code out there doing `git commit -m"Yet
> another revision"' from some cron job.

=46WIW, I have no strong opinion about whether to add this --allow-empt=
y-message
option.  Maybe it would make something more convenient for someone,
though that has to be weighed against it making it harder for everyone
else to read the manual.

Instead, I just wanted to suggest that it is really worth the time to
learn to use =E2=80=98git commit-tree=E2=80=99.  Mostly because it does=
 not take much
time to learn at all.

Hint:

	parent=3DHEAD && : or whatever &&
	tree=3D$(git write-tree) &&
	printf "%s\n" message |
	commit=3D$(git commit-tree "$tree" -p "$parent") &&
	git update-ref refs/heads/somebranch "$commit"

It is a very flexible tool, and I think you will find yourself fighting
with git much less if you use tools like it in situations that would
be unusual for a human to run into.

Cheers,
Jonathan
