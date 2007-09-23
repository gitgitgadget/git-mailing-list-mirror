From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 20:05:55 +0200
Message-ID: <e5bfff550709231105h94d08e2n9b1234e7c1a7e6a8@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F55E03.2040404@krose.org>
	 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	 <20070923104525.GC7118@artemis.corp>
	 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	 <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"David Kastrup" <dak@gnu.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 20:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZVqF-0004Kr-2P
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 20:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbXIWSF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbXIWSF5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 14:05:57 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:38628 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbXIWSF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 14:05:56 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1220314rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ID/DVJhoU0dbqqhnWwB4az9RmeodwsIVbDQb1dWjZtQ=;
        b=hLzlnZ+UOY69mQrp//EX3m2wbuJuR41pdAgSUNDda6g2N5JyXiMJzokf70jIy1mQIJDkDu9yfpPRhf47HJow41xnz+r/na5PkhgmpcimZyxbnEXAoaDMjSxWbSCA17/0izz8yDesK9xiL3CRH4wUUDddJTJ+rKWU/U9L+dOSZik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HHmW83HeJB/JWwPC8M69sZN8yyszgkGAjCoFi3mKohEs77CkERX0eTPMZcW/tciDp0b/O+bnY2CGchOUU2LvH71AQSJ7PFQHU8Y6lEDw0Vv97VkX/JXculI94KWWSRc8BX1NTaFoqyT/1Z9rmdCFQN8MbyJcuPJBJQ0D68b2iVA=
Received: by 10.141.171.6 with SMTP id y6mr1097027rvo.1190570755345;
        Sun, 23 Sep 2007 11:05:55 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 23 Sep 2007 11:05:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58972>

On 9/23/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> There are a few features of C++ that I really really like. For example, I
> think the C preprocessor is absolutely horrid, and a preprocessor that is
> built into the language - and integrates with the syntax - would be
> wonderful. And while C++ doesn't improve on that, at least templates are
> an example of something like that. Not perfect, but that's the kind of
> feature that C really would like.
>

Yes, I really agree. IMO templates are the thing that more resembles
procedural programming, a common way of using them is to split data
structures (containers) from functions that operates on them
(algorithms). I find them very similar to the struct + functions
classical approach of C.

And BTW

template <typename T>

is the thing in C++ that more remembers me of opaque pointers and
their use in C, the difference is that the first is fully type
checked.

Marco
