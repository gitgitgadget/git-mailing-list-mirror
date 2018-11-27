Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFDA1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeK1HLT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:11:19 -0500
Received: from [195.159.176.226] ([195.159.176.226]:55942 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeK1HLT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:11:19 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1gRjgK-0003hb-TQ
        for git@vger.kernel.org; Tue, 27 Nov 2018 21:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Tue, 27 Nov 2018 21:10:11 +0100
Organization: Linux Private Site
Message-ID: <878t1eqo2k.fsf@Rainer.invalid>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181126173252.1558-1-tboegi@web.de>
        <xmqqtvk3tj45.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Cancel-Lock: sha1:bCewt1GoTnFS1yX6gwB7InR4QXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:
> I wonder if it makes the rest of the code simpler if we stripped
> things like /cygdrive/c here exactly the sam way as we strip C:
> For that, has_dos_drive_prefix() needs to know /cygdrive/[a-z],
> which may not be a bad thing, I guess.  Let's read on.

The cygdrive prefix can be configured by the user to something
arbitrarily different, so if you're hoping to simplify the string
handling this way you'll most likely be disappointed.  It is exactly
that fact that led to the introduction of /proc/cygdrive as an
alternative prefix which doesn't depend on any configuration.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds

