From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 20:43:25 +0200
Message-ID: <e5bfff550709231143m7eb351bx4cf1c60d1247cc3d@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	 <20070923104525.GC7118@artemis.corp>
	 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	 <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
	 <e5bfff550709231105h94d08e2n9b1234e7c1a7e6a8@mail.gmail.com>
	 <85hcllmdzb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 20:43:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZWQX-0008EK-2z
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 20:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbXIWSn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 14:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755943AbXIWSn0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 14:43:26 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:26121 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbXIWSnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 14:43:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1226161rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ig/AqZRgHNfZrEmEzCGj14VGo05v74uXRknBLzlaCJQ=;
        b=RJiYN266AVGnaWBxn8Z+Zpd7JInZk3jL78RyVP+NDLcdqgMWqqw6taIFGWGKfHxnrDj1bvckx+3OLc+IVoBBBAy0DNlqzRi77xmUjrzZFcIFJLB/IemdbpYHxpRQ7VvK+bs2BzTrQHu+Q3hwfR5Dxgqjfc9icBiRjr4JGViuV+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JtsIAHMa5SHsEFozYj2Rgs+ailJMovrTfMC4vPIx3M4HiZciCEQwAXFM+9Jy/m64+cAYHku2JEjv1o7CFwHgAMW2t8Pi+GVzJ7zPdWyf40euxZH+pAZlO2v7aWyBdSnsylvHZ1d0hYlUaWhqcnahlhQ+30hB+6PGye0r7P3RP8w=
Received: by 10.140.250.14 with SMTP id x14mr1436827rvh.1190573005319;
        Sun, 23 Sep 2007 11:43:25 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 23 Sep 2007 11:43:25 -0700 (PDT)
In-Reply-To: <85hcllmdzb.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58975>

On 9/23/07, David Kastrup <dak@gnu.org> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > On 9/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>
> >> There are a few features of C++ that I really really like. For example, I
> >> think the C preprocessor is absolutely horrid, and a preprocessor that is
> >> built into the language - and integrates with the syntax - would be
> >> wonderful. And while C++ doesn't improve on that, at least templates are
> >> an example of something like that. Not perfect, but that's the kind of
> >> feature that C really would like.
> >>
> >
> > Yes, I really agree. IMO templates are the thing that more resembles
> > procedural programming, a common way of using them is to split data
> > structures (containers) from functions that operates on them
> > (algorithms). I find them very similar to the struct + functions
> > classical approach of C.
> >
> > And BTW
> >
> > template <typename T>
> >
> > is the thing in C++ that more remembers me of opaque pointers and
> > their use in C, the difference is that the first is fully type
> > checked.
>
> Not really.  The difference is that the first generates new (and
> optimized) code for every type which is something you can only do
> using macros in C.  Class programming is similar to opaque pointers
> (in particular concerning the generated code) but templates are really
> more like macros, as their instantiation generates specialized code,
> not at all like the handling of opaque pointers.
>

Probably if I had written like this was more clear:

template <typename T>  int some_function(T* p);

And regarding 'new' code for each type I would like to remember that
template instantations of different types can be removed by
compiler/linker when the instantations are the same (i.e. produce the
same binary instuctions), this could happen for function templates
that handle pointers, as example.

Marco
