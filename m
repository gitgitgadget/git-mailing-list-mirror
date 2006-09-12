From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit segfaults after b237b00
Date: Tue, 12 Sep 2006 19:39:30 +0200
Message-ID: <e5bfff550609121039h1ef25bc8y25186c321d555b8e@mail.gmail.com>
References: <45068577.2020608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 19:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNCER-0004Sd-9F
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 19:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWILRjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 13:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWILRjc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 13:39:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:22984 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030294AbWILRjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 13:39:31 -0400
Received: by wr-out-0506.google.com with SMTP id i32so557687wra
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 10:39:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mkQgaeabCT4Zid3GB2MZAEKu2ZZTFEDswgq9QHaEL05xdqpkFuSTwvt2BLINKU0KNgAR6NSphM+U/f6u59snrHZDHCU5ezLDbhesYpqsFKXljLzzcKxmY8OXKYGK43Qy6m/5BREuyFXpNa3jxR1mwA9jL+2WeQ4ju2vvw6XsR5g=
Received: by 10.35.61.17 with SMTP id o17mr11291106pyk;
        Tue, 12 Sep 2006 10:39:30 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Tue, 12 Sep 2006 10:39:30 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <45068577.2020608@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26890>

Hi Andreas,

On 9/12/06, Andreas Ericsson <ae@op5.se> wrote:
> What subject says, really. Tried cold cache, hot cache, with and without
> qgit.dat, 3 different repos and 14 different repo-tips. Same result
> every time. A segfault before anything is drawn.
>

Sorry but I am not able to reproduce the bug here. Also from the trace I see
that the segfault happens in a part of code that has not been touched
by b237b00.
And that _should_  not segfault in any way.

The code there is the same of qgit-1.5.1 so perhaps could be some
platform related issue,
please write me Qt and gcc versions and processor used and, in case,
do a complete rebuild with also reconfiguration (autoreconf -i).

What about the current qgit HEAD  (6128112f36) , could you reproduce
the bug also there?

>From the trace I see the segfault occurs in main view constructor,
i.e. before to touch anything.
So it is not related to a particular repository.

> c++ is a scary thing to me,

C++ is really scary not because we don't understand the code, but
because we _think_ to understand what the code does ;-)

Principle of least surprise is not exactly one of the design
cornerstones of C++, at least for normal people sense of surprise.

>
> btw, kudos for a great tool.
>
Thanks to you for using it, and reporting bugs.

Any suggestion is very appreciated!

  Marco
