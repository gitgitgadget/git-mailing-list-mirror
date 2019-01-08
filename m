Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A6F1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfAHH0z (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 02:26:55 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46506 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHH0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 02:26:55 -0500
Received: by mail-ot1-f45.google.com with SMTP id w25so2635410otm.13
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 23:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+FGeH1ZS94lseqbkdgLz6MRGkAwS20Y6+wvvARlQy8M=;
        b=HQF+rXbDSxHTmQKwyRfHK9ZNZpNcomcfiupquiPXo9z+oYxUDKzu8Bp9gWTOu1vfeo
         M9vs/TXH9T51aOh1V5cCp0Mc/FbqTy7ENC8tyx+VWTddbd1pNXhl6vw4Zt0QxIPyvEe7
         zTErZ0826UMA+IYkP+0IymGJjUKg6+9i2rzX/qJMBM1ZiTxTFJyw5JcKDT9hQLO3qPDZ
         V7lOrAzdzY+BtyFpQwfYdb1iBdNqmUXlZ/0DcWqKWgodIxlqbykSHYsVqTSHVoj76PDC
         HaBnkvIDZ0Hv1+5OkfVnvl9rl2CBhvfHuf8WAyhbkxsD1Ok6gFcGQTAHTFSSX9hUsHpi
         HKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+FGeH1ZS94lseqbkdgLz6MRGkAwS20Y6+wvvARlQy8M=;
        b=MvFCSIovoNxr8mEPdUZv/aY4G/L/UBATB+KYOgFVZU8lO2FrBpfeRKprDVu7IShhlu
         FqHBYbDCvjt1VccngdYc7WTfrbauR0v3b0WsWeNeW6ysO2GlghFfkNz/S4N5pYogd8Qn
         ovkA+tf3UJt1kCV3BXkMr0Tx/DKccOqgb8/kp4wE5REOV7BNPv3b6Mv8ZWR2VyuxuPl+
         IxcYrVS+Os08mZuJ4SyK4A1cz6Jo1O/ZWdCj5yF+78LjrWK+fj3GONzMbRXwZum6QCkL
         1eNycMUmn+8z8pCBHNClcEkG/ersX5s0rff6hE1vzgRdfzqKwDTKPx35UCIDruA5NxW9
         +9yA==
X-Gm-Message-State: AJcUukdzlJhghojpjB1y1KmeIejunXOGlrXiWZUwJ8djL7GFTBysSqgk
        qbgVNm9BBYrRQWSDvsqwkhbkNx7/YDvjxK1aRFDboxtj
X-Google-Smtp-Source: ALg8bN7UfRbbeBVvHYFzEJZScP6mabFotfQMIgyrwiPQXklPGVqUatf6rRde/yqqwF4lScYGsomV8sqArB8+g1s4PuM=
X-Received: by 2002:a9d:2926:: with SMTP id d35mr439511otb.355.1546932414116;
 Mon, 07 Jan 2019 23:26:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+BUw6jXTt6QGXvdFjRDNqJcij+1hNP5xybUUuGqo3bY0=ueuA@mail.gmail.com>
 <20190108063456.GA17588@sigill.intra.peff.net>
In-Reply-To: <20190108063456.GA17588@sigill.intra.peff.net>
From:   Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Date:   Tue, 8 Jan 2019 08:26:42 +0100
Message-ID: <CA+BUw6h5YdimR7cBV_=Mp4KqUMvJr6-njFPEpp-pjPBCcOKx6A@mail.gmail.com>
Subject: Re: Suspicious fetch-pack behaviour
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mar. 8 janv. 2019 =C3=A0 07:34, Jeff King <peff@peff.net> a =C3=A9crit :
>
> On Thu, Jan 03, 2019 at 10:52:48AM +0100, Guilhem Bonnefille wrote:
>
> > One of my users reported a strange problem: a simple HTTPS clone did
> > not work with Git 1.8.3.1 on RedHat 7.
> > I did many tests and I was not able to understand why his clone don't
> > work while I'm able to do it on other similar host.
> >
> > Nevertheless, we did more investigations. One of them: a raw strace.
> > I discovered two strange behaviours:
> > - fetch-pack closes its standard input and standard output and then
> > tries to print the references on standard input and finaly dies.
> > - git-remote-https does not react to fetch-pack death and continue
> > polling an empty set of FD.
> >
> > [...]
> >
> > 2769  poll(NULL, 0, 1000)               =3D 0 (Timeout)
>
> We actually don't use poll() very much in Git. And poking around the
> v1.8.3.1 source, I do not see any places where remote-https would call
> poll(), and none outside of "git help" and "git credential-cache-daemon"
> that would ever provide a timeout like "1000".
>
> I wonder if this poll is actually being run by libcurl.  Is it possible
> to get a backtrace of the looping process with gdb?

Quite hard to debug as it occured on a computer provided by a
customer, far from me...

> I'd also point out that v1.8.3.1 is over 5 years old, and there have
> been quite a few http-related fixes over the years.

Yes, it is an old version, but it is the version provided with RedHat 7.

> There is a good
> chance that if this is a Git bug, it has long since been fixed. Is it
> possible to reproduce with a more modern version of Git?
>

What is surprisingly is that I was unable to reproduce with the same
version on an other computer.

During this time, my user discovered the IT team of the customer
prvide a much more recent version of Git (2.X). With this new version,
the problem was not reproduced.


Thanks for all your investigations.


--=20
Guilhem BONNEFILLE
-=3D- JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=3D- mailto:guilhem.bonnefille@gmail.com
-=3D- http://nathguil.free.fr/
