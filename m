From: Jeff King <peff@peff.net>
Subject: Re: t0008-ignores failure
Date: Wed, 29 May 2013 22:52:58 -0400
Message-ID: <20130530025258.GB19860@sigill.intra.peff.net>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com>
 <51A6A7B7.4010802@gmail.com>
 <7vzjvdp5q8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBEX6TKGQKGQEGP3C7GA@googlegroups.com Thu May 30 04:53:12 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBEX6TKGQKGQEGP3C7GA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f183.google.com ([209.85.192.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBEX6TKGQKGQEGP3C7GA@googlegroups.com>)
	id 1UhszF-0006dP-6W
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 04:53:09 +0200
Received: by mail-pd0-f183.google.com with SMTP id q11sf3120447pdj.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 May 2013 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:date:from:to:cc:subject:message-id:references
         :mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=dC2E6bFKU8avg6SULlt88mEEI/m+FrrOsbR7t1RXvHg=;
        b=kiCKm5vftwcnGzHJnxpe2ijnEbqPlZ1Knf6V7O0JNQ13Y6SH0EEmPXB/lPrnQ+TaVB
         +tGvrkTnl2JBFXK+bd6jqYp2ifd8+g894hfOEntbuV+Sro3qnG9MLjZdy/3pIvO9QQtI
         fxtuY5OjI/QfHVFV/jX6sVwDe5O8hA6L/ZOkWldcgbqYgOwvgRC8EM4sKD6IESJd7lJu
         4NK471wPLYlgPAugKEyaRkvxQs3nhPp7k6yBQXTsjT0PEbYeaRizRsA7VapgjM2Ra3T+
         WMENfsLMGE8rqUu1UPXUNFWe7MoZt0c0aYvowx4VprebkywIYtCMakbExYsM4exGr+kq
         GWIQ==
X-Received: by 10.49.83.137 with SMTP id q9mr489587qey.36.1369882387643;
        Wed, 29 May 2013 19:53:07 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.58.172 with SMTP id s12ls207462qeq.18.gmail; Wed, 29 May
 2013 19:53:06 -0700 (PDT)
X-Received: by 10.236.123.199 with SMTP id v47mr2703350yhh.21.1369882381404;
        Wed, 29 May 2013 19:53:01 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with ESMTPS id n78si2955443yhh.1.2013.05.29.19.53.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 19:53:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 8957 invoked by uid 102); 30 May 2013 02:53:41 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 21:53:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 22:52:58 -0400
In-Reply-To: <7vzjvdp5q8.fsf@alter.siamese.dyndns.org>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225914>

On Wed, May 29, 2013 at 07:21:51PM -0700, Junio C Hamano wrote:

> Karsten Blees <karsten.blees@gmail.com> writes:
> 
> > I realize colon was chosen to mimic git-check-attr, however,
> > check-attr prints relative paths only (I think?).
> >
> > How about using TAB or '|' instead? AFAICT, these are typically
> > not used in paths or glob patterns.
> 
> The primary reason to use ':' in "check-ignore -v" is to mimic the
> output format of "grep -n".
> 
> Emacs users can then run the commands like check-attr/check-ignore
> with "M-x find-grep" (or "M-x compile"), the output format is
> recognized by the editor, and the user can jump around with \C-x` to
> view hits.
> 
> I do not use vim myself, but I would be mildly surprised if there
> isn't a similar feature there.

It does (it is how my "git jump" command feeds marks to vim). Usually we
would quote ambiguous pathnames, but I think we do not here to retain
compatibility with that microformat. Readers that care about quoting
should use "-z" to get unambiguous output. And indeed, it seems that
check-ignore behaves reasonably in this case. The tests fail because the
test script itself is lazy. It does:

  sed -e 's/      "/      /' -e 's/\\//' -e 's/"$//' expected-verbose | \
        tr ":\t\n" "\0" >expected-verbose0

which generates a bogus expectation; both the delimiter colons and any
in the fields are converted, whereas only the former should be.
Karsten's fix should work, or we could generate our expected output more
carefully.

Long ago we switched to putting a space into our trash directory name to
catch problems with such pathnames when we run the test suite. I wonder
if we should do the same with ":". Doing this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ca6bdef..5d84705 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -600,7 +600,7 @@ fi
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+TRASH_DIRECTORY="trash directory:$(basename "$0" .sh)"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good

reveals the breakage on Linux. And it seems that a lot of other tests
break, too. I haven't looked into them yet, though.

-Peff

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
