From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 00/16] Add missing &&'s in the testsuite
Date: Mon, 4 Oct 2010 03:50:30 +0000
Message-ID: <AANLkTikcY=9pVq4upP0wt_YBtRKZsjyn7uHKyAonB+Nt@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<AANLkTi=+N=jm1b3vpiwxR0tFwPGbsaJyEq39q3oAyAn_@mail.gmail.com>
	<20101004034446.GA24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:50:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2c4S-0000P7-8w
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab0JDDuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:50:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46111 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0JDDub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:50:31 -0400
Received: by iwn5 with SMTP id 5so6387685iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AOFeb/btc9pby9x2UH8Qd+HhcMNLyI4uir01ipFQ5eE=;
        b=hW6ASzaGixwcdrU1RA7jzOC8rQHY64gxeV/PkKAQPb8jyGbmizEwy4bj/ORdJzzTYg
         5phLZwROfe042C/77kWRUwlUSAMFor5kgnCP5RIHgaBc1fHzBSlOCr7JZI4sy9r34izY
         J7b1BmL3EavYdgVFex6KdIXn05BvbQghO6K0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=au9eZoffQZBFswG3XAewYNqpVIE4mrhsWYOwNL4prWbAjHTUyA+raKLSUHIJ13Ahdy
         dskebn6zL3fDxXH2gDHaG6Pedt52aNdVICIUonuz4OJVSybBz5Ms+2x6MNgF/Mw2FQTq
         MiWEvm8eKtom7X/8xnfzLR1txM4qHUXE7GF9w=
Received: by 10.231.166.72 with SMTP id l8mr9488599iby.95.1286164230812; Sun,
 03 Oct 2010 20:50:30 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:50:30 -0700 (PDT)
In-Reply-To: <20101004034446.GA24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157969>

On Mon, Oct 4, 2010 at 03:44, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Hi =C3=86var,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Since Jonathan says all but 7 & 15 are OK (and I looked at those) I
>> assume I don't need to hunt down some other discussion and comment o=
n
>> that. I.e. unless someone replies here.
>
> If you find time, it would be nice to take a look at
> http://thread.gmane.org/gmane.comp.version-control.git/157827/focus=3D=
157874
> (concerning patch 1/16), to consider quoting issues.

Ah thanks. I just noticed that after having written that mail and
replied to it.
