From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 18:41:28 +0200
Message-ID: <F1CD811C-E625-4792-8341-7FA2A13E61AE@wincent.com>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com> <20090507072326.GA13123@vidovic> <7veiv0cvdt.fsf@alter.siamese.dyndns.org> <20090508042814.GA30031@vidovic> <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com> <20090514160609.GA12910@vidovic> <7vvdnvtf2n.fsf@alter.siamese.dyndns.org> <20090521041529.GD8091@sigill.intra.peff.net> <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com> <20090521131802.GA13840@vidovic> <94a0d4530905210847o697dd1f9w2f6ffcb8a109f0ca@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:41:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7BL0-0004ri-V8
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 18:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbZEUQlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 12:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZEUQli
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 12:41:38 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:35387 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbZEUQlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 12:41:37 -0400
Received: from cuzco.lan (156.pool85-53-12.dynamic.orange.es [85.53.12.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n4LGfSKB015560
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 21 May 2009 12:41:30 -0400
In-Reply-To: <94a0d4530905210847o697dd1f9w2f6ffcb8a109f0ca@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119698>

El 21/5/2009, a las 17:47, Felipe Contreras escribi=F3:

> On Thu, May 21, 2009 at 4:18 PM, Nicolas Sebrecht <nicolas.s.dev@gmx.=
fr=20
> > wrote:
>> The 21/05/09, Felipe Contreras wrote:
>>> On Thu, May 21, 2009 at 7:15 AM, Jeff King <peff@peff.net> wrote:
>>
> Not all branch names are equal; "master" is not the same as
> "mybranch". "master" has a special meaning, therefore it should be in
> monospace, but "mybranch" is simply a branch name, therefore it shoul=
d
> be emphazied. If the branch name is complicated you might want to
> delimit it with double quotes: "my-fooish-bar-branch", at least the
> first time you mention it.
>
> File names is a similar story; ".gitignore" is not the same as =20
> "test.c".
>
>>> Have you actually looked at the end result?
>>
>> Yes, I think it's much better with your patch but "display-types" =20
>> should
>> follow the same rules all over the text.
>
> I disagree. There are no absolutes when writing human-readable =20
> documents.

It is human-readable, but for the purposes of this discussion it is =20
much more relevant that it is a _technical_ document.

All good technical documentation that I've seen adheres to consistent =20
standards for display types. A "how to read this book" section in =20
which the formatting of the different types appears is extremely =20
widespread, standard practice.

Here's a very brief sampling for you:

http://svnbook.red-bean.com/nightly/en/svn.preface.conventions.html
"Conventions used in this book", from the SVN Book

http://www.freebsd.org/doc/en/books/handbook/book-preface.html
"Conventions used in this book", from the FreeBSD Handbook

http://oreilly.com/catalog/debian/chapter/book/prf1_02.html
"Conventions used in this book", from O'Reilly's "Learning Debian" book

If you're interested, a Google search for "Conventions used in this =20
book" will net you about 58,000 results to persuse.

Not only are people used to understanding texts written using this =20
kind of guideline, but it makes it easier for contributors as well if =20
their a clear-cut conventions for different display types. They =20
obviate the need for you to explain your reasoning about why "master" =20
is somehow different from "mybranch", and why it should be formatted =20
differently etc.

Cheers,
Wincent
