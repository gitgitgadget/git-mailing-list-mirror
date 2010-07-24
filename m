From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] t/README: A new section about test coverage
Date: Sat, 24 Jul 2010 18:32:32 -0500
Message-ID: <20100724233232.GB6374@burratino>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
 <1280004663-4887-7-git-send-email-avarab@gmail.com>
 <20100724212542.GA5610@burratino>
 <AANLkTim7v199lMKNEhOALx_38ChIIgvD4oERQJU5SNdv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcoDs-0000Fq-Ji
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab0GXXdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:33:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49885 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab0GXXdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 19:33:35 -0400
Received: by iwn7 with SMTP id 7so1532283iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GM6HkBwcvUf5IiJtCIK071pa7BZ90bhUo5OmCtnPNuY=;
        b=eIjnoYkpLxiRa2WtQqNhlrQSX4jPqDMrUVhRo5MAoR5HJLt7DziqK/8n83TbqJ4PWk
         KSH7STwYIEnaeKSBdKjC+g/txkKPYYhRHqQFgSwAiQkpIUWD6sXjynvs0XZs62BZZREV
         6EcGzxwClqFaRWtfzwCRyYyvzTPau2uQTZgn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ssYmt0RErVjutwfq5lEkg39woITgGAmrfNYfEVh4+0L1EJtNwCRdirl9FIIjQjbTBK
         XnA0/vhrev0l6c9NXZsnjn9XAbmuXAFIbbxaSpoldW6r/fRRj+AUmnl4TV0yTjrkRnun
         M/sdOKKOSLpIaPvxS+xF3hVG1Gqv8b+As6OKE=
Received: by 10.231.177.25 with SMTP id bg25mr5717704ibb.154.1280014414694;
        Sat, 24 Jul 2010 16:33:34 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1842708ibh.10.2010.07.24.16.33.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 16:33:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim7v199lMKNEhOALx_38ChIIgvD4oERQJU5SNdv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151689>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> + - Check the test coverage for your tests. See the "Test coverage"
>>> + =C2=A0 below.
[...]
> What I was going for here is that you should try to make sure that th=
e
> code you're adding is covered by tests by running the coverage tests.
>=20
> I.e. if I add a new function "blah" to git-whatever which is
> implemented by the "do_blah" function checking if every line of
> "do_blah" is covered is an excellent indicator of whether that code i=
s
> being exhaustively tested, as opposed to just superficially tested.
>=20
> In most cases a low test coverage counts is telling about the overall
> quality of the tests.
>=20
> But, the wording can probably be improved. Do you have a suggestion
> for the above intent compressed into a sentence or two? I can't come
> up with anything right now.

What I meant is that when developing a new feature, I think paying
too much attention to coverage numbers is a very dangerous thing.

It produces two hazards: too many tests and too few tests.

 - too many tests because when I write my "do_blah" function
   that is about a case no one cares about in practice, to write
   artificial tests to exercise would actually be to do harm.

 - too few tests because if I focus on testing all the code I
   just wrote, then I am very unlikely to include tests for the
   cases I did /not/ write code for.  Some important cases are
   just easy; we should still test them because that will help
   if the code is ever refactored later.  Some important cases
   may be just not implemented yet; test cases for them are
   very helpful indeed to readers and future implementers.

In other words, I would rather that when writing tests, authors would
forget about the implementation for a moment and just think about what
a user wants to do.

That said:

The rest of the time, checking test coverage does provide a very good
indication about what features might not be well tested yet.  So it is
still a good way to decide where to /start/ writing tests.

Plus it=E2=80=99s great fun to look at. :)

Thanks,
Jonathan
