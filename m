From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 14:16:56 -0500
Message-ID: <20100720191655.GA1705@burratino>
References: <20100720163822.GA8492@localhost.localdomain>
 <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
 <7veieym3sh.fsf@alter.siamese.dyndns.org>
 <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
 <7v1vaym27n.fsf@alter.siamese.dyndns.org>
 <AANLkTil5eq2radUKvle7Ez48CDRfb8dvWcEobXzGaKNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 21:18:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIKK-0007Kv-0F
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758645Ab0GTTR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 15:17:58 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761440Ab0GTTR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:17:57 -0400
Received: by ewy23 with SMTP id 23so1900184ewy.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s8mzgeKlzlFP+MUmVvodTQKOYECjNVwddlI3CVmMpNE=;
        b=EvpJpcv6B5f1rLkv0pGxr60QNEKXNuJnPNVvVHkkV1G878Yvx12C3yRd6zgpzAj367
         6SlqX3Y+9ZceZX42TT1umkpG2Kkc5muvEIsIXVj+KqQIkKzHJOAGGN/BXLNF97xihf4V
         7/Mb1EASZZl3x7BfD/OLLWWgIbAuM0+PBhv7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZIRLqDMwPzlVjcZ4Sda1OAvxIe7zS/jshY015NDTZAj4VbZ6v5kGKTsO3ILllntjOe
         65YQhj/uLya0BX4HdQDC9hH2oRKXjec3Mq8RdwaVt/QsTX52e2fSjTmJP8yAU8xw6Lqn
         Vh/RUz5ggk3tvrF5OwbNi0ZVeBE87LMep1qNc=
Received: by 10.213.34.77 with SMTP id k13mr2753882ebd.77.1279653476055;
        Tue, 20 Jul 2010 12:17:56 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v8sm52055763eeh.2.2010.07.20.12.17.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:17:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil5eq2radUKvle7Ez48CDRfb8dvWcEobXzGaKNA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151353>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> That's what we seem to be doing in the tests so far, i.e. test_must_f=
ail
> is reserved for git commands only.

test_must_fail relies on conventions for return value that cannot
necessarily be relied on from outside utilities.

Thanks for cleaning up my mess.
Jonathan
