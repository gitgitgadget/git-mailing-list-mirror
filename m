From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Fri, 3 Dec 2010 03:10:08 -0600
Message-ID: <20101203091008.GF18202@burratino>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <20101203082701.GC26070@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, demerphq <demerphq@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Fri Dec 03 10:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORew-0006yg-0f
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab0LCJKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 04:10:23 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59936 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab0LCJKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 04:10:21 -0500
Received: by yxt3 with SMTP id 3so4139755yxt.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xV3qQdbC8yBop+kYs8y7B1THjaT5nGywyNNYsGSVM/o=;
        b=JeoH0cZgQ0sy+lg9mPLKn37yXfaP9g0e9isYH2NKpSYbuNisK3dL4trCoTNXWiPUa4
         LKwZGmxjTNMAvYhOTwLZG9EnJSuQEacWxKVVnPtZ7sUkHydaiupx1Wo5cvYBdfwd9D81
         VfUeBLO3+1t5THgIjOtanfVtg6158uksztIks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gFiNuOKOw/zrVCAttS+UuVT/Dg5dSK602zD9HTq8zPeq7Ymh5VA9x8Y5VOW8k3Jt0Z
         yuivGUTxg/uJEqPI5igBF26ug4yukj5BF+COL9IHwXvVo5ThwX4x6MyMtEfkcdSsg3fB
         LKyBT3pMjvxM1teRtP/0iIfx5gKpGB2dvmkSE=
Received: by 10.91.214.14 with SMTP id r14mr2852536agq.46.1291367420899;
        Fri, 03 Dec 2010 01:10:20 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id d10sm1585014and.19.2010.12.03.01.10.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 01:10:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101203082701.GC26070@raven.wolf.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162779>

Josef Wolf wrote:
> On Thu, Dec 02, 2010 at 02:23:32PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:

>> Couldn't you use one of the Perl Git wrappers on the CPAN?
>
> Which one would you suggest?

Judging from [1], Git::Wrapper might be worth trying.

That said, if you have more questions or any ideas for Git.pm, they
would be welcome.  That is when the lack of declared stable API can
come in handy. ;-)

[1] https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_to=
ols#Perl
