From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH] gitk: make Ctrl "+" really increase the font size
Date: Fri, 11 Jan 2008 12:39:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801111238150.31053@racer.site>
References: <fm5oln$ahq$1@ger.gmane.org>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephan Hennig <mailing_list-KvP5wT2u2U0@public.gmane.org>, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Jan 11 13:40:12 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDJB9-0005xk-Os
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jan 2008 13:40:07 +0100
Received: by ug-out-1516.google.com with SMTP id 1so3031129uga.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jan 2008 04:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=kKtIJV9m/k6TH8g+WU4ITlOo4vmWY3K5FfKVmlvjH78=;
        b=IHbfkd69uclRSEu2hBEtnnm2S2CQoENbiLGJoAm52KLay06mpNDlxjn1qwSEYgAkdcnkQJsf2ITwM1Hs3kwKlzNY3Oxhhvtx6QYqXOCepPy1GLkP4osXqwLTIl09MCz2Br5z16Np2xN47qjCKk+XyonGnY9EeiPPrB2LmcQZsKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=2QlPQpoUsftDJVZCOMtar9PJWrorcrrXMMTcm1o28gayVlBtzbRSZdcBOTlWsHspjUJJlcqDosKQ3CaEu7ufjyDh4PyYkEmHIG1vR75px5WNyjUwc5ijIW0gVKgfx8HupaojnpQBTpH73M/sZMF6hILXc1zAQJHGsdR8ifW8bRQ=
Received: by 10.78.70.4 with SMTP id s4mr6281hua.23.1200055180950;
        Fri, 11 Jan 2008 04:39:40 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1367hsg;
	Fri, 11 Jan 2008 04:39:40 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.126.2 with SMTP id d2mr3731388pyn.1.1200055179969; Fri, 11 Jan 2008 04:39:39 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si1875395pye.0.2008.01.11.04.39.39; Fri, 11 Jan 2008 04:39:39 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 11 Jan 2008 12:39:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp044) with SMTP; 11 Jan 2008 13:39:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184YVY7ceA4QX99JEAdp27gpapL3bq2pMkrKS9+M8 8W+Nb5CldaXkgN
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <fm5oln$ahq$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70154>



Only Ctrl "=" was bound to increase the font size, probably because
English keyboards have the plus on the same key as the equal sign.
However, not the whole world is English, and at least with some
other keyboard layouts, Ctrl "+" did not work as documented.

Noticed by Stephan Hennig.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>

---

	On Thu, 10 Jan 2008, Stephan Hennig wrote:

	> 
	> Hi,
	> 
	> reducing font size in gitk with CTRL-- works, but enlarging font 
	> size fails.  Typing CTRL-+ just doesn't have any effect here.

	This is no bug in msysgit, but in gitk.

	Paul, please apply.

 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1da0b0a..462f6aa 100644
--- a/gitk
+++ b/gitk
@@ -996,6 +996,7 @@ proc makewindow {} {
     bind . <$M1B-r> dosearchback
     bind . <$M1B-s> dosearch
     bind . <$M1B-equal> {incrfont 1}
+    bind . <$M1B-plus> {incrfont 1}
     bind . <$M1B-KP_Add> {incrfont 1}
     bind . <$M1B-minus> {incrfont -1}
     bind . <$M1B-KP_Subtract> {incrfont -1}
