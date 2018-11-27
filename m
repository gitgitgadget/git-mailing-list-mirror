Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404AF1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeK1HFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:05:00 -0500
Received: from [195.159.176.226] ([195.159.176.226]:46462 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeK1HFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:05:00 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1gRjaE-0004Zw-CG
        for git@vger.kernel.org; Tue, 27 Nov 2018 21:03:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Tue, 27 Nov 2018 21:05:51 +0100
Organization: Linux Private Site
Message-ID: <87d0qqqo9s.fsf@Rainer.invalid>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181126173252.1558-1-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Cancel-Lock: sha1:D0eYteehWuv/ZyKQ+n94UpHhOGM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:
> The solution is to implement has_dos_drive_prefix(), skip_dos_drive_prefix()
> is_dir_sep(), offset_1st_component() and convert_slashes() for cygwin
> in the same way as it is done in 'Git for Windows' in compat/mingw.[ch]

Please use the Cygwin API path conversion functions for C code and the
cygpath program for shell code instead of trying to re-implement your
own handling (which is prone to introduce subtle bugs or at least
different heuristics from what cygwin itself uses).

https://cygwin.com/cygwin-api/cygwin-functions.html#func-cygwin-path


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf microQ V2.22R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada

