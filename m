From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sat, 19 May 2012 11:14:09 +0100
Organization: OPDS
Message-ID: <C03B8CAB76CA449FB887C5430FDAA470@PhilipOakley>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com> <vpqehqxmwpj.fsf@bauges.imag.fr> <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com> <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com> <7v1umv7ub0.fsf@alter.siamese.dyndns.org> <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com> <20120519060031.GB23799@burratino>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?B?xnZhciBBcm5mavZy8A==?= <avarab@gmail.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	"Scott Chacon" <schacon@gmail.com>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Piotr Krukowiecki" <piotr.krukowiecki.news@gmail.com>
To: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Mark Lodato" <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 12:14:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVgfs-0007hN-4M
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 12:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab2ESKOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 06:14:07 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:10594 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754981Ab2ESKOF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 06:14:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqwNABxyt09Z8rS7/2dsb2JhbABFinSndwEBAoEbgQiCEAUBAQQBCAEBLh4BARwFBQYCAwUCAQMOBwECCSUUAQQIEgYHFwYBEggCAQIDAYdvAwYJsmMNiVKKFm8fHB0FKINmYgOID4UvklSEeYJqgVY
X-IronPort-AV: E=Sophos;i="4.75,622,1330905600"; 
   d="scan'208";a="372494045"
Received: from host-89-242-180-187.as13285.net (HELO PhilipOakley) ([89.242.180.187])
  by out1.ip04ir2.opaltelecom.net with SMTP; 19 May 2012 11:14:01 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198028>

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Saturday, May 19, 2012 7:00 AM
> Hi Mark,
>
> Mark Lodato wrote:
>
>> I agree with Felipe that "staging" is the most appropriate term for
>> "adding to the index" in git.  As a native English speaker, I have
>> never thought of "to stage" as relating to shipping in any way.  To
>> me, by far the most common usage is in real estate.  The seller of a
>> home "stages" it by setting up furniture and decorations to make the
>> home as appealing to prospective buyers as possible.
>
> I think staging a home does not fit very well here, actually.  As you
> said, staging a home is like staging a play, creating an illusion and
> putting on a production.  It is not obvious how this concept would
> help me understand what it means to add content to the index.
>
> By contrast, if you run an image search for "staging area", you will
> see examples in all sorts of fields --- shipping, military logistics,
> data warehousing, disaster relief.  It is a familiar, non
> domain-specific term for native English speakers.  In all these
> fields, staging means to put everything needed in one place before
> deploying.  This matches the concept of a file that tracks the content
> of the commit being prepared very well.

Agreed. (both sentences)
It's about making it up as you go along. (1: it = the commit ;-)
In particular it's about the 'area' (noun) that we use for that 
preparation.
Unfortunately there are no common terms because every industry, and
language, came up with its own terminology. To assist translation, we
should avoid being too concise in the explanation, while being 
consistent
with our base terms.

>
> "aire de rassemblement" doesn't get as many hits from a web search,
> alas, so I guess the idiom is not as popular in other languages.
>
> For the sake of having a proposal: :)
>
> - the file representing the content of the next command would still
>   be called .git/index and not be renamed
>
> - adding and removing content to and from the index is "staging a
>   change".  Since it is not safe to assume the reader already
>   knows what that means, when working on the manual authors should
>   try to imagine themselves as a new user and make the text
>   unambiguous enough to help such a person.
>
>   For example, the first sentence of the "git add" manual:
>
> This command updates the index using the current content found in the
> working tree, to prepare the content staged for the next commit.
>
>   should not be changed to:
>
> This command updates the staging area using ...
>
>   because that just makes it less clear.  Before, it said "the index"
>   and I could look in the glossary or the .git directory to at least
>   find what file it was talking about.  Afterwards, it is using an
>   everyday term and the new user wonders "which staging area?".
>
>   Instead, it would be better to change it to something like:
>
> This command modifies the content staged for the next commit
> using content found in the working tree.  It typically adds ...
>
> The "index" file (see gitindex(5)) typically holds a snapshot of
> the content of the working tree, and it is this snapshot that is

This line, if it is a carry on from the previous, also suffers the same
confusion. The index file by itself does not have any of the content. We
need to say in some way that - The 'staging area' has the content, and
is indexed by the index file. The staging area content itself is held
securely in the object storage ready for the commit.

> taken as the content of the next commit.  Thus after making any
> changes to the working directory, and before running the commit
> command, you must use the add command to add any new or modified
> files.
>
> Sensible?  If so, patches welcome. :)  If not, what sort of changes
> would you like to see instead?
>
> By the way, I don't mean that "the .git/index file will not be
> renamed" above to be non-negotiable.  I didn't get the impression
> anyone wanted it to be renamed, but if someone does want to rename it
> to .git/staging-area, then I suppose we could discuss that.

I'd agree. The file is an index.

>
> Hope that helps,
> Jonathan
> --

Philip
