From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Eric Sunshine mail delivery failure
Date: Sun, 23 Aug 2015 14:48:08 -0400
Message-ID: <CAPig+cS+sDQV0O=pZXL9sw8ww39J=asxrbNm28jG0VSFhXtmtA@mail.gmail.com>
References: <20150811104056.16465.58131@localhost>
	<55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost>
	<55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
	<55D993F8.4080506@web.de>
	<20150823171622.GA28700@zorg.kyriasis.com>
	<CAPig+cR3zZK5BJmG0S2K0PLcY9p-1Ko4ynR9GzM2wLq8xjn36g@mail.gmail.com>
	<CA+EOSBmk2cdQe3owaXgkYAgTZqpUFa=J8g5FYq28-=VhDcJ4EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 20:48:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTaJT-0003Im-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 20:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbbHWSsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 14:48:10 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33969 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbHWSsJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2015 14:48:09 -0400
Received: by ykdt205 with SMTP id t205so115854450ykd.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=h6Ziw/1FWg6EDitcGfCS2X3hfrnG454eyD721X8/DGo=;
        b=qjCY43eqyf32/W+SHZAeq1xA1rYSVuDc1q4fxjSlt4oPDhpDVAVYhE36EoVqxbGc6x
         4wSegsi4/7+yolMFvYUZCeTCR89dJ9MNKyogMivFNuFnxcslDjBCcYHcgTY+50ZsueV4
         rfmxJWVbgvWdwIJ4b53nqT9a/Oc7k+OKkKv+U+aKGtdxbIvcrizt7mEUHPK0DptC4t0+
         5tXYbHTmOowvNSBZGKYnXJ52LnlFUnDjiLpiAWdwlXaOVo3Lxv4Saf8mgn/30SysaHEr
         xM7OLNrBQfF57qdcaRjLYyz1h/a0reQHyS2spIy6WeGhGEpY0rhQQUsZkJ+59iM1w0Ed
         6BGA==
X-Received: by 10.129.92.8 with SMTP id q8mr25246199ywb.163.1440355688423;
 Sun, 23 Aug 2015 11:48:08 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 23 Aug 2015 11:48:08 -0700 (PDT)
In-Reply-To: <CA+EOSBmk2cdQe3owaXgkYAgTZqpUFa=J8g5FYq28-=VhDcJ4EA@mail.gmail.com>
X-Google-Sender-Auth: 29nglOwgqpPtKFXnJINaOisr-2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276421>

On Sun, Aug 23, 2015 at 2:36 PM, Elia Pinto <gitter.spiros@gmail.com> w=
rote:
> Il 23/Ago/2015 20:26, "Eric Sunshine" <sunshine@sunshineco.com> ha sc=
ritto:
>> On Sun, Aug 23, 2015 at 1:16 PM, Johannes L=C3=B6thberg
>> <johannes@kyriasis.com> wrote:
>> > Just an A record would be enough. The issue is that mail.sunshinec=
o.com
>> > has
>> > neither an A nor an AAAA record, it is a CNAME to sunshineco.com, =
which
>> > is
>> > invalid according to RFC2181.
>>
>> Interestingly, the default configuration for all domains managed by
>> this service provider is for the mailhost to be a CNAME. While the
>> restriction in section 10.3 of RFC2181 makes sense as a way to avoid
>> extra "network burden", in practice, email services seem to be prett=
y
>> relaxed about it, and follow the CNAME indirection as needed.
>>
>> I suppose it's possible that web.de is being extra strict (although =
it
>> seems that such strictness would be painful for its users), or this
>> could just be a temporary DNS lookup failure. It's hard to tell base=
d
>> upon the errors Ren=C3=A9 reported.
>>
>> I did change the CNAME to an A just in case, though who knows how lo=
ng
>> it will take for the change to propagate over to web.de's server.
> Anyone can check Here https://dnschecker.org/#CNAME/Mail.sunshineco.c=
om
> It would fail with your change

Interesting service; thanks for the pointer. However, since it's just
querying a random set of DNS servers, it's not necessarily indicative
of whether the change has actually propagated to the DNS server(s)
answering web.de's mail server's queries. Local configuration (TTL's,
etc.) on those servers or anywhere in between, as well as network
conditions, could impact propagation to an unknown degree.
