From: Scott Chacon <schacon@gmail.com>
Subject: Re: git-scm.com refresh
Date: Sat, 5 May 2012 20:51:07 -0700
Message-ID: <CAP2yMaJwT6=hEwt+v2OHB8yDdXQzV2P1kAimkN_a6GHtqkRJkQ@mail.gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <7vd36j8lc3.fsf@alter.siamese.dyndns.org> <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
 <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 06 05:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQsVt-00046v-PC
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 05:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab2EFDv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 23:51:29 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47777 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab2EFDv2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 23:51:28 -0400
Received: by qcro28 with SMTP id o28so1335081qcr.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gCeHBc8oVzzq/ya0Q7+/yYHx7eSZflh+EZak4XvSh2I=;
        b=rAld4jHYNkv2+HGncFFnLSGtoaFKcfIatGdhzwWA/lalwuBbBtIPB5iSg4fxHSrIq7
         7U7JzauA2q3koo1ss8/q7AXsDa1Rm/EUplD7NAZNUp0B05KDD+2n54eAvaskvssoORrK
         BcmIY3u81qv5Fqa2u9adus4lZWIHFZ0h15AqNIV0CkwEckGBhQWiOR+N2WRvheSJS3mk
         RiIvjYDGRZgUiEUAlEEGIR//MKSe7uj7mozjI85xre2sWfOdDVzYF58qSk3LCfg6RuId
         O5oDKxcyVIRc7lbNcJcQZJcwokgzg4Ds/1K8OvUdyVJylC62yYBjZ9AGhyIaPFWXDawO
         eLlw==
Received: by 10.224.73.77 with SMTP id p13mr18223031qaj.17.1336276287868; Sat,
 05 May 2012 20:51:27 -0700 (PDT)
Received: by 10.229.251.142 with HTTP; Sat, 5 May 2012 20:51:07 -0700 (PDT)
In-Reply-To: <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197145>

On Sat, May 5, 2012 at 6:39 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Scott Chacon <schacon@gmail.com> writes:
>
>>> As "diff" is listed in "Basic Snapshotting", and it will not
>>> be able to achieve that without being able to apply its output back=
 to the
>>> working tree or to the index, I would suggest moving "apply" to the
>>> section as well.
>>
>> I have to disagree. =C2=A0You are thinking of 'apply' from an intern=
als
>> perspective I have to assume, because I use 'diff' every single day
>> for all sorts of stuff ("what is modified and unstaged?", "what is
>> modified and staged?", "what is different between these two branches=
?"
>> etc) ...
>
> The other day when I was surfing the 'net, I found a blog that was
> complaining about Git UI. =C2=A0Some of the things were worth listeni=
ng to, but
> there was one item I really had to scratch my head where the misconce=
ption
> behind the complaint came from. =C2=A0I am typing from memory without=
 bothering
> to go back to the site to quote, but the complaint essentially was:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Getting a patch is easy with "git diff", b=
ut to apply it you need
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to make it an email and feed it to "git am=
"??? =C2=A0That's crazy.
>
> Of course it *is* crazy, if that were the case. I was wondering why t=
he
> obvious "patch" (or "git apply") did not get into the mind of the aut=
hor,
> and I think I now know why.

You think he doesn't know about 'git apply' because I'm not listing it
under Basic Snapshotting in the site I put live yesterday?  Or because
I'm not teaching that?  That makes no sense, I don't understand why
you think I'm to blame for this guy not knowing that.  If anything,
this new grouping will help that, since it clearly puts 'apply' under
a section explicitly labeled 'Patching'.  It doesn't belong in "Basic
Snapshotting" because that's not at all what it's used for and it
doesn't make sense to put 'diff' under 'Patching' because that's not
it's primary use case - it is mainly used to see what differences are
in various cases, not to create patch files.

> If the owner of the site that people call "git's home page" does not =
care
> about those who take diffs and apply them as patches, and thinks "git
> apply" as a mere implementation detail of "git am", it is understanda=
ble
> that such a misconception is spread widely to harm users without gett=
ing
> corrected. Who knows other Git fanboys are spreading misinformation i=
n a
> similar way. Sigh...

=46or one, it's not that I don't care, it's that I don't think that how
you're considering the problem set here is common.  I'm trying to make
Git a little bit easier to approach by grouping many of the commands
into groups by the problems they are primarily used to address.  If
you can argue that 'diff' is *primarily* used to create patch files
for 'apply' to consume, then I would be happy to argue that, but
that's not what you're saying.  You're ignoring my argument that I
believe that 'diff' is used primarily for another use case and that
that use case is closer to 'status' then to 'apply'.

>> ... where I can't think of a single time I've ever used 'apply'. =C2=
=A0In
>> fact, even the times when I have needed to apply a patch generated
>> from 'diff' I used 'patch -p1' because I know it better.
>
> As you are supposed to be one of the top-level Git Teachers, I wish y=
ou
> knew better. =C2=A0Here is a free Git lesson. =C2=A0Consider "git app=
ly" as
>
> =C2=A0 =C2=A0a better version of "patch" that knows how to work bette=
r with Git by
> =C2=A0 =C2=A0understanding rename and binary patches, and allows them=
 to be applied
> =C2=A0 =C2=A0to the working tree and the index (the latter is most us=
eful when the
> =C2=A0 =C2=A0patch contains new files)
>
> and teach it as such.

There is absolutely no reason to be this condescending.  You can read
a similar description of 'apply' in the context of applying patches
produced by 'diff' in my book which is CC licensed and now makes up a
large part of the git-scm.com site here:

http://git-scm.com/book/en/Distributed-Git-Maintaining-a-Project#Applyi=
ng-Patches-from-E-mail

It is also one of the top results when searching for 'apply' on the
site and it is cross-linked from the git-apply manpage in the sidebar.
 It's difficult for me to see how this can be made more clear by me on
this site.

>
> "diff" pairs with "apply", and "format-patch" pairs with "am".
>

If you read on through the next paragraph in that book you will see
this covered as well, as a slightly different use case where the
contributor used 'format-patch' instead.

Or, if you wish, you can read it in German, Japanese, French, Dutch,
Russian, Chinese or Spanish - the languages that have fully translated
my book and are also available on the site.  It's difficult to see why
you think I'm making this perceived issue worse.

> I wouldn't mind adding "git patch" as a built-in synonym/alias for "g=
it
> apply", if you think that would make the above pairing more obvious. =
=C2=A0Many
> computer users know what "patch" does already even they have never us=
ed
> any SCM.

I don't think this is a good idea at all and I've never advocated
this.  If people know what GNU 'patch' is they can use that, if people
glance at the new git-scm.com site they should be able to easily see
'git apply'  listed under other patch-y workflow tools.  What would be
far easier would be for me to simply list 'diff' under both sections,
since what we're really struggling with is the multiple use cases of
the 'diff' command.  I think I'll just do that, OK?

Scott
