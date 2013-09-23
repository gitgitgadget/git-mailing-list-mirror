From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Mon, 23 Sep 2013 13:17:30 -0500
Message-ID: <524085ba39049_3a6f81e84193b3@nysa.mail>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
 <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
 <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
 <CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOAwZ-0006kW-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab3IWSdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:33:07 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46232 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3IWSdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:33:05 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so941556oag.19
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=CNuQ7tc0uqp1x+DOfkP9AvnllRps/wL8qT1Yql3WRMw=;
        b=F2SHTrqspF68GclEmMAePx2YNpySmjPsdJdIQES1r1OTjh7U6vvDXa3eXizRfP5YHg
         Xcd+Olr9WEG3ci5oZD+CVsnCrMkwON8C5XvPND21ssX0MExR+7D2zyOjbUhKzxl/6TPz
         g1cYZ5/D3aul1S7H05K7Gb6x8DI3mYAXDRzMryI3zv0mrrWCXmBG7NewdLlNWAaHGICq
         Abp/ygMEzO8MWy2DhJSmwBoVYn3LuworunQBx/IoIilwlqPqubK5OqUXurDz7jBBpBI/
         hUI1YKdKIvNiCrcYIs8tPfneYhLYAgh5fArro3OPjMquNT32lhnA5L/yox9xQTCCAi4O
         9bEQ==
X-Received: by 10.182.75.201 with SMTP id e9mr7614785obw.28.1379961184283;
        Mon, 23 Sep 2013 11:33:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm15151450obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 11:33:03 -0700 (PDT)
In-Reply-To: <CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235214>

Junio C Hamano wrote:
> [on vacaion, with only gmail webmail UI; please excuse me if this message comes
> out badly formatted or gets dropped by vger.kernel.org]
> 
> On Sat, Sep 21, 2013 at 4:56 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Sat, Sep 21, 2013 at 05:52:05PM -0500, Felipe Contreras wrote:
> >> On Sat, Sep 21, 2013 at 4:29 PM, brian m. carlson
> >> <sandals@crustytoothpaste.net> wrote:
> >> > As Junio has also pointed out in the past, there are people who aren't
> >> > able to use Ruby in the same way that they are Perl and Python.  If it's
> >> > announced now, Git 2.0 might be a good time to start accepting Ruby
> >> > scripts, as that will give people time to plan for its inclusion.
> 
> In the very beginning, the codebase and development community of Git was
> very small. In order to give usability and also easy availability of minimally
> sufficient features, we used shell and Perl for quicker turn-around and
> implementation and included these Porcelain scripts written in higher level
> languages in the same package as the core Git.
> 
> We should look at use of shell and Perl as necessary evil in that context,
> not as an enabler for people who do not want to write in C. It is no longer
> 2005 and the "enabler" side has a much more suited project for it these days.
> 
> Namely, it is better served by various language-binding efforts around libgit2.
> Binding that takes advantage of each specific language is better done over
> there, I think. Cf. http://www.youtube.com/watch?v=4ZWqr6iih3s

If libgit2 is so good as a library to interact with Git repositories, why isn't
Git using it?

Because it's not. It is a necessary evil due to the fact that Git developers
neglected to write code in a reusable manner so other people could utilize
libgit. So somebody else had to step up, so now we have two code-bases.

> If anything, I think the core side should be focused on three things
> (in addition
> to bug-fixes, of course) in the longer term:
> 
>  - Defining and implementing necessary improvements to the core on-file and
>    on-the-wire data structures and the protocols to serve as the canonical
>    implementation.
> 
>  - Moving away from higher-level scripting languages such as shell and Perl.
>    Recent "clean --interactive" may have added some code that could be
>    reused for a rewrite of "add -i" (which I think is in Perl), for example.
>    The minimum "You need to have these to use Git" should be made more
>    portable by doing *less* in shell or Perl, not by adding more in the higher-
>    level languages, and certainly not by adding other languages, be it Ruby or
>    Lua.
> 
>  - Giving solid interface to the outside world, e.g. remote-helpers, credential-
>    helpers API, and let the users and developers that want to use them do their
>    own projects, without adding things to contrib/.

It's interesting how none of these goals reflect what the users want:

https://www.survs.com/results/QPESOB10/ME8UTHXM4M

1. Better user-interface
2. Better documentation
3. GUI tools

Do you deny this is what users want? Or you just don't care?

I'm not trying to antagonize you, I just truly don't understand how something
so obvious for so many users just doesn't even factor into your decision making
as what needs to be done.

> In other words, now the Git user and developer community are strong
> and thriving,
> we should strive to make the core smaller, not larger, and encourage people to
> form more third party communities that specialise in the areas the
> participant of
> these communities are stronger than those who are involved in the core
> (e.g. like
> myself, Peff, Nico, Jonathan, etc.). For programs that talk remote-helper or
> credential-helper protocols, for example, it is wasteful to have them
> in our contrib/
> and have the changes to them go through my tree, with the same coding style
> standard applied to the core, which would in the longer term only add
> unnecessary overhead to what they want to do and what their effort supply the
> users with.

Of course, we can make the core smaller, by replacing all the perl/shell
scripts with ruby ones.

Sure, it would be better if all the scripts were rewritten in C, but that has
been going on for years, and there's no end in sight, and not that much
progress at all.

So, it's fair to say that the rewrite to C is just not going to happen any time
soon, and if we accept that, we should accept that an interim solution is
needed, because Windows users are important and they are hurting right now, and
that solution could definitely be Ruby.

Rewriting scripts to C is hard, rewriting them to Ruby is easy, and one of the
advantages of rewriting to Ruby, is that having the C->Ruby bindings available
would make it easy to replace part of the scripts chunk by chunk, so we could
have a half Ruby, half C script, and eventually 100% C.

This is a practical solution, it's a realistic path to move forward, not one
based on wishful thinking and intentions that never get realized.

Once again, the perfect being the enemy of the good in the Git project, even
when the good leads to perfect.

-- 
Felipe Contreras
