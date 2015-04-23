From: rupert thurner <rupert.thurner@gmail.com>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Wed, 22 Apr 2015 23:52:24 -0700 (PDT)
Message-ID: <cb23672d-75ba-40b9-abff-a7b2b6c5debb@googlegroups.com>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <20150416113505.GA30818@rhlx01.hs-esslingen.de>
 <20150416152849.GA30137@peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_29_1626112944.1429771944492"
Cc: peff@peff.net, git@vger.kernel.org, andi@lisas.de, 
	thomas.braun@virtuell-zuhause.de
To: msysgit@googlegroups.com
X-From: msysgit+bncBCBO3N6S34BRBKNN4KUQKGQEFVKU6IY@googlegroups.com Thu Apr 23 08:52:28 2015
Return-path: <msysgit+bncBCBO3N6S34BRBKNN4KUQKGQEFVKU6IY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f55.google.com ([209.85.213.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBO3N6S34BRBKNN4KUQKGQEFVKU6IY@googlegroups.com>)
	id 1YlAzq-0006PT-SL
	for gcvm-msysgit@m.gmane.org; Thu, 23 Apr 2015 08:52:27 +0200
Received: by yhl29 with SMTP id 29sf2318526yhl.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 22 Apr 2015 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=G8Urjw3ZoU5Vv5E4LFHJZRJaXuqgSjsFFh+kwmspMv0=;
        b=nqLyMjRPs2kKp+7JIMYOE061C80GLm/KtbI60EYpYu+WSR9R5BMb2+lSHt7MPjvwqq
         e+KhaldLI4uFkNyqzKSjA6/CNSuSzkHvE1JJggSguh4jx+njnDl23oEOL4Wv+4R/5iC8
         NGsk8t9eeBenveJ/9CjbJCYdPM9/I+7HgUGZbhf7YFDB5urgMBgg6DU29CENJuFcpjJi
         7uzhSsY0I9KRgkMWhcujH3SEpiJiKGvT1J/vHB6LBfcfpzFNNJr/REhfjOwyfZEAtb2o
         uqo+QX00WIohsyGR7l17pfUmjSBCd1r/M2VxK8N8v/moeRb7RvxryltFREX0dKIq9pvL
         fsDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=G8Urjw3ZoU5Vv5E4LFHJZRJaXuqgSjsFFh+kwmspMv0=;
        b=MUnFAjaPrLcd+BV0buCtEi8zy8V4g+fPyovh/YNUTCP6uIgHMAWuanxi/h877Ek9Qo
         Btz+s1rcDUnn4Kb0udLIXgzaA6ORyVG9JaEPx1CTgJQKR8IEJZz124M6/Jzl9CP+ThSU
         3SEluqnLMCceaJv7FlG/NJ2cbt0h8oIYPrgJ6Zd6o8GYHZzNa+iN5xYscZCgmsKUMo7e
         kNeY4rEXaGFqazJ2HJs/6GVC2hUDYE/5IDdgFl0Ryk/G3Ki9cBqjE6afoRBKNVs9AYw0
         UPPehARzlatgsmjyWzzGi7YAzuEmGjry/vkbBL/0uaqJu3KjCAFXUYgtAW5w1gnRxghQ
         +lWw==
X-Received: by 10.140.23.166 with SMTP id 35mr14717qgp.12.1429771946071;
        Wed, 22 Apr 2015 23:52:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.89.139 with SMTP id v11ls1053264qgd.84.gmail; Wed, 22 Apr
 2015 23:52:25 -0700 (PDT)
X-Received: by 10.140.106.181 with SMTP id e50mr13662qgf.29.1429771944991;
        Wed, 22 Apr 2015 23:52:24 -0700 (PDT)
In-Reply-To: <20150416152849.GA30137@peff.net>
X-Original-Sender: rupert.thurner@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267678>

------=_Part_29_1626112944.1429771944492
Content-Type: multipart/alternative; 
	boundary="----=_Part_30_1985847603.1429771944492"

------=_Part_30_1985847603.1429771944492
Content-Type: text/plain; charset=UTF-8

hi,

i made a screenshot a couple of weeks ago (attached), and it seems to match 
your description.

rupert.


On Thursday, April 16, 2015 at 5:28:54 PM UTC+2, Jeff King wrote:
>
> On Thu, Apr 16, 2015 at 01:35:05PM +0200, Andreas Mohr wrote: 
>
> > I strongly suspect that git's repacking implementation 
> > (probably unrelated to msysgit-specific deviations, 
> > IOW, git *core* handling) 
> > simply is buggy 
> > in that it may keep certain file descriptors open 
> > at least a certain time (depending on scope of implementation/objects!?) 
> > beyond having finished its operation (rename?). 
>
> Hrm. I do not see anything in builtin/fetch.c that closes the packfile 
> descriptors before running "gc --auto". So basically the sequence: 
>
>   1. Fetch performs actual fetch. It needs to open packfiles to do 
>      commit negotiation with other side (the hard work is done 
>      by an index-pack subprocess, but it is likely we have to access 
>      _some_ objects). 
>
>   2. The packfiles remain open and mmap'd (at least on Linux) in the 
>      sha1_file.c:packed_git list. 
>
>   3. We spawn "gc --auto" and wait for it to finish. While we are 
>      waiting, the descriptors are still open, but "gc --auto" will not be 
>      able to delete any packs. 
>
> But this seems too simple to be the problem, as it would mean that just 
> about any "gc --auto" that triggers a full repack would be a problem (so 
> anytime you have about 50 packs). But maybe the gc "autodetach" behavior 
> means it works racily. 
>
> I was able to set up the situation deterministically by running the 
> script below: 
>
> -- >8 -- 
> #!/bin/sh 
>
> # XXX tweak this setting as appropriate 
> PATH_TO_GIT_BUILD=$HOME/compile/git 
> PATH=$PATH_TO_GIT_BUILD/bin-wrappers:$PATH 
> rm -rf parent child 
>
> # make a parent/child where the child will have to access 
> # a packfile to fulfill another fetch 
> git init parent && 
> git -C parent commit --allow-empty -m base && 
> git clone parent child && 
> git -C parent commit --allow-empty -m extra && 
>
> # we want to make our base pack really big, because otherwise 
> # git will open/mmap/close it. So we must exceed core.packedgitlimit 
> cd child && 
> $PATH_TO_GIT_BUILD/test-genrandom foo 5000000 >file && 
> git add file && 
> git commit -m large file && 
> git repack -ad && 
> git config core.packedGitLimit 1M && 
>
> # now make some spare packs to bust the gc.autopacklimit 
> for i in 1 2 3 4 5; do 
>         git commit --allow-empty -m $i && 
>         git repack -d 
> done && 
> git config gc.autoPackLimit 3 && 
> git config gc.autoDetach false && 
> GIT_TRACE=1 git fetch 
> ``` 
>
> I also instrumented my (v1.9.5) git build like this: 
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c 
> index 025bc3e..fc99e5e 100644 
> --- a/builtin/fetch.c 
> +++ b/builtin/fetch.c 
> @@ -1174,6 +1174,12 @@ int cmd_fetch(int argc, const char **argv, const 
> char *prefix) 
>          list.strdup_strings = 1; 
>          string_list_clear(&list, 0); 
>   
> +        { 
> +                struct packed_git *p; 
> +                for (p = packed_git; p; p = p->next) 
> +                        trace_printf("pack %s has descriptor %d\n", 
> +                                     p->pack_name, p->pack_fd); 
> +        } 
>          run_command_v_opt(argv_gc_auto, RUN_GIT_CMD); 
>   
>          return result; 
> diff --git a/builtin/repack.c b/builtin/repack.c 
> index bb2314c..e8b29cf 100644 
> --- a/builtin/repack.c 
> +++ b/builtin/repack.c 
> @@ -105,6 +105,7 @@ static void remove_redundant_pack(const char 
> *dir_name, const char *base_name) 
>          for (i = 0; i < ARRAY_SIZE(exts); i++) { 
>                  strbuf_setlen(&buf, plen); 
>                  strbuf_addstr(&buf, exts[i]); 
> +                trace_printf("unlinking %s\n", buf.buf); 
>                  unlink(buf.buf); 
>          } 
>          strbuf_release(&buf); 
>
> to confirm what was happening (because of course on Linux it is 
> perfectly fine to delete the open file). If this does trigger the bug 
> for you, though, it should be obvious even without the trace calls. :) 
>
> -Peff 
>

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_30_1985847603.1429771944492
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi,<div><br></div><div>i made a screenshot a couple of wee=
ks ago (attached), and it seems to match your description.</div><div><br></=
div><div>rupert.</div><div><br><br>On Thursday, April 16, 2015 at 5:28:54 P=
M UTC+2, Jeff King wrote:<blockquote class=3D"gmail_quote" style=3D"margin:=
 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On Th=
u, Apr 16, 2015 at 01:35:05PM +0200, Andreas Mohr wrote:
<br>
<br>&gt; I strongly suspect that git's repacking implementation
<br>&gt; (probably unrelated to msysgit-specific deviations,
<br>&gt; IOW, git *core* handling)
<br>&gt; simply is buggy
<br>&gt; in that it may keep certain file descriptors open
<br>&gt; at least a certain time (depending on scope of implementation/obje=
cts!?)
<br>&gt; beyond having finished its operation (rename?).
<br>
<br>Hrm. I do not see anything in builtin/fetch.c that closes the packfile
<br>descriptors before running "gc --auto". So basically the sequence:
<br>
<br>&nbsp; 1. Fetch performs actual fetch. It needs to open packfiles to do
<br>&nbsp; &nbsp; &nbsp;commit negotiation with other side (the hard work i=
s done
<br>&nbsp; &nbsp; &nbsp;by an index-pack subprocess, but it is likely we ha=
ve to access
<br>&nbsp; &nbsp; &nbsp;_some_ objects).
<br>
<br>&nbsp; 2. The packfiles remain open and mmap'd (at least on Linux) in t=
he
<br>&nbsp; &nbsp; &nbsp;sha1_file.c:packed_git list.
<br>
<br>&nbsp; 3. We spawn "gc --auto" and wait for it to finish. While we are
<br>&nbsp; &nbsp; &nbsp;waiting, the descriptors are still open, but "gc --=
auto" will not be
<br>&nbsp; &nbsp; &nbsp;able to delete any packs.
<br>
<br>But this seems too simple to be the problem, as it would mean that just
<br>about any "gc --auto" that triggers a full repack would be a problem (s=
o
<br>anytime you have about 50 packs). But maybe the gc "autodetach" behavio=
r
<br>means it works racily.
<br>
<br>I was able to set up the situation deterministically by running the
<br>script below:
<br>
<br>-- &gt;8 --
<br>#!/bin/sh
<br>
<br># XXX tweak this setting as appropriate
<br>PATH_TO_GIT_BUILD=3D$HOME/<wbr>compile/git
<br>PATH=3D$PATH_TO_GIT_BUILD/bin-<wbr>wrappers:$PATH
<br>rm -rf parent child
<br>
<br># make a parent/child where the child will have to access
<br># a packfile to fulfill another fetch
<br>git init parent &amp;&amp;
<br>git -C parent commit --allow-empty -m base &amp;&amp;
<br>git clone parent child &amp;&amp;
<br>git -C parent commit --allow-empty -m extra &amp;&amp;
<br>
<br># we want to make our base pack really big, because otherwise
<br># git will open/mmap/close it. So we must exceed core.packedgitlimit
<br>cd child &amp;&amp;
<br>$PATH_TO_GIT_BUILD/test-<wbr>genrandom foo 5000000 &gt;file &amp;&amp;
<br>git add file &amp;&amp;
<br>git commit -m large file &amp;&amp;
<br>git repack -ad &amp;&amp;
<br>git config core.packedGitLimit 1M &amp;&amp;
<br>
<br># now make some spare packs to bust the gc.autopacklimit
<br>for i in 1 2 3 4 5; do
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;git commit --allow-empt=
y -m $i &amp;&amp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;git repack -d
<br>done &amp;&amp;
<br>git config gc.autoPackLimit 3 &amp;&amp;
<br>git config gc.autoDetach false &amp;&amp;
<br>GIT_TRACE=3D1 git fetch
<br>```
<br>
<br>I also instrumented my (v1.9.5) git build like this:
<br>
<br>diff --git a/builtin/fetch.c b/builtin/fetch.c
<br>index 025bc3e..fc99e5e 100644
<br>--- a/builtin/fetch.c
<br>+++ b/builtin/fetch.c
<br>@@ -1174,6 +1174,12 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;list.strdup_strin=
gs =3D 1;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;string_list_clear=
(&amp;<wbr>list, 0);
<br>&nbsp;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;struct packed_git *p;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;for (p =3D packed_git; p; p =3D p-&gt;next)
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<=
wbr>trace_printf("pack %s has descriptor %d\n",
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr>&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; p-&gt;pa=
ck_name, p-&gt;pack_fd);
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run_command_v_opt=
(<wbr>argv_gc_auto, RUN_GIT_CMD);
<br>&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return result;
<br>diff --git a/builtin/repack.c b/builtin/repack.c
<br>index bb2314c..e8b29cf 100644
<br>--- a/builtin/repack.c
<br>+++ b/builtin/repack.c
<br>@@ -105,6 +105,7 @@ static void remove_redundant_pack(const char *dir_n=
ame, const char *base_name)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (i =3D 0; i &=
lt; ARRAY_SIZE(exts); i++) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;strbuf_<wbr>setlen(&amp;buf, plen);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;strbuf_<wbr>addstr(&amp;buf, exts[i]);
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;trace_printf(<wbr>"unlinking %s\n", buf.buf);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unlink(buf.<wbr>buf);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;strbuf_release(&a=
mp;buf);
<br>
<br>to confirm what was happening (because of course on Linux it is
<br>perfectly fine to delete the open file). If this does trigger the bug
<br>for you, though, it should be obvious even without the trace calls. :)
<br>
<br>-Peff
<br></blockquote></div></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_30_1985847603.1429771944492--
------=_Part_29_1626112944.1429771944492
Content-Type: image/png; name=git-windows-locking-itself.png
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=git-windows-locking-itself.png
X-Attachment-Id: a9e87980-ca6a-4312-a66d-1e31b0ab27f5
Content-ID: <a9e87980-ca6a-4312-a66d-1e31b0ab27f5>

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
jxUAADSb/w/ghFG8+IZYzQAAAABJRU5ErkJggg==
------=_Part_29_1626112944.1429771944492--
