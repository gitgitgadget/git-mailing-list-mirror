From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 01:08:53 +0530
Message-ID: <CALkWK0nfOSC8Q9WiU3SG437=7aQrD5nMhCGxung_OenUxiCDAg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz> <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
 <7vd2ryueuu.fsf@alter.siamese.dyndns.org> <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
 <CALkWK0m4V4KYyKW8KJMRsCgOxqcLi0XDYZvS4w++6BKVVvioyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, David Lang <david@lang.hm>,
	Greg Troxel <gdt@ir.bbn.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:39:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2Vf-000850-Og
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab3FGTjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:39:35 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33498 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab3FGTje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:39:34 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so9025196iec.21
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gQXw6orYjg8iJKncSYezK6Y/fEF2hV05AtMJxrja9F4=;
        b=l5Ns3zfLwLLtHt0gOWS6WR0pUVU5GferVdQLhGvp6dOb2+XyGHuNiXR7Ng4LOTjk6z
         Vcgf+LV2vv9q6qrmyKZbCSBBe1brITLDYX5Ry4Pj8oSIW3xVbeoyd8gC2blIPqMeHq5S
         V4gLNXQVB1s3N1IYVVZ6pVi12qTPd0tvSua8KxIAY1tUrvLQ2BJFWm8RAHivz7COiitA
         +DLnLO1NGVuqSVx/KzwLc9HCUSKEHMQmPwpi4+0qwifFhZql4mvdQlzM9V30wKXf6K7s
         rxCjW0gQgYAVUsGhcSBNI4B8T0LjbGBvX41vFSzviYhgTxEIWNaPka81QIUffQpPLT8Q
         eFVQ==
X-Received: by 10.42.31.69 with SMTP id y5mr54419icc.44.1370633974162; Fri, 07
 Jun 2013 12:39:34 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 12:38:53 -0700 (PDT)
In-Reply-To: <CALkWK0m4V4KYyKW8KJMRsCgOxqcLi0XDYZvS4w++6BKVVvioyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226687>

Ramkumar Ramachandra wrote:
> commit a lot of good ruby code to contrib*

Oh, by the way: I have a project idea.  There's this really popular
project called hub[1] that has an implementation of the GitHub API in
ruby.  Unfortunately, it's a terrible piece of software because it
creates an extra layer of indirection by putting a ruby wrapper on top
of git, and this slows git down: I cannot tolerate even a microsecond
of delay in git.  Maybe it's worth ripping out the GitHub API
implementation and writing some useful subcommands?

[1]: https://github.com/defunkt/hub
