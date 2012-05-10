From: Stefan Zager <szager@google.com>
Subject: Re: submodule update --force
Date: Thu, 10 May 2012 00:20:19 -0700
Message-ID: <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
	<CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
	<7vobpwpoyi.fsf@alter.siamese.dyndns.org>
	<7vk40kpnia.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 09:21:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSNgL-00027I-GD
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 09:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab2EJHUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 03:20:30 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47212 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2EJHU3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 03:20:29 -0400
Received: by qcro28 with SMTP id o28so888303qcr.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=5ktDDpM91pW/aYpdOz7ERhdBo8k4J7RRx1oj8s/FRG4=;
        b=hOpqvguhhCWFtqClcS67s3ikTdVyxc4pLVJYDztU5SBK8hoH8LWbziLf5vNj31q/nn
         Iq0ym9XzJUtBtTz9/U8p86HrdkRe0pq2g0M1kajRWWYvrQBQj5Mx5kZGmcjQQk1HaJCH
         k/7zyPsY8+3mPq2D9AujLR5bf0A7hb6kawQ7cQ3NIGa9wmAkfaxYJ6PnYe0W364oJHBV
         5g8JUwFD5odsiZwLUM2oXiJzT97hr6OmBwe+Eg6iKaFilqXMlroageji5UqxqJEJdmmp
         atQurOZ+3/7QVFfteF3tcWJwAogYt1SzxAhXIwDAMw179SdB/snj9ehJLKliGEC+Z11m
         HYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=5ktDDpM91pW/aYpdOz7ERhdBo8k4J7RRx1oj8s/FRG4=;
        b=DhgXlrzlMR8ZYtmxrXXg+VrbHkq+ABGF17SZJFXTlNopo1hI13WRPoExTLUtVerl1R
         A0t/NT8MzDEcM2pBrCuiqX3+lWUqog+aSKZU5maJ49gj1APcWoDGwXy1Mu6Z5MNMf9Q8
         EONZ3g/aMDn3jHOO+w241apB4x7MbPNt6PgA8/qjWEO5s3/FTmqR3odZglVZ8RxjrCLD
         WvN1Yk+uHmAd53XkNLaheOTFKEufBnVXRdrLiZ4ocqn8peQ7U2McS5Ku2MajrnVPaGYk
         bLkUZeKtZIT7FO6lRgdUQ+kilbXqMJlX5DjyLK7igVXKyKHq5TdhMChFU0THm2BrjU+v
         M3FA==
Received: by 10.224.212.5 with SMTP id gq5mr10124519qab.1.1336634419771;
        Thu, 10 May 2012 00:20:19 -0700 (PDT)
Received: by 10.224.212.5 with SMTP id gq5mr10124508qab.1.1336634419683; Thu,
 10 May 2012 00:20:19 -0700 (PDT)
Received: by 10.229.135.211 with HTTP; Thu, 10 May 2012 00:20:19 -0700 (PDT)
In-Reply-To: <7vk40kpnia.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmt0dGK+Br9eQDmp1GVzbr2Te0rowNyi61s5yL/+NAWOhThito5V72h98RjoDoSnCaOMowcr5PO27sswD2xUeJ5jnA7uzuyT10FPXIdyjJdJYiNwiqbYultpO0kUvmfQstA5/xIfCM00hq4wW0i2/Xb6VH9pQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197549>

On Wed, May 9, 2012 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:

> If we follow that line of thought, it may make more sense not to impl=
ement
> your feature like the above patch, but instead make it so
>
> =A0 =A0 =A0 =A0if the user told us never to recurse
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nothing
> =A0 =A0 =A0 =A0elif the user told us to always recurse ||
> =A0 =A0 =A0 =A0 =A0 =A0 subsha1 !=3D sha1
> =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do the "recurse" thing
> =A0 =A0 =A0 =A0fi
>
> so that you can still force it recurse into the submodule, even when =
you
> do not necessarily want the "force checkout" thing to happen to clobb=
er
> the working tree.

I'm a bit confused by your use of the term recursion here.  It sounds
like you consider any operation run on a submodule to be a form of
recursion, which is not the way I think about it.  To my mind, any
`git submodule` command should *always* run on the first level of
submodules.  If you're going to specify --no-recurse, then why are you
running `git submodule` at all?  I think 'recursion' only applies to
moving beyond the first level of submodules.

I think your solution would work for our project, because we only use
one level of submodules.  But IMO the functionality, as you have
written it, is less generally useful.

Stefan
