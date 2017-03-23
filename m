Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3923720958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935332AbdCWRay (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:30:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:57898 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933717AbdCWRaw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:30:52 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M70HF-1bvIwo4Buv-00woMK; Thu, 23
 Mar 2017 18:30:36 +0100
Date:   Thu, 23 Mar 2017 18:30:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ivan Tham <pickfire@riseup.net>
cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: Re: GSoC Project | Convert interactive rebase to C
In-Reply-To: <20170321060526.sXz0cdJwc%pickfire@riseup.net>
Message-ID: <alpine.DEB.2.20.1703231827060.3767@virtualbox>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net> <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com> <20170321060526.sXz0cdJwc%pickfire@riseup.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PGZ+jNIh/25/Olcyn06aIM6Yn7UAq9Ekj+27gOmZyYhbNeW59ZQ
 h5Y5MVk4mfwkg59RqsvmTgRpGeeFuI2f/1s2p5/clIINfErzNpl1YSqNEtB2BnQVQeP7EUw
 JnFNz/HnQ1AJQbm/hMGssDUNz1hKnWtwNzo1bzxGup9iVXT9FHj/qzdWl/sTlezqS7hLY5B
 uySips1UfFsdp6jHFmrIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JIt6jHShDhc=:rCtlLj5t30a01MK3QWT1H8
 JPQgGt+f9AOVhjhFxwl+4JVW5Vv+Umm1RnmFxLlAGfaF3IIwNZSIIhhHQ0yjOObpoO6bmFNVr
 JQUSvoSS/5ukRY9wQozyXJpWzAKxfKuY4dtNV3y/AKuLb/uF3Pcw1VlP05jBazjvASuqRlRL4
 7lUkQR80ZDRWlLCiRkh97Jc1YCK0Gvu+WkjTAaeOiHjz/rOqGuiMPUMCnHqnSPkI1vx1SejgB
 42VMM+2lweX2NIkmW4zFMf5bv3A0kiOnR22bzRgFNnqn82tnP2cOfUoZ05Gf/Hi4rADoxftLC
 hoN88UR62/m1HLsv2u3nTexXCio+Zabvv9rccq+PcgvCSBPZ6ZuhXlLXAh+RzAxZnOYmtiOhs
 Z8KOnmL+Myq5+jeEMR+XkTpV3HJVLYk5MsuDCaCxdv0Y6ufZaVFiF6aZyMoQKs7ZySkNkpKWm
 IyzBjSlsONqvm4bgAr7dVX3N0CUS32OlrcqjxNlKIUZelHjK5Bga3TI8B1BAoGHkKb6J7J7n8
 UTTNizsL4m2ijZqwGUaZdzVSwTEGkasC/RsZsVhgOdrcGMfS+xVXOWJtlBTNbmYYlsv04u9IF
 8XsnkdK9fUlCpVDtkUJDDi9XfKC8HEY6Xe4zzrhIpkLki26BvLUWE5QikoMHjOofzernTylgG
 8Y/umHZNQl/oM2mKywNMiXMOngO0+y7L3gjlFB61VOpQahIiDIndDuGrd+Hq08lV2E+tPkyit
 I4rpt1rF8F1q54pxsNZGuM7/Vk4GNqOj37Ky7eKv3Cn3RFzcs4CJv838jSwfZgEV+F8DOHcl+
 FMyE5apjtVYSEnHHvOI3TevVekN3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ivan,

On Tue, 21 Mar 2017, Ivan Tham wrote:

> Stefan Beller <sbeller@google.com> wrote:
> > On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> wrote:
> > > I am Ivan Tham. Currently studying in Computer Science in APIIT
> > > Malaysia. I am interested particapate in Google Summer of Code 2017
> > > under git organization. I would like to attempt "Add more builtin
> > > patterns for userdiff" particularly for shell for my microproject.
> >
> > I'd love to see proper shell support!  Although there is already some
> > support for shell (by looking at diffs on our test suite) ? So I am
> > not sure what there is left to do? Can you clarify what you're trying
> > there?
> 
> Are you sure about that? From what I had looked into userdiff.c, there
> is no support for shell. There just a recent patch for [go patterns][0].
> Or perhaps I should have rename it as "userdiff.c: patterns for "shell"
> language"?

I also could not find any shell patterns in the userdiff code...

> > > I am interested to work on "Convert interactive rebase to C"
> >
> > +cc Johannes, who recently worked on rebase and the sequencer.

Glad you are interested! Please note that large parts of the interactive
rebase are already in C now, but there is enough work left in that corner.

> > > aiming to port most builtins stuff to C in which we can reduce the
> > > size of git. Additionally, I would also like to convert scripts to
> > > builtins as an additional milestone.

Careful. It is a ton of work to get the rebase -i conversion done, and
then a ton of work to get it integrated. That will fill 3 months, very
easily.

> > > What do you think of these projects? Would it collide with Valery
> > > Tolstov's Shell to Builtins proposal?

I missed that proposal, and could only find submodule-related mails on the
public-inbox server. Care to provide a pointer?

> > Curious why all people ask about colliding with Valerys proposal here?
> > I do not think it would collide, as submodules and rebase are very
> > different areas of the code base.

Indeed ;-)

Ciao,
Johannes
