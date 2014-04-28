From: "'Dave Borowitz <dborowitz@google.com>' via msysGit" <msysgit@googlegroups.com>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 11:39:43 -0700
Message-ID: <CAD0k6qSUYANxbjjbE4jTW4EeVwOYgBD=bXkSu=akiYC_CB7Ffw@mail.gmail.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <xmqqsioxqp9i.fsf@gitster.dls.corp.google.com>
Reply-To: Dave Borowitz <dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Marat Radchenko <marat@slonopotamus.org>, 
	msysGit <msysgit@googlegroups.com>, Pat Thoyts <patthoyts@gmail.com>, 
	Nick Hengeveld <nickh@reactrix.com>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBC64RC4WYIKBBMGK7KNAKGQEB73O56I@googlegroups.com Mon Apr 28 21:00:02 2014
Return-path: <msysgit+bncBC64RC4WYIKBBMGK7KNAKGQEB73O56I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC64RC4WYIKBBMGK7KNAKGQEB73O56I@googlegroups.com>)
	id 1WeqmX-0002Qx-NE
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 21:00:01 +0200
Received: by mail-wg0-f60.google.com with SMTP id x13sf155077wgg.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:reply-to:content-type;
        bh=8raQ/0hX+28j1eabz6riDYWyT+v1taViPf9fKyEs/fg=;
        b=FaiAUCIAWJ/DeAghEYDFwhacYp47hwnb25hsJp+/6vfNT23rRLVxi6bje4ughFdXUH
         vnon6WWuDN8c3h+G8G2BulrmwdkuC+EsRpIoIc9TybnVXyTyluy4Fzk/OQAo5uiBUwR+
         eIZePBlxFVbRrEQUMbPSkesB8FEnU2liyTGDU1lIygm5GFl6D5lwa43a6T4y2I+XAGTO
         biTKb+Auci3lhBvkZNRnc9JYv2EnOjnCPAP2De8f7XDxZNb1YjJ06xMmWP+x2r0IlKzA
         uRU6fnUe8nri7QAISE0cGWu8Fru0cqLutrcD0I8xrVcE6x9diW4gDpDolRlfOIMGi/FN
         AJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:reply-to:content-type;
        bh=8raQ/0hX+28j1eabz6riDYWyT+v1taViPf9fKyEs/fg=;
        b=ig+pRX7ci1TpWLJQr77XVfbozwyMoyeQgnYSKG/4A80Kr1IUQw9YokKngJZg6VmrYr
         1h7+kbFLFFrV/Vft54gfmGU/kXx3zFhStWN0owfZFByO3gp+EVCGCjCwg3vEIVoCnIzO
         75VbwXSMQoh0l04DUKYdni4mLt3F2Abg3eHTjL0ecZKdQ2fKJpRrrd5xQy3x+zicb1/4
         FTMCLp3ZzL7qLRU1pJFIaOqhZ7HyLQzdSiWeQ/KamE3G7bkbv5HqX+SR2j7NMT4E9JFh
         nOL3G/8qTOTTiKZSoDcIfzgnARZ/vikrHZwJ5F5r5RheUZ4ms7SnzTiPt6LHpL4Kmp9J
         5CTw==
X-Received: by 10.152.198.69 with SMTP id ja5mr33418lac.8.1398711601334;
        Mon, 28 Apr 2014 12:00:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.130 with SMTP id v2ls132806lae.74.gmail; Mon, 28 Apr
 2014 12:00:00 -0700 (PDT)
X-Received: by 10.152.45.97 with SMTP id l1mr12433lam.9.1398711600304;
        Mon, 28 Apr 2014 12:00:00 -0700 (PDT)
Received: by 10.194.51.226 with SMTP id n2mswjo;
        Mon, 28 Apr 2014 11:40:04 -0700 (PDT)
X-Received: by 10.112.180.73 with SMTP id dm9mr2289277lbc.2.1398710404382;
        Mon, 28 Apr 2014 11:40:04 -0700 (PDT)
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com [2a00:1450:4010:c03::22b])
        by gmr-mx.google.com with ESMTPS id u49si555312eeo.1.2014.04.28.11.40.04
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 11:40:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of dborowitz@google.com designates 2a00:1450:4010:c03::22b as permitted sender) client-ip=2a00:1450:4010:c03::22b;
Received: by mail-la0-f43.google.com with SMTP id c6so5446095lan.30
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 11:40:03 -0700 (PDT)
X-Gm-Message-State: ALoCoQkSuSD7GuXx++KfkOQTVImtN0q1Yi6eg4XPmLBTLnKUJ1+NZ/bnepNxVTs5ap433ZWa9UdRYflMFW/sYsEVQIbDxAXt+/9SX53WbjsY/BVsg/D0jskOeIg8A4GDYpmB5hh6IpfpAAwMhPGukkwaR2z7Xb9UgM/t4yqrR1xbeVB0cQqoXdo1OhmdU9joJClY/NKNBzq+SmmwkllPERfvFh3m+Rhepg==
X-Received: by 10.152.22.37 with SMTP id a5mr20486098laf.4.1398710403730; Mon,
 28 Apr 2014 11:40:03 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 11:39:43 -0700 (PDT)
In-Reply-To: <xmqqsioxqp9i.fsf@gitster.dls.corp.google.com>
X-Original-Sender: dborowitz@google.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of dborowitz@google.com designates 2a00:1450:4010:c03::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247384>

On Mon, Apr 28, 2014 at 11:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> We're using Curl 7.30.0 in msysGit (and thus also Git for Windows), so
>> we should be able to include it. However, we do not have curl-config
>> installed.
>
> Hmmm, between 2.0-rc0 and 2.0-rc1 there is 61a64fff (Makefile: use
> curl-config to determine curl flags, 2014-04-15) merged already,
> which makes this assumption and a claim based on that assumption:
>
>     curl-config should always be installed alongside a curl
>     distribution, and its purpose is to provide flags for building
>     against libcurl, so use it instead of guessing flags and
>     dependent libraries.
>
> which may make things worse for you guys, unless you are explicitly
> setting CURLDIR and other Makefile variables.

Yes, I can see that assumption may not always hold. But I'm slightly
surprised this worked in the first place; are you saying this is a
system where:
-curl-config is not installed
-but -lcurl still works
-without setting CURLDIR
?

I think I should probably re-roll the patch to default to the old
behavior (blind -lcurl) if curl-config returns the empty string, which
I believe is also the case when the binary is not found.

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
