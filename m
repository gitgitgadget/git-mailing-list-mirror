From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 23:25:01 +0100
Message-ID: <3f4fd2640709231525q52a9865alc834ca46b85998fe@mail.gmail.com>
References: <877imishdp.fsf@catnip.gol.com>
	 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	 <20070923104525.GC7118@artemis.corp>
	 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	 <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
	 <20070923212239.GA7249@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"David Kastrup" <dak@gnu.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@nbs-eng.ru>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZZt0-0003sO-Bg
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbXIWWZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbXIWWZE
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:25:04 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:62122 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbXIWWZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:25:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1259601rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TrJyh42vngavV62WISxt2vbY0zPsPXqsHqR4JTbdn3I=;
        b=RoHEEc6j/0Pm8buYzd4kSI/Xo+RUf2PYr1eJx/j01BCs3ed5/LHDyG/IkPytvxOUoCZXzdAvCFXg6QBsdnq2SjlkFHsAQVeRsWE6QgjlHTvRp+FsmAZJSJcclhgUF6X3cVY2zK9xGgO1B+fQbhPj3eEqTDS4k0HuvHzibg3t5Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lwj4ywm9F2uhyhGw1Oy4MuHCbjqWUzLOiggzotRCcci5HSiEe3v8UfVoeLpvwRPxE4CtmLy/+u7vq47vBFayfCJ9nwYfAyUwiA3WkemBMMNdidm3TxFPLQpKdAMLodot+QEbw8zvv5eT4q48jEwL+38Df1hQ2NUh8aJ0lBZG2eU=
Received: by 10.141.50.17 with SMTP id c17mr1485436rvk.1190586301068;
        Sun, 23 Sep 2007 15:25:01 -0700 (PDT)
Received: by 10.141.23.10 with HTTP; Sun, 23 Sep 2007 15:25:01 -0700 (PDT)
In-Reply-To: <20070923212239.GA7249@potapov>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58989>

On 23/09/2007, Dmitry Potapov <dpotapov@nbs-eng.ru> wrote:
> On Sun, Sep 23, 2007 at 09:54:10AM -0700, Linus Torvalds wrote:
> > The same goes for things like memory allocation. Memory allocation issues
> > are often some of the *biggest* performance issues, and that means that
> > they have to be explicit. I'm actually a big fan of GC, but most languages
> > that implement GC do it exactly the wrong way in my opinion: they make it
> > a fundamental thing that covers everything, and it all happens implicitly,
> > instead of making it explicit.
>
> Stroustrup was not a big fan of GC, so he made the language to be useful
> in absence of any GC, and it allows to manage memory and some other
> resources though not automatically, but with much less efforts than in C.

The next version of C++ is going to have garbage collection that the
user can enable, disable or remain neutral about. However, this is
program-wide and has many traps that you could fall into.

> > But other parts of C++ are just nasty. The whole OO layer seems designed
> > to do a lot of things implicitly and in the wrong way.
>
> It could do a lot of things implicitly, but it does not force you,
> except calling destructor when the control leaves the scope of
> declaration, but I hardly can consider it as implicit.

You have to add the explicit keyword to any constructor to prevent an
automatic conversion. Therefore, the constructors that are called are
implicit by default. If you have a conversion operator, this is always
implicitly called when there is a match by the compiler.

I agree with Linus here, there are a lot of things that happen implicily.

> > I also disagree with exception handling,
>
> Perhaps, you look at it from the kernel point of view. Otherwise, I
> would like to hear your arguments against it. In fact, I don't think
> it is possible to write generic algorithms without exceptions. Of
> course, if you write a program that can print an error to stderr and
> exit, there is no much need for them. So, it may depend on the task.

There are many issues with exceptions.

Firstly, there is throwing an exception from a destructor, which is
warned against in any good C++ book, but does not prevent you from
doing so (even if it is inadvertantly)! If the program is in the
process of handling an exception, the program is toast.

More importantly though, is the loss of contextual information.
Consider throwing the same exception on all calls to API that return
the same error code type. The code that processes this may be anywhere
in the system. This makes it impossible to do any sensible recovery
(if possible), or error reporting. The exception can be rethrown or
translated to another exception, making it impossible to find the
originator of the exception. This makes it harder, if not impossible,
to track the exception back to the source when you are at a breakpoint
in the exception handler.

Then there is dealing with caller boundaries. That is, when a callback
or interface function in the application will return to the operating
system (e.g. when handling a draw request from X11), or another
language such as Python. Also, because different compiler vendors and
versions handle exceptions differently, if you want to support
different compilers (and you have resolved the name mangling
incompatibilities), you need to handle exceptions correctly in these
cases, or risk having major problems that would be impossible to
trace. Not to mention that anywhere new, dynamic_cast and other
language features are used may throw exceptions.

- Reece
