From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 14:38:06 +0000
Message-ID: <e2b179460903240738x272c884q62a666931ce99c2f@mail.gmail.com>
References: <49C8B159.2040600@gmail.com>
	 <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
	 <49C8E074.4030808@gmail.com>
	 <20090324135906.GA10644@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>, Roel Kluin <roel.kluin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 15:39:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm7n5-0004zb-T1
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 15:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311AbZCXOiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756019AbZCXOiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 10:38:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:57372 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbZCXOiI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 10:38:08 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2193504qwh.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V16W+rGXlPPLPHujezYBPSpbwqA0tas+3J7UzREspcs=;
        b=ddv7s2jKtThioJwzTrRNDGZmSTy0Bf6SFyN5ERGMhpxx0gi3/3uTkGvqj8qHbSGRk+
         EpHFgoscyqE9W51KfqhB2wLvJqh0qkiX19y94jhkVb2gs1Vv7wUHpz8R0B9fUCuhDZ9t
         J54smTiw+F9DrZ4H1BcLaDBmAeC/IwjylCgyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u9DPGphXF1in7C0kmIHiG1tb4X9Wws7Rzo8saplECcEPeL4lLmmWTLbF6uTKCu2IXw
         0Lbjuqfjy52FoGfVYna5LcsmLm8DM3W9z6mtbqIqRBNOEBxolvLrsl2W8hfOVq086VCs
         8snjeD0aEIdrHAaXGXmgF3W9l+mRI654L7G64=
Received: by 10.224.45.134 with SMTP id e6mr10747098qaf.237.1237905486181; 
	Tue, 24 Mar 2009 07:38:06 -0700 (PDT)
In-Reply-To: <20090324135906.GA10644@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114463>

2009/3/24 Jeff King <peff@peff.net>:
> Wouldn't it be a lot easier to base this on something like ctags, whi=
ch
> already knows how to do all the parsing of C quirky C?
>
> I.e.:
>
> =C2=A0git ls-files | xargs ctags
> =C2=A0vi -t get_sha1
>
> Where you can replace "vi" with your editor of choice.

This kind of pipeline has the benefit that it can actually work on the
*repository*, and not just the working copy (as per the posted
script).

Although this kind of tool might be useful (I might even use it myself
for working on git, rather than as *part of git* on my other projects,
which are not written in C), it's a bit tangential even for contrib/
isn't it?

> And if you really like getting the definition dumped to stdout,
> writing a command-line viewer for the ctags format would be
> quite simple (and I would be surprised if one hasn't been
> written already).

http://users.telenet.be/bdr/pub/cshow/  ?

Mike
