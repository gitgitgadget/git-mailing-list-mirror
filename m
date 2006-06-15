From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Thu, 15 Jun 2006 21:46:18 +0200
Message-ID: <e5bfff550606151246x39295ec7kf5081feec8c4e2f@mail.gmail.com>
References: <11500407193506-git-send-email-octo@verplant.org>
	 <20060612213826.GC4705@c165.ib.student.liu.se>
	 <Pine.LNX.4.63.0606130041260.25422@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0606121546320.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Fredrik Kuivinen" <freku045@student.liu.se>,
	"Florian Forster" <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 21:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqxnL-0002Uh-5a
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 21:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031210AbWFOTqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 15:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031220AbWFOTqU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 15:46:20 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:26007 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1031210AbWFOTqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 15:46:19 -0400
Received: by py-out-1112.google.com with SMTP id i49so395245pye
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 12:46:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OJ2sSAdPgLPwnKx4Ek/0WNDJb33fvQTT31cUBDF6iEKDMUUUveLe7QpeKxkE6qrfGgxzRQUQKCHq3TI7AYYuTEgVcXx1uo/gU8rBSEFt/D4qiNVX1Nh3dH/0bWiCCP40Ckiq5AzPiaGSGuatQQbxvlA32os+T6L64Vsvji9MmLY=
Received: by 10.35.126.7 with SMTP id d7mr3536082pyn;
        Thu, 15 Jun 2006 12:46:18 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Thu, 15 Jun 2006 12:46:18 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606121546320.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21902>

On 6/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 13 Jun 2006, Johannes Schindelin wrote:
> >
> > On Mon, 12 Jun 2006, Fredrik Kuivinen wrote:
> >
> > > git-blame is a bit faster than git-annotate and, as far as I know, it
> > > produces output which is correct.
> >
> > Yeah: Bring It On(tm)! I already waited for ages for this war to begin!
>
> Sadly, I don't think either of you can really do much about the fact that
> annotate/blame is simply the wrong model for git.
>
> The war _I_d like to see is the GUI thing which does the "show when this
> section changed last" by following the history down only so far that the
> selected section shows up in the diff against the most current thing.
>

Probably I have misunderstood the request, but in qgit you can (from
about one month ago) mouse select some lines in file content then
press the filter button and see only the revisions that modify the
selected text.

Also selected text is highlighted so to better view differences among revisions.

It is not clear to me in what the requested feature differs from this
implementation.

    Marco
