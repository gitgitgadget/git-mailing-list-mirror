From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 17:54:17 +0200
Message-ID: <CAGK7Mr74TK4x7WYnmWyRUj_Aga0CHbyFNyZGZdu6eubtwahBXg@mail.gmail.com>
References: <5358bae8ab550_1f7b143d31037@nysa.notmuch> <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch> <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch> <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch> <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org> <CAGK7Mr4g3j80R4P_wpfNip9vxvaDg4q_3Utq9KVvKtbdhVutfQ@mail.gmail.com>
 <20140425144054.GA6230@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:54:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdiSk-00064c-96
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbaDYPyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:54:49 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56326 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaDYPys (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 11:54:48 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so4503403obc.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rqAh9S+kO+px+8rJXeY51P5S/RKz4OXUtmpZfAQcgOo=;
        b=AOo1odV0kGqJ3x81c4kbVzTFf3Ih8ywQsMPphcyHfz3MSVojWTThf8DuXCubQCYhbE
         CqEE1vIOYmXfWRpSxz6zSnfxtUjTMJlX47grbtOjPeMKZpJ/nGdAVIBV8QzFuAq71aQL
         J3OttDQ1lDxNScGgFWVG6lOwfIpdZktZqWVIip64rpJ1QWHuqM4N8z72ja7g5kd7gXQj
         W8P82AynvPaih0wkQ5Tnkzck9FmQ3+nGv22f8UBdzCQeZ8A7t82Vyg6Ar1U5BYkdryf+
         ZQHM94iUAJ98H/X1b0eY4I+EgK4TrIROW+Rzp97HRbtBVprAzdP3qbFd2kqroIutN25Q
         6U7Q==
X-Received: by 10.60.117.229 with SMTP id kh5mr3396070oeb.19.1398441287838;
 Fri, 25 Apr 2014 08:54:47 -0700 (PDT)
Received: by 10.76.85.229 with HTTP; Fri, 25 Apr 2014 08:54:17 -0700 (PDT)
In-Reply-To: <20140425144054.GA6230@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247048>

>> Yes, of course there should be a list of both positive and negative
>> tradeoffs. But I think the "overloaded" argument can be easily solved
>> by renaming one of the overloads.
>
> And renaming one of a term also has costs, especially if it is one
> that is in use in large amounts of documentation, both in the git man
> pages, and in web pages across the web.

It's just impossible to change terms and have previous documentation
still be valid. Sure, you can list it in the "cons" section as an
argument, but it's not very convincing in itself because it applies to
pretty much any interface changes. I think the main idea is to
_improve_ the interface, which means rename things so it is more
consistent and so concepts are easier for new comers to grasp. We
could still support old terms for a while and eventually deprecate
them.


> www.google.com/trends/explore#q=git%20staging%20area%2C%20git%20index&cmpt=q

I think this comparison is a bit bogus, searching for "git stage"
yields more accurate results, we can see the searches are related:

http://www.google.com/trends/explore#q=git%20staging%20area%2C%20git%20index%2C%20git%20stage&cmpt=q


>> Unfortunately yes, I see many people being silly in order to win
>> arguments, both in the pro-changes and against-changes side of the
>> discussion. I'd be much simpler to simply gather arguments on some
>> wiki and eventually do a vote when the list is complete about the
>> proposed change.
>
> Voting is not a good way to do software development.  That way lies
> people wanting to whip up clueless folks using rhetoric (exhibit one:
> Fox News) to "vote" and so it's not necessarily the best way to make
> thoughtful decisions.  Using hard data, including possibly formal UX
> experiments, is a much better way to make such decisions.

Interesting, but then who's to say which data is more important than
anothers? For example, I consider improving the interface to be more
important than having old documentation on blogs/tutorial for a while
until people catch up, but maybe you consider old documentation to be
more important... who decides what really counts? I guess it's a mix
of general consensus and old timers credibility.

Anyway, having some data as a list of pros/cons would greatly simplify
the debate.

Philippe
