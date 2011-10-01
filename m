From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Git, Mac OS X and German special characters
Date: Sat, 1 Oct 2011 21:47:46 +0200
Message-ID: <20111001194746.GA16826@inner.h.iocl.org>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com> <4E87182C.8050201@op5.se> <CAO1Q+jeLEp2ReNc9eOFoJxdGq6oRE3b+O=JvMNU0Kqx_eAX=7w@mail.gmail.com> <4E872288.10503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Albert Zeyer <albzey@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Oct 01 21:48:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA5Xa-000081-94
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 21:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab1JATrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 15:47:53 -0400
Received: from continuum.iocl.org ([217.140.74.2]:49054 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1JATrw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 15:47:52 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p91Jlku18816;
	Sat, 1 Oct 2011 21:47:46 +0200
Content-Disposition: inline
In-Reply-To: <4E872288.10503@op5.se>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182572>

On Sat, 01 Oct 2011 09:24:08 +0000, Andreas Ericsson wrote:
=2E..
> The trouble is that they may represent two different files on a
> different filesystem. The Linux kernel repo has plenty of files
> that exist with both uppercase and lowercase characters, like so:
> SOMEFILE_driver.c
> somefile_driver.c
>=20
> This is perfectly valid on all sensible and case-sensitive
> filesystems, but breaks horribly on HFS.

It also breaks on windows, except in at least one country[1].
And the latter alone is good reason why no VCS should try to
forbid to use different characters that some filesystems
(and only some) consider the same.

> There are other, far more
> "interesting" cases when you involve special chars such as the
> german umlaut, or the swedish =E5=E4=F6 characters.

Care to share some?

The question is, should git forbid two filenames that consist
of the *same* characters, only differently uni-encoded? I don't
think anyone would make two files named 'B=FCro', with different
unicode encodings. But as far as I know that is a shady area.

Andreas

[1] Which has 'i with dot' and 'i without dot' both in uppercase
    and lowercase variant, so I and i are not the 'same'.
