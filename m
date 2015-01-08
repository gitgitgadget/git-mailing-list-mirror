From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re: Probably a bug with "~" symbol in filenames on
 Windows 7 x64 in git 1.9.5
Date: Thu, 08 Jan 2015 13:59:50 +0100
Message-ID: <54AE7F46.9060103@web.de>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com> <CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com> <alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info> <20150108102815.GA4806@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, 
 Git Mailing List <git@vger.kernel.org>,
 Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCUZ3EUT2ADRBBH7XGSQKGQEDQU2CKY@googlegroups.com Thu Jan 08 14:03:50 2015
Return-path: <msysgit+bncBCUZ3EUT2ADRBBH7XGSQKGQEDQU2CKY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBBH7XGSQKGQEDQU2CKY@googlegroups.com>)
	id 1Y9Chr-0008Vu-UX
	for gcvm-msysgit@m.gmane.org; Thu, 08 Jan 2015 14:00:55 +0100
Received: by mail-lb0-f183.google.com with SMTP id p9sf292468lbv.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 08 Jan 2015 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=8ETA5IiRXGOEvKPIjsiaEkJRmzmYOG3zdzF6j0gqdjs=;
        b=wYEUJEctY9+JDQlu5KNkZcAMcn61uMe/2HjbGrmuHhwntGGUnlwosgO2ugwv2CkE0n
         6FxTn6NU6JSmda36ycNRpyybTWplhWP+M/oI4on9hgVKYjdcgfcIPdRjD2VROeg73Lav
         jHzPiAi/z+70o49z+wzqDCAWb6qymxrdBNHKVBP67l9SYBqiTRhnJb5XSeGAf8DpcewB
         k9o75yxsCEn8ZZWHSz5uM+5xZp/xO/9X2nx56HZWUNpxt2joaVzPdk2iAkZ7TCrcirN/
         /MvlcYOYdyhth5EABfLkqxmE0OkllKtBeuX/9GGS9xbTLXTH4pqvR8gNxZqdWOgTs7b/
         B0tQ==
X-Received: by 10.152.18.193 with SMTP id y1mr15184lad.26.1420722053685;
        Thu, 08 Jan 2015 05:00:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.203.162 with SMTP id kr2ls283646lac.36.gmail; Thu, 08 Jan
 2015 05:00:52 -0800 (PST)
X-Received: by 10.152.44.225 with SMTP id h1mr1180882lam.2.1420722052453;
        Thu, 08 Jan 2015 05:00:52 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id v4si365275wiz.2.2015.01.08.05.00.52
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2015 05:00:52 -0800 (PST)
Received-SPF: pass (google.com: domain of tboegi@web.de designates 212.227.17.12 as permitted sender) client-ip=212.227.17.12;
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LgHPM-1XUaYF0pam-00nl7w; Thu, 08 Jan 2015 14:00:31
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <20150108102815.GA4806@peff.net>
X-Provags-ID: V03:K0:c60ECTlGqm4RbW/gGR/PhkpB357y2pFUJs2QT9AdKV+KwLkcQ2X
 eIAYBscvBq5acbIvx4oDM3OuMkOeJXELN6EROTlbLWk6zvInKRYyNzuwUPg7sE1HkQ1rTTn
 w0rXQzAJuglwsABeDOqkDjxES7KqEwc1/aQDaGpyed51mq5f6pg9NWv2bwkiPDFHjv7NFHX
 3cdxHSFSYVDINCWcFcHBQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of tboegi@web.de designates 212.227.17.12 as permitted
 sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262195>

On 01/08/2015 11:28 AM, Jeff King wrote:
> On Thu, Jan 08, 2015 at 11:06:18AM +0100, Johannes Schindelin wrote:
>
>> ICON~714.PNG is a valid short name for a long name (such as
>> 'icon.background.png') because it fits the shortening scheme (8.3 format,
>> the base name ends in ~<n>). As this can clash with a validly shortened
>> long name, Git for Windows refuses to check out such paths by default.
>>
>> If you want the old -- unsafe -- behavior back, just set your
>> core.protectNTFS to false (this means that you agree that the incurred
>> problems are your own responsibility and cannot be blamed on anybody else
>> ;-))
> I wonder if it is worth having a "git-only" mode for core.protectNTFS.
> Turning it off entirely would make him susceptible to GIT~1 attacks.
>
> -Peff
>
There is something more then just the "tilde" protection going on, it seems:


torstenbogershausen@TORBOGWM ~/projects/test_tilde (master)
$  ~/projects/git/msysgit/git ls-files
ICON~714.PNG

torstenbogershausen@TORBOGWM ~/projects/test_tilde (master)
$  ~/projects/git/msysgit/git status
On branch master
nothing to commit, working directory clean

torstenbogershausen@TORBOGWM ~/projects/test_tilde (master)
$  ~/projects/git/tb/git status
On branch master
nothing to commit, working directory clean

torstenbogershausen@TORBOGWM ~/projects/test_tilde (master)
$  ~/projects/git/msysgit/git --version
git version 1.9.2.msysgit.0.2273.gc47d6ec

torstenbogershausen@TORBOGWM ~/projects/test_tilde (master)
$  ~/projects/git/tb/git --version
git version 2.2.1.268.g1e6f5b2

Neither latest msygit nor latest git.git reports a problem with a single 
file
within a short path.
It may be, that the '~' is not accepted in a long path or there are 
"problems"
when a directory is filled with many files, but that is speculation.

Dimitry,
is there a way to make the problem reproducible for other people ?
Either a public demo-repo, or a step-by-step receipe  ?

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
