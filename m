From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/15] gettextize: git-revert mark the "me" variable
 for translation
Date: Mon, 6 Sep 2010 15:08:38 -0500
Message-ID: <20100906200838.GB26371@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-13-git-send-email-avarab@gmail.com>
 <20100906184536.GD25426@burratino>
 <AANLkTik2aEYxgpL6QuhbacMv6i2hTNjJ1+0bFdK4tph-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:10:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osi1f-0007vW-PB
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab0IFUKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:10:43 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52170 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0IFUKm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:10:42 -0400
Received: by qwh6 with SMTP id 6so4093792qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=djT5dP2bwpI578aEbjKkxfqd1MHE5jqy5OhrukwYmp4=;
        b=UKLOG7QJQyTcRDXabBH8/kjsA4Hr8D4VR6amwraHYibUUDIruQT4Z6Cq8BXPbsA6Zf
         1iVeeiZaROy72U/JoDNG1vZ13HGvjKSvQB1S/H/GHRDFL/IG9ySr9t2p6gaR/l4Qv8E4
         SSHOPgkxzY5oyO2oJQK46L3ScHg+W5V9e+rEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XD3e/t4SnaF7hg6p027hwckxziren8Qoio9TpcJAFDbDzM/36B8JEfvSo2sNIjHjoZ
         OdTYLc5zuWLU3ukvMTaz89jfHbI2fOlLvP7Ka6R3Y02k6rEbviWCQD29AW/c9ugB5ikM
         wnrKg05IlLWDAerKPUzQGeajWMK+ccNlZFG9w=
Received: by 10.229.213.20 with SMTP id gu20mr3909175qcb.52.1283803841599;
        Mon, 06 Sep 2010 13:10:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm6019541qcq.10.2010.09.06.13.10.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 13:10:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik2aEYxgpL6QuhbacMv6i2hTNjJ1+0bFdK4tph-@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155608>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Sep 6, 2010 at 18:45, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> What good does it do to translate it? =C2=A0The command name is the =
same
>> even in Hindi git.
>
> Not all uses of it are references to git-%s, e.g. in the next patch:

Right, forget about this comment.  Maybe this patch should be squashed
with the next one so reviewers can more easily see what is going on.

> In this updated series I've explicitly reverted patches that
> (accidentally) translated some of the reflog.
>=20
> I'm only translating things which'll be viewed by human eyes, and
> human eyes alone. That doesn't apply to the reflog, which I see as
> plumbing.

Thanks for explaining.
