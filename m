From: "'Dave Borowitz <dborowitz@google.com>' via msysGit" <msysgit@googlegroups.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 12:42:49 -0700
Message-ID: <CAD0k6qQ9aT983e=yzO+jw11FAzX-PMW59iDaY1wba0FJBtmE8Q@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <xmqqsioxqp9i.fsf@gitster.dls.corp.google.com> <CAD0k6qSUYANxbjjbE4jTW4EeVwOYgBD=bXkSu=akiYC_CB7Ffw@mail.gmail.com>
 <xmqqy4ypp7jd.fsf@gitster.dls.corp.google.com>
Reply-To: Dave Borowitz <dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Marat Radchenko <marat@slonopotamus.org>, 
	msysGit <msysgit@googlegroups.com>, Pat Thoyts <patthoyts@gmail.com>, 
	Nick Hengeveld <nickh@reactrix.com>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBC64RC4WYIKBBUG67KNAKGQEU4P7B7Q@googlegroups.com Mon Apr 28 21:43:13 2014
Return-path: <msysgit+bncBC64RC4WYIKBBUG67KNAKGQEU4P7B7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC64RC4WYIKBBUG67KNAKGQEU4P7B7Q@googlegroups.com>)
	id 1WerSK-0003jz-N7
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 21:43:12 +0200
Received: by mail-lb0-f189.google.com with SMTP id u14sf313533lbd.26
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:reply-to:content-type;
        bh=7/vsMoHkCWE2lAbyHbfCZzO0AqWO3zdUzdmMKpcmiYE=;
        b=lB4P5NTPiqMNrokeUPRqrlZGCYr6kOBbT7qGfmqSbEAR7sg98HaJzz2B12BN5JgBWT
         oef3utZpX06LUydWxgxoCyH6+kyNQauu6vHtMSQ2CzIgxU7UxfTqoMN50KVpaV9qPjH2
         cc+meKb/r74IiU1M7GtbQQZBm9Z0ytf4Pmw1mTH8VAZtMnNGEdua/60BpaoDvEDEktKJ
         2RBvubTRaP88ENHTN/WI8K6lqlZ1eJXMSwVIYvm+2+GASOUKAY4Z3XFu7E2OlnI19efI
         0sX3z2nfdFbOLRv+qCmT5bO7M8WYeN14M87Y/wsmUfbTjP+cqpHv+m52kcaI6KXBD+IF
         9JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:reply-to:content-type;
        bh=7/vsMoHkCWE2lAbyHbfCZzO0AqWO3zdUzdmMKpcmiYE=;
        b=eghvzvU4OXHBrPyn1aFefQdFGjpNHigYLQenaQmYpfEmknlvwRgQye3f7/l5zO4jWB
         bfE0jx8C8CFn/8v4Ay3CWJX9nQktgEWV6zvJjsY0wAjFe2e/Fkq10CPNapqjnhGPiaaA
         V5gMfsMefa43nnR7aVKMD0IBVaDORHefnACyoJoYiHRes2DYEped6BBawcLJs2vE8GSB
         uRH6FONwJ5im+t6Qy+p93l1VBKbnRh+YAelmsVV/bV79HedDGcMtKhAkNK25XQC5WRfE
         yzNg886dtse1WsYc9iqDv0OIFobmgNh91Udeh4CIKHwy5JF0VPvgt6f6opsJXqLPBxST
         LcPQ==
X-Received: by 10.152.42.164 with SMTP id p4mr281651lal.1.1398714192506;
        Mon, 28 Apr 2014 12:43:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.161.197 with SMTP id xu5ls352404lab.105.gmail; Mon, 28 Apr
 2014 12:43:11 -0700 (PDT)
X-Received: by 10.112.49.229 with SMTP id x5mr507231lbn.14.1398714191478;
        Mon, 28 Apr 2014 12:43:11 -0700 (PDT)
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com [2a00:1450:4010:c03::22d])
        by gmr-mx.google.com with ESMTPS id u49si619217eeo.1.2014.04.28.12.43.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:43:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of dborowitz@google.com designates 2a00:1450:4010:c03::22d as permitted sender) client-ip=2a00:1450:4010:c03::22d;
Received: by mail-la0-f45.google.com with SMTP id pv20so929136lab.18
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 12:43:11 -0700 (PDT)
X-Gm-Message-State: ALoCoQnicDBHHYHCc1M+RFprhFuw58l4BUzBtWbyi06RH0P+GrF7OkhuMcdti7R1U7u649tLyg4c7hqpwtY7Fx8//7aHM920tOHWkglWq6dIZzfaNXIyWXIbqemhdeWxgDb7dSxJhG/c8pFkV6oFjHQjWu1uXOewQJoNfuhGpDcxWrSA0Ag2RgXZoUQEOopFQKfSb4XsbjNIcRMTa8PxwjKRZWfVhNkPQA==
X-Received: by 10.112.168.170 with SMTP id zx10mr3052489lbb.35.1398714190949;
 Mon, 28 Apr 2014 12:43:10 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 12:42:49 -0700 (PDT)
In-Reply-To: <xmqqy4ypp7jd.fsf@gitster.dls.corp.google.com>
X-Original-Sender: dborowitz@google.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of dborowitz@google.com designates 2a00:1450:4010:c03::22d
 as permitted sender) smtp.mail=dborowitz@google.com;       dkim=pass
 header.i=@google.com;       dmarc=pass (p=REJECT dis=NONE) header.from=google.com
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
X-Original-From: Dave Borowitz <dborowitz@google.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247417>

On Mon, Apr 28, 2014 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "'Dave Borowitz <dborowitz@google.com>' via msysGit"
> <msysgit@googlegroups.com> writes:
>
>> I think I should probably re-roll the patch to default to the old
>> behavior (blind -lcurl) if curl-config returns the empty string, which
>> I believe is also the case when the binary is not found.
>
> Thanks for a prompt response; as this may indicate a possible
> regression on what is already in 2.0-rc1, I am tempted to say that
> we should revert the merge in the meantime.
>
> Unless such an update can be done in a fairly trivial way, that is.

I already sent the update. There's a bit more (unavoidable) complexity
in the conditionals but it should still be fairly straightforward.

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
For more options, visit https://groups.google.com/d/optout.
