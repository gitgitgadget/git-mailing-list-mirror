From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 22:35:12 +0200
Message-ID: <fabb9a1e0904051335l4382986cib738171967971ffe@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> 
	<fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> 
	<7vvdpjrkp0.fsf@gitster.siamese.dyndns.org> <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com> 
	<3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com> 
	<7vocvaq36x.fsf@gitster.siamese.dyndns.org> <20090405202551.GD4716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZ5d-00049C-14
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbZDEUfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758026AbZDEUfa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:35:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:58465 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbZDEUf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:35:29 -0400
Received: by mu-out-0910.google.com with SMTP id g7so658510muf.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+c0dQcqDbszr5UTX+Xus8nWBgUBQl5TaayGjyuPMU4w=;
        b=ONHAMuwVnb0ePpihyuPiRaaaM1kUlmKw/0JDfRHkEu23rFlipp4ArsKC7PPUizd6rk
         PM3AH2IeHGH1Fj176jI4gLdqkeuo2Z4j2D4VgENSJIq7CGK3n1W7Vkolz2w4EaXA99lp
         unX9cQHyLk2Y+gWhGbomEFu1LGx2paRLU8QK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FS5I68EJfQo+ioOBBOyj1hIHW32XOgQ59amV9EzBc5pYfOlAw0YRIHaOQaJZQqJCpu
         hzfWfmCdFDCtquKDTPAYxfvnKl93UOcBY1w9QslhmSantfNIO2RnrJ59kFWardSWvs16
         L/xM2xRz04AuTk6QjrUWrSbGN8c80P1asZ0dI=
In-Reply-To: <20090405202551.GD4716@coredump.intra.peff.net>
Received: by 10.103.11.5 with SMTP id o5mr1605951mui.132.1238963727249; Sun, 
	05 Apr 2009 13:35:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115703>

Heya,

On Sun, Apr 5, 2009 at 22:25, Jeff King <peff@peff.net> wrote:
> Actually, it is Sverre's fault. :)

Fine, blame the Dutch, why not! :P

> You quoted his message, quoting Christian's message. Christian's message
> was 7bit. But for some reason, Sverre's quoting of Christian's message
> contains weird iso8859 space characters (0xa0).

*points at GMail*, I ain't dun nothing funny! It's always been funny
WRT to vger and encoding issues though, so I'm not surprised.

-- 
Cheers,

Sverre Rabbelier
