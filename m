From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 00:56:45 +0100
Message-ID: <vpqh9uavp6q.fsf@anie.imag.fr>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net>
	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
	<vpqioerz03s.fsf@anie.imag.fr>
	<CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
	<c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBC3OZIEKVABBBQ47WSTQKGQEKPEEN6A@googlegroups.com Wed Feb 25 00:56:53 2015
Return-path: <msysgit+bncBC3OZIEKVABBBQ47WSTQKGQEKPEEN6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3OZIEKVABBBQ47WSTQKGQEKPEEN6A@googlegroups.com>)
	id 1YQPLQ-0001k8-NC
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 00:56:52 +0100
Received: by lbiz11 with SMTP id z11sf127560lbi.8
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:mailscanner-null-check
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=8ryz8X/JezwOvLz0x/b4TR62lBc8rDjBxZFe1h8HlaY=;
        b=BSpZp8hsWUnTKrUTYJGs+FB3v/GgDxOssg2uGYbpVJJoMbVbLL3CKodXLIuem+Yt8W
         tpweh7AlPBJKKr/Yca34l0uzbSWPhIMMLFLi5ousSxSRvBAZ5MRasfxcRF1D3pdNhs+m
         AJcUpqQFvPE9UuUGbsCXjbYNxtl7SvsWpkkfAO5226uCfhjY4tGmeFB/6eT70BWFGSvg
         CQdGEBzoexG5lQuKBeeknfjxmp5UzMCDhyKKGU08XWd0CRDjnP5bN/cjzbLj+g7HzFNV
         Pzq2H8CWyXBaMvkEGUnmGAgkg1Ecp/HF/XsHqAUSNUs1odTmEggKlvTzGvSYfBnTLccF
         WOlg==
X-Received: by 10.180.76.167 with SMTP id l7mr133104wiw.8.1424822212446;
        Tue, 24 Feb 2015 15:56:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.10.131 with SMTP id i3ls876240wib.35.gmail; Tue, 24 Feb
 2015 15:56:50 -0800 (PST)
X-Received: by 10.180.8.67 with SMTP id p3mr2460000wia.7.1424822210616;
        Tue, 24 Feb 2015 15:56:50 -0800 (PST)
Received: from rominette.imag.fr (mx2.imag.fr. [2001:660:5301:59::17])
        by gmr-mx.google.com with ESMTPS id l8si1189296wia.0.2015.02.24.15.56.50
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 15:56:50 -0800 (PST)
Received-SPF: pass (google.com: domain of Matthieu.Moy@grenoble-inp.fr designates 2001:660:5301:59::17 as permitted sender) client-ip=2001:660:5301:59::17;
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1ONug08032335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2015 00:56:42 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1ONujML029213;
	Wed, 25 Feb 2015 00:56:45 +0100
In-Reply-To: <c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 24 Feb 2015 21:33:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Feb 2015 00:56:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1ONug08032335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425427004.74176@pPYy67iq1M9kodOEahOfVg
X-Original-Sender: matthieu.moy@grenoble-inp.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Matthieu.Moy@grenoble-inp.fr designates
 2001:660:5301:59::17 as permitted sender) smtp.mail=Matthieu.Moy@grenoble-inp.fr
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264362>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Junio,
>
> On 2015-02-24 19:25, Junio C Hamano wrote:
>> On Tue, Feb 24, 2015 at 9:32 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> About the proposal:
>>>
>>>   The idea of this project is to dive into the Git source code and
>>>   convert, say, git-add--interactive.perl and/or git stash into proper C
>>>   code, making it a so-called "built-in".
>>>
>>> My advice would be to try converting several small scripts, and avoid
>>> targetting a big one....
>>> add--interactive and stash are relatively complex beasts, perhaps
>>> git-pull.sh would be easier to start with.
>> 
>> Yeah, I think that is a very good suggestion.
>
> Well, git-pull.sh is really small. I did not want to give the impression that the Git project is giving out freebies. But I have no objection to change it if you open that PR.

To get an idea, I counted the lines of code written by the student I
mentored last year:

$ git log --author tanayabh@gmail.com -p | diffstat -s   
 43 files changed, 1225 insertions(+), 367 deletions(-)

I would consider this GSoC as "average" (i.e. not exceptionnally good,
but certainly not a bad one either), so you may hope for more, but you
should not _expect_ much more IMHO.

In comparison:

$ wc -l git-add--interactive.perl
1654 git-add--interactive.perl
$ wc -l git-stash.sh
617 git-stash.sh

I'd expect a rewrite in C to at least double the number of lines of
code, so rewriting git-stash would mean writting at least as many lines
of code as the GSoC above. git-add--interactive.perl would be rather far
above.

But my point was not to convert _only_ git-pull.sh, but to have a GSoC
starting with this one and plan more. Then, depending on how it goes,
you can adjust the target.

This all depends on what you intend to do if the student does not finish
the job. If you're going to do the rewrite yourself anyway, then having
the student do even half of it is good already. If you're not going to
finish the job by yourself, then a 95%-done-rewrite means a piece of
code posted on the mailing list and never merged (and a lot of time
wasted).

In any case, these are just advices, certainly not objections or hard
requests to change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

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
