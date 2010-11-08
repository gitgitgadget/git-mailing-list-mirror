From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Mon, 8 Nov 2010 15:38:44 -0600
Message-ID: <20101108213844.GB13114@burratino>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
 <AANLkTik48HPHn4Xfwn5kuS2uHenQfjTJFaXMe9iSe5vU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZQh-000604-6c
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab0KHVjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 16:39:01 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63345 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab0KHVjA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 16:39:00 -0500
Received: by fxm16 with SMTP id 16so4437910fxm.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 13:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=R8hmGvnxjXiQBNz3uxOrwEaJET+XYoFmZItypJ4wKB8=;
        b=gJYPjwW622s0qjK03ul6gNcDKDC10A+sa7573ANyQ3/cK1py0EVr3xJ878zxA5g2H6
         O6zLFxZxp3d7gHr7CxpUiSk66V3cyCQO0IqKZpN0yGiF8Gi5R7kiE4EqDQAyV1hlVanI
         3CYT+KnpUWOEgYKndapY8Kr4aWrkNblXktW0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=meG2Y8xrWRePkULWqJvB5hWyyp6mRlb1h0bd2tVaCNKOd0SPOTdHQWFOrcUs0D0rAO
         nhxAL23oN0c1hGFgPFHl+I4ek0nFEhlUS6Rn/FDQiZ306/zFcpGa/JjP4b4UKyUwNNF/
         nRJe8TlrD+wvTFPv1vUFrcxicFILw1Aa3nWds=
Received: by 10.223.79.72 with SMTP id o8mr4349168fak.83.1289252339377;
        Mon, 08 Nov 2010 13:38:59 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 15sm258603fal.46.2010.11.08.13.38.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 13:38:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik48HPHn4Xfwn5kuS2uHenQfjTJFaXMe9iSe5vU@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160993>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>> =C2=A0The alternative would be to use 3 =3D $(wc -l) (sans quotes), =
but other parts
>> =C2=A0of the test used the -eq method.
>
> A IMO saner alternative is to add a new test-lib.sh function for this=
=2E
>=20
> E.g.:
>=20
> -       test 3 =3D "$(git ls-files -u | wc -l)" &&
> -       test_wc 3 "git ls-files -u" &&
>=20
> We could use test_cmp or something internally so we'd get meaningful
> output when those tests fail.

See http://thread.gmane.org/gmane.comp.version-control.git/157903/focus=
=3D160421
for example.
