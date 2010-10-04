From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 08:02:38 +0000
Message-ID: <AANLkTim=kCH_D23r77FbkSq-8UF38WBPE0CGxRxT8Szf@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
	<1286099806-25774-7-git-send-email-avarab@gmail.com>
	<AANLkTimH8Lj69qcOCmR3+5HYfgKnr5nyMvQU=9h0=FaB@mail.gmail.com>
	<201010032019.09244.j6t@kdbg.org>
	<20101004074916.GK24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Thomas Adam <thomas@xteddy.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 10:06:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2g4U-0004R7-Tx
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 10:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0JDICk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 04:02:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33111 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab0JDICj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 04:02:39 -0400
Received: by iwn5 with SMTP id 5so6602695iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=n6Xja026TLisKgLciyAB+TbkNWjiD60fMQ2GdCzbIOc=;
        b=rtgY1QGVCFbaTANaTquCA1yMsepa13eRpbOY2pA9WSMBjrfzsz6Tlyj9hntOJvC6Yr
         Y28eN7g0va84fFDvhvqaVO0SEwyhjM82+jCqqmAZDhVJuNQxzDEOO7uN1GUSJKyEH8a8
         f0OeZNWr73fq52T9EvD4gvV0byX7iMS7XeOSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mjZAT30sPtl41k829WMJjQEnw6tRVDdcn1aM5MAL//Nh4B2+DjusCwwajULUKrX//u
         uTtkgrkBSDuuzAkpzqbWh2qu10uaE2wS5SMqRsEHGC/8ji+t8MpQj5NSb6vn6lCS7nFx
         QQcFEUVHS5yxq32SM+kbyXybuCDZkXEEcKcu8=
Received: by 10.231.146.134 with SMTP id h6mr9732695ibv.170.1286179358824;
 Mon, 04 Oct 2010 01:02:38 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 01:02:38 -0700 (PDT)
In-Reply-To: <20101004074916.GK24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158010>

On Mon, Oct 4, 2010 at 07:49, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Did anyone time it?

> static inline int step(unsigned char c1, unsigned char c2,

If it hasn't been timed isn't it better to leave it up to the compiler
whether it wants to inline that or not?
