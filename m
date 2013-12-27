From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 22:14:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info> <20131227210447.GE20443@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBL6366KQKGQEYPPOGEA@googlegroups.com Fri Dec 27 22:14:26 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBL6366KQKGQEYPPOGEA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f185.google.com ([209.85.215.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBL6366KQKGQEYPPOGEA@googlegroups.com>)
	id 1Vwejg-0005gz-Q8
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 22:14:24 +0100
Received: by mail-ea0-f185.google.com with SMTP id r15sf742490ead.22
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 13:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=mjtLuaBSyu8/fL7usEitHaPrpnSNCNL/EqIp5GyMRQg=;
        b=qnaWHL+05F7d9kClHMGcW8xXYLQcBXIavtfB/Da3towvJOx4npaaJvNXjoULBptor5
         6a/6xJVsAAdo9iy7O1aWcmOnbrt802DmLJkzcZACPOZ3EgJ7jeauerv7dWqJuYU7UQqh
         D/sQQ5lf+NVO7qZqwBvxW2HV/cnX+sGTSc9Nx+81Kn9i9sLo0nHKOhyi0Iag8e+bcCWc
         k97/iRwaDjJH8LHIusLh9jzMCT+wHv7qqUKSWZKTLXtLdv2O4nQG/yEJ0oXCFZmcEM8H
         cLQKeCqf/xHbzSqiqNpXZzhI/i/6m/91pHACxI2gzbhHM4Nb/wtUxuTdsZJPp/QFe4sr
         amxw==
X-Received: by 10.180.89.227 with SMTP id br3mr244621wib.15.1388178864462;
        Fri, 27 Dec 2013 13:14:24 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.109.33 with SMTP id hp1ls1241339wib.50.gmail; Fri, 27 Dec
 2013 13:14:23 -0800 (PST)
X-Received: by 10.15.51.132 with SMTP id n4mr18983678eew.3.1388178863437;
        Fri, 27 Dec 2013 13:14:23 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id b3si1458388eez.0.2013.12.27.13.14.23
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2013 13:14:23 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MPUZ7-1VrzuJ3yLZ-004g1v
 for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 22:14:23 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20131227210447.GE20443@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:K7w+uEROgzdX7BaxOQUD8FTD9z6/CmYLY7CWsWfrH2t3OFiUvXI
 GJ6jNRifQIWwSAUMAsTQY6AyUACDiU20mccScimwgxyD9xfaOZdp+2mDmKxo0yY9rsPg8A1
 r7Dt1YipUaJEOJ4qfmFRSKnr/5B6dYdPtKWxgBbg6yTddPLHk8qrDQRn1b0DhVeS9Pxa3ra
 Y++QG6KMjVGQEXxBQ4D/g==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239747>

Hi,

On Fri, 27 Dec 2013, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> [...]
> > ---
> >  builtin/blame.c |  8 ++++----
> >  commit.c        | 10 +++++-----
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> Is this easy to reproduce so some interested but lazy person could
> write a test?

Yep. Make 25 orphan commits, add a graft line to make the first a merge of
the rest.

> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -1804,17 +1804,17 @@ static int prepare_lines(struct scoreboard *sb)
> >  static int read_ancestry(const char *graft_file)
> >  {
> >  	FILE *fp = fopen(graft_file, "r");
> > -	char buf[1024];
> > +	struct strbuf buf = STRBUF_INIT;
> >  	if (!fp)
> >  		return -1;
> > -	while (fgets(buf, sizeof(buf), fp)) {
> > +	while (!strbuf_getwholeline(&buf, fp, '\n')) {
> 
> If there is no newline at EOF, this will skip the last line, while the
> old behavior was to pay attention to it.  I haven't thought through
> whether that's a good or bad change.  Maybe it should just be
> documented?

The way I read

	int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
	{
		int ch;

		if (feof(fp))
			return EOF;

		strbuf_reset(sb);
		while ((ch = fgetc(fp)) != EOF) {
			strbuf_grow(sb, 1);
			sb->buf[sb->len++] = ch;
			if (ch == term)
				break;
		}
		if (ch == EOF && sb->len == 0)
			return EOF;

		sb->buf[sb->len] = '\0';
		return 0;
	}

it returns EOF only if ch == EOF *and* sb->len == 0, i.e. if no characters
have been read before hitting EOF.

In other words, strbuf_getwholeline() -- despite requiring an explicit
terminating character argument -- does not require the last line to end
with that terminating character.

A quick test (in my case, because I am lazy, modifying test-mergesort.c to
output the lines that were read by strbuf_getwholeline()) also confirms my
suspicion.

Or maybe I missed something?

Ciao,
Dscho

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
