From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: libgit2 status
Date: Fri, 19 Oct 2012 22:21:30 -0300
Message-ID: <CACnwZYdiz05xRr5b+Hn0o-wZRm+cOJ3hQ8LGiABm8G10Pos10A@mail.gmail.com>
References: <87a9xkqtfg.fsf@waller.obbligato.org>
	<5038A148.4020003@op5.se>
	<7vharpv77n.fsf@alter.siamese.dyndns.org>
	<nnglih0jotj.fsf@transit.us.cray.com>
	<7vfw78s1kd.fsf@alter.siamese.dyndns.org>
	<nngsjb8i30w.fsf@transit.us.cray.com>
	<7v6284qfw8.fsf@alter.siamese.dyndns.org>
	<20120827214027.GA511@vidovic>
	<nngr4qqhp7x.fsf@transit.us.cray.com>
	<7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
	<CACnwZYe6BZVuqCCPho5+3dy=rzKqDv1A8uGAvhLm2JPO9b2LMw@mail.gmail.com>
	<CALkWK0=P7THaJduYFS1Sr6mxtNqAWQsDgwQyr_KEX4NA4kmVSA@mail.gmail.com>
	<7vvce6i5j2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	dag@cray.com, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, greened@obbligato.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 03:21:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPNl2-0001qI-4e
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 03:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759446Ab2JTBVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 21:21:32 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:48944 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab2JTBVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 21:21:31 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so644911lag.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 18:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9IW3K+FNa8ijECoXz6x/KoykbDZb7v3rybwSEGJa2bE=;
        b=G9fUloninKf1v12cEi/6diMoHfpVkCOY5evD8AWLzOlDwf5B+iDrUyLlrdzk3xmJiS
         piheemqSJpNfRPS9SSdVF9n56X4g/+8X7RhjWhBOk6tQDJPN3TgDrO2XMVXb8kpEN34C
         wWCClzVCImm/XH4q2pzTOjnGSNsheQiX0yfqbFwPnvgypzu07DMXUYFQk3D6kv2ZAa2b
         2S7Pyjf7/5hIdQDUHUd1KLKnP8GiXQKTIoUe7SyFpvY94wQFogsrZgsQyG2dP+7vmgzN
         bsZZmmCAMg4fsMUoJwTNqwOHwu22nyc97fPFlsQoyYUUMGP1m+0xNp0UM2ovTa4rQNq1
         ds9g==
Received: by 10.152.124.111 with SMTP id mh15mr2477043lab.20.1350696090065;
 Fri, 19 Oct 2012 18:21:30 -0700 (PDT)
Received: by 10.112.45.98 with HTTP; Fri, 19 Oct 2012 18:21:30 -0700 (PDT)
In-Reply-To: <7vvce6i5j2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208078>

On Fri, Oct 19, 2012 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I actually hate "include/git.h vs src/git.c"; you have distinction
> between .c and .h already.
Which distinction are you talking about? This is not an issue of
header file versus source file, but a public header file to be
included by external projects versus internal header files that are
intended to be included only by git itself and that will probably live
under src/ directory.
