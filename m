From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v3 5/8] imap-send: build imap-send on Windows
Date: Tue, 13 Oct 2009 23:34:05 +0200
Message-ID: <40aa078e0910131434u4240ea8fy480efcebdaa21a8f@mail.gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com> <1255461925-2244-6-git-send-email-kusmabite@gmail.com> <200910132157.41279.j6t@kdbg.org> <40aa078e0910131316s308f2bc5h8d679c59c0d5b762@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 23:34:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxp0f-0008AE-UV
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 23:34:22 +0200
Received: by yxe5 with SMTP id 5so3465652yxe.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=nnOQ9/NShYSf6GQP50U3iUbiDK8Szq+M91VMqe3shRU=;
        b=LaL/iIP6yC1DkKYs9Tdjw2LzS5KwqMzJSe3WI36rMa33l8YcLpZW2DzXKKx02qJM7x
         Q2LRdKv33AjbvHUL1M42rMil8LtgxttNXdqdey+Z6MC6zLf5cFNilNXYhuM1zQXHqRYE
         zvZ9cxyxTEG+cKwQcza/oL4pE83PsAaLABUdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=AMjfGay4xgDrYiZgZGezoWicNvlsN1jWIERnb5qSxk8RAuNtArVkM5GSxJtsgdkVq6
         KXo0SIb3eN6B5PML7TUNTnAu6ZhjLp/EqwcJiSJow7dZKejH4pu5EIzyTeVLjvUygkQn
         dMxVuRyCGJJCpRKFql2TQt2Rr5eA7xAKog0iw=
Received: by 10.150.17.1 with SMTP id 1mr914988ybq.34.1255469654719;
        Tue, 13 Oct 2009 14:34:14 -0700 (PDT)
Received: by 10.177.105.17 with SMTP id h17gr7409yqm.0;
	Tue, 13 Oct 2009 14:34:08 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.25.5 with SMTP id x5mr90216bkb.37.1255469646962; Tue, 13 Oct 2009 14:34:06 -0700 (PDT)
Received: by 10.204.25.5 with SMTP id x5mr90215bkb.37.1255469646936; Tue, 13 Oct 2009 14:34:06 -0700 (PDT)
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com [209.85.220.212]) by gmr-mx.google.com with ESMTP id 16si324279fxm.2.2009.10.13.14.34.05; Tue, 13 Oct 2009 14:34:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.212 as permitted sender) client-ip=209.85.220.212;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.212 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f212.google.com with SMTP id 8so9428601fxm.45 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:reply-to:in-reply-to :references:date:message-id:subject:from:to:cc:content-type; bh=mLDVDIEKA+H/BRYCQNKrGHSfC1Fvbweq31vjkX7O9+k=; b=fxYaGzV0nccONEvR9rQNk81xmkYn4n2R1T/o8w8Heucs8urzASX7je7H2dsegeu1Uk p1/s2CYcbvp3YTqqUzeYNdmwJ73SJijFfXKf2vrWxQsxa6h1nIS5THnmO/hbdfS2uvp9 kFBpWR/eRDol5aoQtqOw2kr1oqO0WH1J7TcQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:reply-to:in-reply-to:references:date:message-id :subject:from:to:cc:content-type; b=CJPMG8cMSMlY0Is3cz44NHsRk7gtSLNiEVAsBMPWGZHrOIGJFazFjjqoqq+UywVuFC fopo2li+Y1DlUnqD9grov/J64KvVDxEkJjaqpmALMulkWftU9VWra5XdY18b8CA2shwi +ZxEcfnXKrphdPDM8BRj/J8MpAg73mXsMRHxs=
Received: by 10.204.10.143 with SMTP id p15mr6572013bkp.167.1255469645753;  Tue, 13 Oct 2009 14:34:05 -0700 (PDT)
In-Reply-To: <40aa078e0910131316s308f2bc5h8d679c59c0d5b762@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130215>


On Tue, Oct 13, 2009 at 10:16 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Tue, Oct 13, 2009 at 9:57 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> This list is sorted. Please keep it so.
> Aha, I didn't notice! Thanks, I'll fix :)

Here's the new (trivial) diff. I don't think it's worth a resend, at
least not yet.

---

diff --git a/Makefile b/Makefile
index fea237b..0d13af3 100644
--- a/Makefile
+++ b/Makefile
@@ -354,6 +354,7 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-hash-object$X
+PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-merge-tree$X
@@ -1075,7 +1076,6 @@ EXTLIBS += -lz

 ifndef NO_POSIX_ONLY_PROGRAMS
        PROGRAMS += git-daemon$X
-       PROGRAMS += git-imap-send$X
 endif
 ifndef NO_OPENSSL
        OPENSSL_LIBSSL = -lssl



-- 
Erik "kusma" Faye-Lund
