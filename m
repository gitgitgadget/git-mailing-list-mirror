From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Thu, 23 Sep 2010 21:27:35 +0100
Message-ID: <AANLkTimviqUqcy40aR=DC--tqKHWXfX9gLMoX7tyjafe@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
	<AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0015175cb1d4b4d6490490f31737
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncCOL1rfnnEBDA8O7kBBoEuvSE4w@googlegroups.com Thu Sep 23 22:28:09 2010
Return-path: <msysgit+bncCOL1rfnnEBDA8O7kBBoEuvSE4w@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOL1rfnnEBDA8O7kBBoEuvSE4w@googlegroups.com>)
	id 1OysOm-00058K-Cr
	for gcvm-msysgit@m.gmane.org; Thu, 23 Sep 2010 22:28:08 +0200
Received: by qyk5 with SMTP id 5sf3780046qyk.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Sep 2010 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:received
         :received:in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=kxZjq5NkTjedKy5X3mPhu4FwSawJXMjQIWa8Wk1eCG0=;
        b=2YfDGqCTHb0rMCjRkkHHWa3s2XYlOa2Rb7JcdNhSqwbsS8zJOhRA19UXi+5uJcIGgG
         oPgJ5XATZ6AYstDAd4i3AM5qHWJKr5ZAiv5gUd7rxAEj4FDzo/JFaYCo953M5ohgxSRx
         CFh907v55AYNz/z2fEaC4uROQ5vfyE1bw8h7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        b=zFIM7Moaxws1iEyxou7DG7ds5oSGnA+1EqLHBknJpt2LKrY9wdLYoqS/mLUOx6yNnU
         WywIBM4y77zC1mERarhNHvpgQJEIewCh4bAFlr8H9KPgGZWXeM+aXiUfZH365i6C2+PP
         i5Wt8W7n9sSJr0YGUALQSzqa2zN0YCGVXGCVA=
Received: by 10.229.43.218 with SMTP id x26mr323925qce.13.1285273664243;
        Thu, 23 Sep 2010 13:27:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.219.212 with SMTP id hv20ls725464qcb.1.p; Thu, 23 Sep 2010
 13:27:43 -0700 (PDT)
Received: by 10.229.222.20 with SMTP id ie20mr343747qcb.20.1285273663052;
        Thu, 23 Sep 2010 13:27:43 -0700 (PDT)
Received: by 10.229.222.20 with SMTP id ie20mr343746qcb.20.1285273662981;
        Thu, 23 Sep 2010 13:27:42 -0700 (PDT)
Received: from mail-qw0-f45.google.com (mail-qw0-f45.google.com [209.85.216.45])
        by gmr-mx.google.com with ESMTP id 2si716607qci.10.2010.09.23.13.27.41;
        Thu, 23 Sep 2010 13:27:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of patthoyts@gmail.com designates 209.85.216.45 as permitted sender) client-ip=209.85.216.45;
Received: by mail-qw0-f45.google.com with SMTP id 4so1291759qwk.32
        for <msysgit@googlegroups.com>; Thu, 23 Sep 2010 13:27:41 -0700 (PDT)
Received: by 10.224.11.6 with SMTP id r6mr1734738qar.137.1285273656022; Thu,
 23 Sep 2010 13:27:36 -0700 (PDT)
Received: by 10.229.61.81 with HTTP; Thu, 23 Sep 2010 13:27:35 -0700 (PDT)
Received: by 10.229.61.81 with HTTP; Thu, 23 Sep 2010 13:27:35 -0700 (PDT)
In-Reply-To: <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
X-Original-Sender: patthoyts@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of patthoyts@gmail.com designates 209.85.216.45 as permitted sender)
 smtp.mail=patthoyts@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156902>

--0015175cb1d4b4d6490490f31737
Content-Type: text/plain; charset=UTF-8

(Apparently gmail on a phone insists on top posting)
It looks like this problem was missed by the test suite. Any chance of a
test as well? Got to catch those regressions.

On 23 Sep 2010 19:00, "Erik Faye-Lund" <kusmabite@gmail.com> wrote:
> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com>
wrote:
>> Since open() already sets errno correctly for the NULL-case, let's just
>> avoid the problematic strcmp.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>
> I guess I should add a comment as to why this patch is needed:
>
> This seems to be the culprit for issue 523 in the msysGit issue
> tracker: http://code.google.com/p/msysgit/issues/detail?id=523
>
> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
> parse_pack_index(), which in turn pass it to check_packed_git_idx(),
> which again pass it to open(). This all looks intentional to my
> (http.c-untrained) eye.
>
> The code in mingw_open was introduced in commit 3e4a1ba (by Johannes
> Sixt), and the lack of a NULL-check looks like a simple oversight.

--0015175cb1d4b4d6490490f31737
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p>(Apparently gmail on a phone insists on top posting)<br>
It looks like this problem was missed by the test suite. Any chance of a te=
st as well? Got to catch those regressions.</p>
<p>On 23 Sep 2010 19:00, &quot;Erik Faye-Lund&quot; &lt;<a href=3D"mailto:k=
usmabite@gmail.com">kusmabite@gmail.com</a>&gt; wrote:<br type=3D"attributi=
on">&gt; On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund &lt;<a href=3D"ma=
ilto:kusmabite@gmail.com">kusmabite@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Since open() already sets errno correctly for the NULL-case, let&#=
39;s just<br>&gt;&gt; avoid the problematic strcmp.<br>&gt;&gt;<br>&gt;&gt;=
 Signed-off-by: Erik Faye-Lund &lt;<a href=3D"mailto:kusmabite@gmail.com">k=
usmabite@gmail.com</a>&gt;<br>
&gt; <br>&gt; I guess I should add a comment as to why this patch is needed=
:<br>&gt; <br>&gt; This seems to be the culprit for issue 523 in the msysGi=
t issue<br>&gt; tracker: <a href=3D"http://code.google.com/p/msysgit/issues=
/detail?id=3D523">http://code.google.com/p/msysgit/issues/detail?id=3D523</=
a><br>
&gt; <br>&gt; fetch_and_setup_pack_index() apparently pass a NULL-pointer t=
o<br>&gt; parse_pack_index(), which in turn pass it to check_packed_git_idx=
(),<br>&gt; which again pass it to open(). This all looks intentional to my=
<br>
&gt; (http.c-untrained) eye.<br>&gt; <br>&gt; The code in mingw_open was in=
troduced in commit 3e4a1ba (by Johannes<br>&gt; Sixt), and the lack of a NU=
LL-check looks like a simple oversight.<br></p>

--0015175cb1d4b4d6490490f31737--
