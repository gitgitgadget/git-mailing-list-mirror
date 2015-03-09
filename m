From: Scott Chacon <schacon@gmail.com>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 10:52:34 -0700
Message-ID: <CAP2yMaJWLppUw2QY3rL7dZPaqVUf6G-UYVrvi35A_t03ow6E_w@mail.gmail.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
 <87y4n6kvdu.fsf@fencepost.gnu.org> <CAJo=hJt_PHMEdpfRA0EKQyoH4XhYh89tvajewM28pgxzZ9ONMg@mail.gmail.com>
 <87twxuktzc.fsf@fencepost.gnu.org> <CAP8UFD1y86wqg5fpRn1wsMnn8JT9KXuDMgzcseH=sv8NBWO6wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV1rQ-0001Wb-EX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 18:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbCIRw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 13:52:56 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:41523 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbbCIRwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 13:52:55 -0400
Received: by oiav63 with SMTP id v63so30839544oia.8
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SnMLju2KMcamfeTYRkzgy9bWSstvCStg4oBVfNKahCs=;
        b=ypphdD3nwJ81YiRak0DvS0vrhLdyjoWnZcRM3HzHKmpFIUpeWqqXnwYRXfGeIydhbm
         IgU3fLOiPeYLrNOTmMw3pZ632/1Sr2p80Ujz9Uj54hkSC726/iqZ6eYuRu7xymHumlVS
         94LqcTdkoN7A65mRFcXJ/vutoChUnovFQHqdIxPmN0JBbxZ3EgSSLsyJIoQfgdG52qG7
         r2tD/2vALxED1rNtHKVWEr9lwQaI8mJtUFNKqTWd4OMVs2EPZ53zP8yNz1eplc9ABCUU
         l6flYiU8Hjkk+Z0IvTFRR6LYH/tJ4jHmvq7ij8qauVxKjrIIyotI3Qj473GPQhB8GWRO
         vdGA==
X-Received: by 10.202.79.23 with SMTP id d23mr21402682oib.45.1425923574554;
 Mon, 09 Mar 2015 10:52:54 -0700 (PDT)
Received: by 10.182.220.8 with HTTP; Mon, 9 Mar 2015 10:52:34 -0700 (PDT)
In-Reply-To: <CAP8UFD1y86wqg5fpRn1wsMnn8JT9KXuDMgzcseH=sv8NBWO6wA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265185>

Hey,

On Mon, Mar 9, 2015 at 10:12 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> A few other points about git-scm.com:
>
> * as Michael says it "still looks a bit like a ProGit/Github promotion site"
>
> * some of the pull request can be rejected even if the developers want
> them, like this pull request to add back a list of contributors was:
>
> https://github.com/git/git-scm.com/pull/216
>
> (By the way this pull request talks about bugs in
> https://github.com/git/git/graphs/contributors that are still not
> fixed...)
>

It should be noted that Peff has write access to this repository and I
think the SFC manages the DNS for the site as well, so technically it
is maintained "by us". If he had felt strongly about the addition, I
easily could have been convinced to do it, but I didn't think it was
helpful in a larger sense.

I try very hard to maintain a balance of simplicity and function. This
site is mostly for people new to the project - it helps them see what
Git is for, how to use it well and how to get involved. If you put
everything you can into the site it makes it harder to find other
things that may be more important.

It's also important to remember that a home page is not really
primarily for the people in this list. It's for the people who may one
day be interested in this list and for the far greater number of
people who want to use the end result of the hard work of the people
on this list. It hopefully reduces the support and explanation style
questions that might otherwise be sent to this list by helping to
explain things before people resort to asking you all. It's meant to
be a tool shielding you all from the introductory questions that would
otherwise probably just annoy you.

That all said, if someone is interested in helping with the
maintenance and going over these pull requests, I'm more than happy to
give them access, but I really want to maintain the simplicity and
professional sense of design that we've worked very hard to maintain.
Not every patch that works that comes to Junio is accepted and not
every pull request that comes into the site will be merged for the
same reason - we want to maintain the quality and utility of the
resource. There have been 157 merged pull requests from the community
in the past year or so, 13 of which were from the author you're
mentioning in this example. You pointed to the one pull request out of
14 total patches from Peff that was not merged.

> It is kind of strange to say that we should contribute to a web site
> that promotes ProGit and GitHub a lot and where our contributions can
> be rejected because it is not maintained by us.

Again, if you can point to a GitHub logo on any page of the website, I
would love to see it. And Pro Git is free and read by hundreds of
thousands of people day all over the world and available in dozens of
languages in multiple ebook formats. I would remove the Amazon links
if anyone wishes, but the SFC gets income from it, so I doubt they
would want to.

Scott
