From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re: Problems with Windows, Was: What's cooking in
 git.git (May 2013, #01; Fri, 3)
Date: Tue, 14 May 2013 23:41:49 +0100
Organization: OPDS
Message-ID: <8D0BDAB173A744B482A7DCC9DCB8AD26@PhilipOakley>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org> <51890F48.3090409@web.de> <518BDA49.400@ramsay1.demon.co.uk> <5192927E.3030203@web.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Content-Transfer-Encoding: quoted-printable
Cc: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>,
	<mlevedahl@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	<j6t@kdbg.org>,
	"msysGit" <msysgit@googlegroups.com>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
X-From: msysgit+bncBDSOTWHYX4PBBIP3ZKGAKGQEC5NUVBQ@googlegroups.com Wed May 15 00:41:44 2013
Return-path: <msysgit+bncBDSOTWHYX4PBBIP3ZKGAKGQEC5NUVBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f187.google.com ([74.125.82.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBIP3ZKGAKGQEC5NUVBQ@googlegroups.com>)
	id 1UcNuc-00016f-7g
	for gcvm-msysgit@m.gmane.org; Wed, 15 May 2013 00:41:38 +0200
Received: by mail-we0-f187.google.com with SMTP id t59sf178800wes.4
        for <gcvm-msysgit@m.gmane.org>; Tue, 14 May 2013 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf
         :x-ironport-anti-spam-filtered:x-ironport-anti-spam-result
         :x-ironport-av:message-id:reply-to:from:to:cc:references:subject
         :date:organization:mime-version:x-priority:x-msmail-priority
         :x-mailer:x-mimeole:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=C9tJeNLUKw/6xqqh6BYl0hEkuVCVAF84F7QqPL+vu84=;
        b=dKojIb9FwVScKbRXOE//l59OuSbw509skQJ7hY009alsx0PXBu+8rMOVnrADsL+SZ3
         ErolHF2ztM+dhe8ytgOBBGs+fxWzA4ha57VD13kgJ74rBjtuaxFnP9sQsMZtBjeGbgQl
         1fuBj+yTGy3NPVDooNpu1mbW7fkyjVqkm 
X-Received: by 10.180.88.232 with SMTP id bj8mr579959wib.15.1368571297917;
        Tue, 14 May 2013 15:41:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.198.142 with SMTP id jc14ls1228096wic.34.canary; Tue, 14
 May 2013 15:41:36 -0700 (PDT)
X-Received: by 10.180.38.5 with SMTP id c5mr1551347wik.3.1368571296787;
        Tue, 14 May 2013 15:41:36 -0700 (PDT)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id bu10si12973wib.2.2013.05.14.15.41.36
        for <msysgit@googlegroups.com>;
        Tue, 14 May 2013 15:41:36 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvENAIuhklFOl3Xl/2dsb2JhbABagwc3iHu3KwEDAYEBF3SCGgUBAQUIAQEoAQUeAQEhCwEBAwUCAQMRAwEBAQEJJRQBBAgSBgcPCAYBEggCAQIDAQ2HXAMTCK5RhkkNFYg3jEiBCRwaGAsBCTczDYJuYQOIZ4YAhH2Ba4MNinKFI4FXgTk7
X-IronPort-AV: E=Sophos;i="4.87,672,1363132800"; 
   d="scan'208";a="575369122"
Received: from host-78-151-117-229.as13285.net (HELO PhilipOakley) ([78.151.117.229])
  by out1.ip06ir2.opaltelecom.net with SMTP; 14 May 2013 23:41:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224364>

sorry about the MUA mangling - reply at end.
----- Original Message -----=20
From: "Torsten B=F6gershausen" <tboegi@web.de>
To: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Cc: "Torsten B=F6gershausen" <tboegi@web.de>; "Junio C Hamano"
<gitster@pobox.com>; <git@vger.kernel.org>; <mlevedahl@gmail.com>;
"Jonathan Nieder" <jrnieder@gmail.com>; <j6t@kdbg.org>; "msysGit"
<msysgit@googlegroups.com>
Sent: Tuesday, May 14, 2013 8:37 PM
Subject: [msysGit] Re: Problems with Windows, Was: What's cooking in
git.git (May 2013, #01; Fri, 3)


On 2013-05-09 19.18, Ramsay Jones wrote:
> Torsten B=F6gershausen wrote:
>> On 2013-05-04 01.14, Junio C Hamano wrote:
>>>
>>>  Cygwin portability; both were reviewed by Jonathan, and the tip one
>>>  seems to want a bit further explanation.  Needs positive report
>>>  from Cygwin 1.7 users who have been on 1.7 to make sure it does not
>>>  regress for them.
>>
>> I was trying to verify that cygwin 1.7 is still Ok, but got puzzled.
>>
>> Running the test suite under cygwin doesn't seem to work any more
>> (?):
>>
>> Scenario 1:
>> The PC is running alone, and goes into the screen saver.
>> Pressing CTRL-ALT-DEL didn't get any effect.
>>
>> Scenario 2:
>> The PC didn't react any more, when the test suite was run in
>> background.
>> In 3 or 4 cases the PC needed to be reboot hardly.
>>
>> Using the commits before and after this change makes the test suite
>> hang
>> as well at some point, then it hangs somewhere at TC 3000--4000.
>>
>> Scenario 4:
>> The I disabled the screensaver, upgdated cygwin,
>>  and went back to an older commit:
>> The latest run from commit 52d63e70, April 28,
>> hangs in TC 5500, ok 26 clone shallow object count.
>>
>> I can see 2 times
>> git.exe pull --depth 4 ..A
>>
>> Scenario 5:
>> The run of today 1.8.3-rc1, hangs in t5510,
>> some git.exe are running fetch. (or pull)
>>
>>
>> It seems as if some process/exes are not terminated
>> in the way it should be.
>>
>> I will try on a different machine,
>> comments are wellcome
>
> Hmm, I'm a little puzzled, but not shocked. ;-)
>
> Somebody, I forget who, had already tested Jonathan's patch
> on cygwin 1.7 successfully and my follow up patch should be
> a no-op on cygwin 1.7; so I'm puzzled! (The high risk should
> have been on cygwin 1.5).
>
> I'm not shocked because running the test-suite on cygwin has
> been a bit of a magical mystery tour for quite some time.
>
> In about 2007, I could not run the test-suite for about six
> to nine months; it would randomly wedge my laptop solid - I had
> to pull the power-cord out in order to re-boot. (I suspect that
> commit 9cb18f56fde may have cured that particular problem, but
> don't quote me on that - I didn't investigate at the time.)
>
> I have noticed that running the tests with 'prove' is more likely
> to prove successful, so my config.mak looks like:
>
>     $ cat config.mak
>     NO_SVN_TESTS=3D1
>     GIT_TEST_OPTS=3D--no-color
>     NO_GETTEXT=3D1
>     DEFAULT_TEST_TARGET=3Dprove
>     GIT_PROVE_OPTS=3D'--timer'
>     $
>
> I currently run the tests like so:
>
>     $ time $(GIT_SKIP_TESTS=3D't0061.3 t0070.3 t4130 t9010 t9300' make
> test \
>     >test-outp13 2>&1)
>
>     real    172m25.311s
>     user    132m15.133s
>     sys     66m43.122s
>     $
>
> The t0061.3 and t0070.3 failures don't require much discussion. The
> t4130
> failure is an intermittent "racy git" issue that has been on my TODO
> list
> for several years. t9300 also fails intermittently. However, t9010
> fails
> every time for me, hanging the test suite (although ^C interrupts it
> just
> fine).
>
> I have a "fix" for t9010 that looks like:
>
>     diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
>     index b7eed24..4d01e3b 100755
>     --- a/t/t9010-svn-fe.sh
>     +++ b/t/t9010-svn-fe.sh
>     @@ -22,10 +22,9 @@ try_dump () {
>             maybe_fail_fi=3D${3:+test_$3} &&
>
>             {
>     -               $maybe_fail_svnfe test-svn-fe "$input" >stream
> 3<backflow &
>     -       } &&
>     -       $maybe_fail_fi git fast-import --cat-blob-fd=3D3 <stream
> 3>backflow &&
>     -       wait $!
>     +               $maybe_fail_svnfe test-svn-fe "$input" 3<backflow
>     +       } |
>     +       $maybe_fail_fi git fast-import --cat-blob-fd=3D3 3>backflow
>      }
>
>      properties () {
>
> but I have not tested this patch enough to be happy to submit it (I
> have
> some suspicions that it would still fail intermittently, just like
> t9300).
>
> Also, commit 7bc0911d ("test-lib: Fix say_color () not to interpret
> \a\b\c
> in the message", 11-10-2012) caused several random test failures.
> (don't ask
> me why). So, before each test run, I have to apply the following:
>
>     diff --git a/t/test-lib.sh b/t/test-lib.sh
>     index f50f834..ed32b7f 100644
>     --- a/t/test-lib.sh
>     +++ b/t/test-lib.sh
>     @@ -230,7 +230,7 @@ else
>             say_color() {
>                     test -z "$1" && test -n "$quiet" && return
>                     shift
>     -               printf "%s\n" "$*"
>     +               echo -E "$*"
>             }
>      fi
>
> which effectively reverts that commit.
>
> So, as I said, a "magical mystery tour". :-D
>
> ATB,
> Ramsay Jones
>
>
First of all,
the patch we are talking about does not any regrssions at my side.

Second,
I was able to do some testing.
The hanging is not 100% reproducable, and I had one hanging in Git 1.8.1

Turning the screen saver off in Win XP helps that the machine reacts,
and using process explorer showed that the hanging is happening
in test cases doing "git fetch" (or git pull) from a local repository.
What I can see is one git-fetch.exe together with git-upload-pack.exe

>From my understanding is the upload-pack a "forked" exe from the main
git,
and they should talk to each other.
One interesting part is in run-command.c, and there we have different
code for MiNGW
and the "rest of the world", Linux/Unix/cygwin.

I tried to steal the code around mingw_spawnvpe(), but could not get
that working (yet).

Another approach could be to steal the pipe() from mingw.

Does anybody know if we have a similar problem (hanging TC which test
fetch/pull)
in MinGW/msysGit?

If no, why not ;-)

Thanks for reading
/Torsten

---
Torsten,

There have been on-going sporadic problems with the push / fetch over
various protocols which haven't been tracked down to an exact point that
affords a proper fix. The reports appear to cover both ssh and git=20
protocols. In some cases it could be the users ssh client.

The skill sets and developer approaches to problem resolution in
Windowsland and *nixland do appear to be somewhat different ;-)

I posted a reply to an earlier report on
https://groups.google.com/group/msysgit/msg/fdabaa0e4f8a55a7?hl=3Den
From: "Philip Oakley" <philipoak...@iee.org>
Date: Fri, 8 Feb 2013 19:31:33 -0000
Local: Fri, Feb 8 2013 8:31 pm
Subject: Re: [msysGit] Unable to clone/fetch

[...]

This is my list of web pages on the issue that may be of help. Issue 457
has a good discussion. It looks to me as if this is a case of 'premature
optimisation' in Linux land (or the the opposite by microsoft) in the
way that the side band channels are set-up and info is exchanged. But I
haven't go any further than reading through the various reports,
thinking, and surmising (no practical work ;-).


If you are able to find a method to unwind the situation that causes the
deadlock it would be great for every one.
regards
Philip


Google :: "msysgit hangs when ssh fetch"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
http://billauer.co.il/blog/2012/10/git-pull-windows-freeze-receive-pack/
 Change "side-band-64k" to "side-bond-64k" so it never gets used.


http://devnet.jetbrains.net/message/5473415?tstart=3D0
 remnants of several previous installations of Git. Sort the path
entries..


http://code.google.com/p/msysgit/issues/detail?id=3D74
 Issue 74: git remote update/git fetch fails via ssh


http://code.google.com/p/msysgit/issues/detail?id=3D161
 Issue 161: git-gui hangs on ssh for users with home directory mapped to
server share


http://code.google.com/p/msysgit/issues/detail?id=3D243
https://groups.google.com/forum/?fromgroups=3D#!topic/msysgit/mFnzYM3IA_4
 Re: Issue 243 in msysgit: ssh hangs a minute than goes to next line
without performing action


http://code.google.com/p/msysgit/issues/detail?id=3D361
 Issue 361: Clone/fetch/pull from github using git protocol hangs, http
works


http://code.google.com/p/msysgit/issues/detail?id=3D457
*** a good discussion.
 Issue 457: Push over git protocol hangs in msysGit
 The problematic commit is 0c499ea60f, which introduced the sideband
support in send_pack.



--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
