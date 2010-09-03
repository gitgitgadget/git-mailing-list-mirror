From: karsten.blees@dcon.de
Subject: Re: [PATCH] Fix compat/regex ANSIfication on MinGW
Date: Fri, 3 Sep 2010 23:23:32 +0200
Message-ID: <OFF09696E1.DC0D98D7-ONC1257793.0070A82E-C1257793.00758522@DCON.DE>
References: <4C761EA2.2060904@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=_alternative 00758521C1257793_="
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	msysgit@googlegroups.com,
	johannes.schindelin@gmx.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncCAAQwdKF5AQaBAl8CBM@googlegroups.com Fri Sep 03 23:32:09 2010
Return-path: <msysgit+bncCAAQwdKF5AQaBAl8CBM@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCAAQwdKF5AQaBAl8CBM@googlegroups.com>)
	id 1Ordrl-0002a3-1x
	for gcvm-msysgit@m.gmane.org; Fri, 03 Sep 2010 23:32:09 +0200
Received: by qyk5 with SMTP id 5sf553059qyk.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 03 Sep 2010 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:in-reply-to:from:to:cc:subject
         :mime-version:x-mailer:message-id:sender:date:x-mimetrack
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe:content-type;
        bh=chU3CCZahLwzD19iNcEWRtkXzKRtbzB11Ec9/mZoRwg=;
        b=O25Juc2HN5J6uJECCw3IyWV1sIYZ5plkd3WIMgLCrzWKnfj2H08mzBeqMfxX3F6QOk
         AH2Agq24UZjg1yxELfhc4F+ILlmUqDF/gCWROVyFmhUe1aLftTl9PAsi9XQ68n6rxNPG
         va5XhgQcsr3d6oVcXebTzbVH3Gr3+TF7fzopU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:in-reply-to:from:to:cc:subject
         :mime-version:x-mailer:message-id:sender:date:x-mimetrack
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe:content-type;
        b=Yxpyl4MknrySE6yv7NmXIGyy+rmXqEhsvc5Qz9oaiNA97PJ5RpdG0URU/+94D60x3i
         1wLpjY8wLl8GL6LsXXD4QdpWNZQKrTTsG3v9lIG5QdAn13LrO3DZU3nECeeizo7Xw1zz
         L37XdwSYAiCdOPXUDmkWPdmm4nK/QZ+8rpnAU=
Received: by 10.224.75.78 with SMTP id x14mr28006qaj.18.1283549505320;
        Fri, 03 Sep 2010 14:31:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.58.228 with SMTP id i36ls440956qah.4.p; Fri, 03 Sep 2010
 14:31:44 -0700 (PDT)
Received: by 10.224.37.14 with SMTP id v14mr46382qad.3.1283549504487;
        Fri, 03 Sep 2010 14:31:44 -0700 (PDT)
Received: by 10.204.85.89 with SMTP id n25mr48954bkl.20.1283549014417;
        Fri, 03 Sep 2010 14:23:34 -0700 (PDT)
Received: by 10.204.85.89 with SMTP id n25mr48953bkl.20.1283549014382;
        Fri, 03 Sep 2010 14:23:34 -0700 (PDT)
Received: from DCON14.DCON.DE (231-068-043-212.ip-addr.inexio.net [212.43.68.231])
        by gmr-mx.google.com with ESMTP id z25si1223663bku.1.2010.09.03.14.23.34;
        Fri, 03 Sep 2010 14:23:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@dcon.de designates 212.43.68.231 as permitted sender) client-ip=212.43.68.231;
In-Reply-To: <4C761EA2.2060904@viscovery.net>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
Sender: msysgit@googlegroups.com
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 03.09.2010 23:23:33,
	Serialize complete at 03.09.2010 23:23:33
X-Original-Sender: karsten.blees@dcon.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@dcon.de designates 212.43.68.231 as permitted sender) smtp.mail=karsten.blees@dcon.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155274>

This is a multipart message in MIME format.
--=_alternative 00758521C1257793_=
Content-Type: text/plain; charset="US-ASCII"

Johannes Sixt <j.sixt@viscovery.net> wrote on 26.08.2010 09:58:26:
> Am 8/25/2010 20:24, schrieb Karsten Blees:
> > this doesn't compile if internal_function is #defined non-empty (e.g. 
on
> > mingw/msysgit). The old-style definitions work.
> > 
> > In file included from compat/regex/regex.c:78:
> > compat/regex/regexec.c:357: error: conflicting types for 
're_search_2_stub'
> > compat/regex/regexec.c:44: note: previous declaration of 
> 're_search_2_stub' was
> > here
> 
> Here's a fix.
> 

Sorry, I realize I should've cross-posted this to the msysgit list (adding 
cc).

In the meantime, Dscho has fixed the function definitions in the msysgit 
fork like so:
static int internal_function
re_search_2_stub (struct re_pattern_buffer *bufp,...

Your patch removes internal_function from the declaration, so now it 
doesn't compile again...

There're basically three solutions:
1. revert the whole ANSIfication stuff (stay in sync with glibc upstream)
2. add internal_function before function definition (like everywhere else 
in regexec.c - efe33c61 in git://repo.or.cz/git/mingw/4msysgit.git)
3. remove internal_function from declaration (ce518bbd)

As I don't think you plan active development on this (or push changes 
upstream?), I'd opt for (1).

Bye,
Karsten

--=_alternative 00758521C1257793_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Johannes Sixt &lt;j.sixt@viscovery.net&gt; wrote on
26.08.2010 09:58:26:<br>
&gt; Am 8/25/2010 20:24, schrieb Karsten Blees:<br>
&gt; &gt; this doesn't compile if internal_function is #defined non-empty
(e.g. on<br>
&gt; &gt; mingw/msysgit). The old-style definitions work.<br>
&gt; &gt; <br>
&gt; &gt; In file included from compat/regex/regex.c:78:<br>
&gt; &gt; compat/regex/regexec.c:357: error: conflicting types for 're_search_2_stub'<br>
&gt; &gt; compat/regex/regexec.c:44: note: previous declaration of <br>
&gt; 're_search_2_stub' was<br>
&gt; &gt; here<br>
&gt; <br>
&gt; Here's a fix.<br>
&gt; <br>
</font></tt>
<br><tt><font size=2>Sorry, I realize I should've cross-posted this to
the msysgit list (adding cc).</font></tt>
<br>
<br><tt><font size=2>In the meantime, Dscho has fixed the function definitions
in the msysgit fork like so:</font></tt>
<br><tt><font size=2>static int internal_function</font></tt>
<br><tt><font size=2>re_search_2_stub (struct re_pattern_buffer *bufp,...</font></tt>
<br>
<br><tt><font size=2>Your patch removes internal_function from the declaration,
so now it doesn't compile again...</font></tt>
<br>
<br><tt><font size=2>There're basically three solutions:</font></tt>
<br><tt><font size=2>1. revert the whole ANSIfication stuff (stay in sync
with glibc upstream)</font></tt>
<br><tt><font size=2>2. add internal_function before function definition
(like everywhere else in regexec.c - efe33c61 in git://repo.or.cz/git/mingw/4msysgit.git)</font></tt>
<br><tt><font size=2>3. remove internal_function from declaration (ce518bbd)</font></tt>
<br>
<br><tt><font size=2>As I don't think you plan active development on this
(or push changes upstream?), I'd opt for (1).</font></tt>
<br>
<br><tt><font size=2>Bye,</font></tt>
<br><tt><font size=2>Karsten</font></tt>
<br>
--=_alternative 00758521C1257793_=--
