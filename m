From: Luke Lu <git@vicaya.com>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 00:17:08 -0700
Message-ID: <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:18:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3AD-00062c-59
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXJQHRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbXJQHRq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:17:46 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:56502 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbXJQHRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:17:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1665132rvb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=tC/tE/vdg6cycKQnan2dQEJc7tydofAJLm8e5PcFxcU=;
        b=b9+M7p+KOVi6K8KoO+e9fwKzSK2EojNSO2NNaQgGQZNl+MgFcIfGOE29AcNLPkYD2G8hdm/ddJ1FZiFD/caa/wKWSUa6Mj0dLOzv2zR2A1BqtqQPkdd+V/LV9d39eJArUO6aNMocuNljmflbXibqCpQMLURZ1KTuhzdN8awUquU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=qDREg3hNVjRiZ0QHJ54P7KciHTDW3JcwCSAAALV3WwVn0y1ydNnvmbORwGcvzYLBftNNmOgENyB/K7D6AeHHh3iFHdCFVcXn4p6drY6U90IC9Q6wvHJFhZuLGo+i3LlkX4zoUO0pXHSuM9m0sKb3xi8OJn+ADfJz1s7L924BLI8=
Received: by 10.140.139.3 with SMTP id m3mr4000654rvd.1192605464493;
        Wed, 17 Oct 2007 00:17:44 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id c20sm9623183rvf.2007.10.17.00.17.39
        (version=SSLv3 cipher=OTHER);
        Wed, 17 Oct 2007 00:17:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61343>

I'm late in this game. But it's too classic a debate to miss the fun.

On Oct 16, 2007, at 5:45 PM, Linus Torvalds wrote:
> One issue may well be that Windows programmers also probably don't  
> work
> very much with patches, do they?
>
> One reason for *really* wanting to use hard-tabs is that it makes  
> patches
> look better, exactly because diffs contain that one extra (or two,  
> in the
> case of old-style context diffs) character at the beginning of the  
> line.
>
> Which means that while all-space indents look fine, *mixing* styles
> definitely does not. In particular, a two-character indent (which
> hopefully nobody uses, but people are crazy) will be totally  
> unreadable as
> a patch if you have the (fairly common, at least in UNIX projects)  
> style
> of using spaces for less-than-eight-character-indents and tabs for the
> full 8 characters.

Yes, all-space would look fine in patches. It'll look better than all  
tabs for tables and ascii formula and diagrams in comments, as one  
prepended character could screw up the tabs (depending on the  
content), rendering them totally unreadable. In all-space case,  
things just shift to the right by one character column.

I believe the indentation convention for ruby is 2 spaces. It looks  
tight to me :)

> (In particular, a 3-level and 4-level indent will look *identical*  
> in such
> a project, when using context diffs).
>
> And sure, you can use all-spaces-everywhere, but that just isn't  
> what any
> normal UNIX editors are set up for by default. In contrast, under  
> UNIX, I
> can pretty much guarantee that hard-tab indents look at least  
> reasonable
> in any editor.

But all-space would look perfect in any editor as the authors  
intended, including the tables and ascii arts, as long as it's using  
monospace font. It's easy to setup all space editing on all platforms  
(Windows, Mac, *nix) It's also much easier to enforce. I've used pre- 
commit hook to check for tabs in the source and reject them if a tab  
is found :)

> And if you have an editor that shows hard-tabs as 4-character indents,
> generally you can work with it. You may have odd indentation, and  
> people
> may complain about your patches not lining up, and yes, it would be  
> up to
> *you* to understand that 8-wide tabs are the normal and default.  
> But you
> can certainly work with a source base that uses a single hard-tab for
> indentation.

> In contrast, if you use spaces (or worse - mixing), things really look
> ugly as sin, to the point of actually being unworkable.
>

Well, we just established that all-space is perfect, look-wise.

> In short:
>
>  - if the project has the rule that an indentation is "one hard- 
> tab", then
>    at least everybody can *work* with that project. Different  
> people may
>    see things laid out slightly differently, but it's generally not a
>    horrible disaster, especially if you aim to use block comments  
> indented
>    with the code (like we *mostly* do both in the kernel and in git)
>
>  - all-space and all-tabs just leads to problems. Yes, I know about
>    python, but lets face it, python is different, since the spacing  
> has
>    semantic rules there. Most non-python programmers will not use  
> editors
>    where you can obviously see the difference between spaces and  
> tabs, and
>    as a result an all-space model will *turn* into a mixed-space/tab
>    model, and you get horrible end results.

As I mentioned, an all-space policy is trivial to enforce.

>  - as per above, mixing spaces and tabs is a *horrid* idea.
>
>  - as a result, a "pure tab for indents" model tends to be workable in
>    most situations. It may not be ideal for you, but it's workable.
>
>  - and at least in the UNIX world, default for pure tabs really is 8
>    characters. Even if you have an editor that shows them as four,  
> you'll
>    see different results outside the editor (eg "grep -5 file.c"), so
>    people should just consider other tab sizes to be "secondary".
>
>    And as long as 99% of all git developers are under Linux, and  
> all the
>    core ones seem to have had no problem with the current tab rules, I
>    really don't see why that should change.
>
> See? Hard-tabs are good. Maybe Windows people don't ever see patches
> (perhaps they only see them as side-by-side graphical things), and  
> maybe
> windows projects are always done inside *one* environment where  
> there is
> no "grep" and "terminal TAB size" and "fifty different editors with
> different defaults".
>
> But even in DOS/Windows, hard-tabs seem to be quite common, judging by
> what little source code I've seen from Windows projects.
>
> And I just checked. The current git model seems to work fine if you  
> have
> an editor that thinks tabs are 4 spaces:
>
> 	sed 's/	/    /g' < revision.c  | less -S
>
> (that's a hard-tab in that first regex). No, things don't  
> necessarily line
> up just like they should, but you actually have to *look* for  
> problems to
> see them (ie stuff where people have added line-breaks).
>
> And is it really so unreasonable to just say "8-character tabs are the
> gold standard"?

But I still haven't seen any compelling arguments against the "all  
space" case, other than "people will screw it up into mixed spaces",  
which is really a straw man, as many multi-platform projects enforced  
the all-space policy easily by using a pre-commit hook in  
maintainers' repository.

The only downside of all-space is a moderate space bloat in source,  
which is insignificant, all things considered.

I agree that "8-character tabs are the gold standard", only for the  
tabstop==8 part but not the indent==tab part. For me the question is:  
is it really so unreasonable to just say "all-space is the holy grail"?

__Luke
