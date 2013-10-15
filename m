From: wwiser@gmail.com
Subject: Re: Same test-path-utils behaves differently on different
 Windows systems
Date: Tue, 15 Oct 2013 07:54:57 -0700 (PDT)
Message-ID: <1a6eb0b0-3448-45e7-ab8b-95379202ddf4@googlegroups.com>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_209_20052282.1381848897184"
Cc: worldhello.net@gmail.com, Johannes Sixt <j6t@kdbg.org>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Git Mailing List <git@vger.kernel.org>
To: msysgit@googlegroups.com
X-From: msysgit+bncBDQO5Z6QAEIOXMHVSICRUBEQWGXA6@googlegroups.com Tue Oct 15 16:59:59 2013
Return-path: <msysgit+bncBDQO5Z6QAEIOXMHVSICRUBEQWGXA6@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f190.google.com ([209.85.214.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDQO5Z6QAEIOXMHVSICRUBEQWGXA6@googlegroups.com>)
	id 1VW66I-0008Q8-1y
	for gcvm-msysgit@m.gmane.org; Tue, 15 Oct 2013 16:59:58 +0200
Received: by mail-ob0-f190.google.com with SMTP id va2sf170143obc.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Oct 2013 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=4glNhrl883VPfkJpiIk8AcjCTIH3aAawekx6KlgLDFg=;
        b=lP86MlWKK6NBETpyQBXQ3WKKefIuPQgMGXb0xbcXMBM2xSz3FNvQTyOosOp5DzmtMt
         4xFkb6C8k5GtkidPACiel68JaItIa5JDm++FAINj2BGfCurkxXubZ3UAlxUf8gNq5ZFA
         9WMoPFIWKZFUJyNUBbtYJBmakL1bJp98Qk1Zv3MMdmVcAaflFxHEZXjNDyTvm9xhOO9N
         VkaozctQ0jzIuf+NQktwRVY2xKKx9mAx99YON8aTrz9DWMe/PCgNt9USP1FN2pHpFbwd
         TbFliwJaowBe5wRHi85U6IEf6iAGp+E9+DTrQGYVWHvoNXr/n4K8zWwDQAjNedCz/NKV
         +Stw==
X-Received: by 10.49.14.70 with SMTP id n6mr59239qec.18.1381849196367;
        Tue, 15 Oct 2013 07:59:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.35.194 with SMTP id k2ls191743qej.45.gmail; Tue, 15 Oct
 2013 07:59:55 -0700 (PDT)
X-Received: by 10.58.163.70 with SMTP id yg6mr4612330veb.1.1381849195878;
        Tue, 15 Oct 2013 07:59:55 -0700 (PDT)
Received: by 10.50.147.1 with SMTP id tg1msigb;
        Tue, 15 Oct 2013 07:54:58 -0700 (PDT)
X-Received: by 10.50.73.39 with SMTP id i7mr468538igv.1.1381848898258;
        Tue, 15 Oct 2013 07:54:58 -0700 (PDT)
In-Reply-To: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
X-Original-Sender: wwiser@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236186>

------=_Part_209_20052282.1381848897184
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I downloaded the 1.8.4 release yesterday and I believe I am observing this 
same issue on Windows 7 64-bit. When executing git difftool -d, after my 
difftool exits, these errors are reported in the console:
fatal: unable to access 
'../../../../../../../../c:/myProjects/project/.git/config': Invalid 
argument
fatal: unable to access 
'../../../../../../../../c:/myProjects/project/.git/config': Invalid 
argument
diff-files --name-only -z: command returned error: 128

The path is correct (relative to the git installation) but the "/c:/" 
instead of "/c/" seems to be causing the issue. 

Is this likely to be fixed soon? 

Wesley Wiser

On Thursday, October 10, 2013 8:13:32 AM UTC-4, Sebastian Schuberth wrote:
>
> Hi, 
>
> for my mingwGitDevEnv project [1] I'm currently looking at the failing 
> Git tests [2]. The first tests that fails is t0060-path-utils [3]: 
>
> not ok 88 - relative path: / /a/b/ => ../../ 
> # test "$(test-path-utils relative_path '/' '/a/b/')" = '../../' 
>
> not ok 91 - relative path: /x/y /a/b/ => ../../x/y 
> # test "$(test-path-utils relative_path '/x/y' '/a/b/')" = '../../x/y' 
>
> If I run "test-path-utils relative_path '/' '/a/b/'" on the server 
> (running Windows Server 2008 R2) that perform the testing I indeed 
> get: 
>
> $ test-path-utils relative_path '/' '/a/b/' 
> ../../C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv 
> $ pwd -W 
> C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv/git 
>
> The funny thing is, if I run the exact same binary on my local Windows 
> 8 64-bit machine I get the expected result: 
>
> $ test-path-utils relative_path '/' '/a/b/' 
> ../../ 
> $ pwd -W 
> C:/Jenkins/mingwGitDevEnv-test/workspace/mingwGitDevEnv/git 
>
> So how can the exact same test-path-utils binary create different 
> results fo the same arguments? I'd be very grateful for any insights. 
> If you want to play around with it yourself, you can download the 
> while Jenkins workspace as a ZIP at [4] (but note that it's almost 1 
> GiB). 
>
> It's probably also interesting to mention that t0060-path-utils did 
> not yet fail in build 38 [5] and I'm currently in the process to find 
> out what changed. 
>
> [1] https://github.com/sschuberth/mingwGitDevEnv/ 
> [2] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/42/ 
> [3] 
> http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/ws/test-results/t0060-path-utils.sh/*view*/ 
> [4] 
> http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/ws/mingwGitDevEnv/ 
> [5] http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-test/38/ 
>
> -- 
> Sebastian Schuberth 
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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_209_20052282.1381848897184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I downloaded the 1.8.4 release yest=
erday and I believe I am observing this same issue on Windows 7 64-bit. Whe=
n executing git difftool -d, after my difftool exits, these errors are repo=
rted in the console:</div><div><div>fatal: unable to access '../../../../..=
/../../../c:/myProjects/project/.git/config': Invalid argument</div><div>fa=
tal: unable to access '../../../../../../../../c:/myProjects/project/.git/c=
onfig': Invalid argument</div><div>diff-files --name-only -z: command retur=
ned error: 128</div><div><br></div><div>The path is correct (relative to th=
e git installation) but the "/c:/" instead of "/c/" seems to be causing the=
 issue.&nbsp;</div><div><br></div><div>Is this likely to be fixed soon?&nbs=
p;</div><div><br></div><div>Wesley Wiser</div><br>On Thursday, October 10, =
2013 8:13:32 AM UTC-4, Sebastian Schuberth wrote:<blockquote class=3D"gmail=
_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;p=
adding-left: 1ex;">Hi,
<br>
<br>for my mingwGitDevEnv project [1] I'm currently looking at the failing
<br>Git tests [2]. The first tests that fails is t0060-path-utils [3]:
<br>
<br>not ok 88 - relative path: / /a/b/ =3D&gt; ../../
<br># test "$(test-path-utils relative_path '/' '/a/b/')" =3D '../../'
<br>
<br>not ok 91 - relative path: /x/y /a/b/ =3D&gt; ../../x/y
<br># test "$(test-path-utils relative_path '/x/y' '/a/b/')" =3D '../../x/y=
'
<br>
<br>If I run "test-path-utils relative_path '/' '/a/b/'" on the server
<br>(running Windows Server 2008 R2) that perform the testing I indeed
<br>get:
<br>
<br>$ test-path-utils relative_path '/' '/a/b/'
<br>../../C:/Jenkins/<wbr>mingwGitDevEnv-test/workspace/<wbr>mingwGitDevEnv
<br>$ pwd -W
<br>C:/Jenkins/mingwGitDevEnv-<wbr>test/workspace/mingwGitDevEnv/<wbr>git
<br>
<br>The funny thing is, if I run the exact same binary on my local Windows
<br>8 64-bit machine I get the expected result:
<br>
<br>$ test-path-utils relative_path '/' '/a/b/'
<br>../../
<br>$ pwd -W
<br>C:/Jenkins/mingwGitDevEnv-<wbr>test/workspace/mingwGitDevEnv/<wbr>git
<br>
<br>So how can the exact same test-path-utils binary create different
<br>results fo the same arguments? I'd be very grateful for any insights.
<br>If you want to play around with it yourself, you can download the
<br>while Jenkins workspace as a ZIP at [4] (but note that it's almost 1
<br>GiB).
<br>
<br>It's probably also interesting to mention that t0060-path-utils did
<br>not yet fail in build 38 [5] and I'm currently in the process to find
<br>out what changed.
<br>
<br>[1] <a href=3D"https://github.com/sschuberth/mingwGitDevEnv/" target=3D=
"_blank">https://github.com/sschuberth/<wbr>mingwGitDevEnv/</a>
<br>[2] <a href=3D"http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-te=
st/42/" target=3D"_blank">http://mingwgitdevenv.<wbr>cloudapp.net/job/<wbr>=
mingwGitDevEnv-test/42/</a>
<br>[3] <a href=3D"http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-te=
st/ws/test-results/t0060-path-utils.sh/*view*/" target=3D"_blank">http://mi=
ngwgitdevenv.<wbr>cloudapp.net/job/<wbr>mingwGitDevEnv-test/ws/test-<wbr>re=
sults/t0060-path-utils.sh/*<wbr>view*/</a>
<br>[4] <a href=3D"http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-te=
st/ws/mingwGitDevEnv/" target=3D"_blank">http://mingwgitdevenv.<wbr>cloudap=
p.net/job/<wbr>mingwGitDevEnv-test/ws/<wbr>mingwGitDevEnv/</a>
<br>[5] <a href=3D"http://mingwgitdevenv.cloudapp.net/job/mingwGitDevEnv-te=
st/38/" target=3D"_blank">http://mingwgitdevenv.<wbr>cloudapp.net/job/<wbr>=
mingwGitDevEnv-test/38/</a>
<br>
<br>--=20
<br>Sebastian Schuberth
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
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_209_20052282.1381848897184--
