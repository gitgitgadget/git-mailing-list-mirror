From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/5] engine.pl: Fix i18n -o option in msvc
 buildsystem generator
Date: Fri, 26 Dec 2014 18:51:04 -0000
Organization: OPDS
Message-ID: <862FFBB15AC74BD9AB675310958C6715@PhilipOakley>
References: <1419418034-6276-1-git-send-email-philipoakley@iee.org> <1419418034-6276-2-git-send-email-philipoakley@iee.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Msysgit" <msysgit@googlegroups.com>
To: "Philip Oakley" <philipoakley@iee.org>,
	"GitList" <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBF6462SAKGQETLNZMYI@googlegroups.com Fri Dec 26 19:51:04 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBF6462SAKGQETLNZMYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBF6462SAKGQETLNZMYI@googlegroups.com>)
	id 1Y4ZyZ-0003J8-VJ
	for gcvm-msysgit@m.gmane.org; Fri, 26 Dec 2014 19:51:04 +0100
Received: by mail-la0-f61.google.com with SMTP id gm9sf1018480lab.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 26 Dec 2014 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=0XTyaUwiusvJNX8gu0Rve+QGV7TKXRVrCigDarM2r4Y=;
        b=EIAEs0uXDBL37SRuRK81KD9/FmHzdJEqWwqEERZ9J3BqxzHqLEf+BvTIBYnmmR7FQd
         VswqjKZb+cFA1L8NBg/ahFQ+Y9UJPHU6Dq/HSwvrzUz0x2imqwPQK/ahF7xxBnSidnHK
         OjMXjbnWO2tXAST0P+mdCymB/jCptHu+T9tURNwVudJIDwfhBWVkIo6hq5ai2sbb5peW
         wfV4gdt6cPDBD13d+w6VM0QwP1Uu2dZEPvn9oX2Wktt+jbzf4xANHsWBIoXORpZGFJW/
         imDDPsoSkDhUtWOPMis9wDTArd809OEpIYAXbdM+cMb960hPKQ1mEpLj1h0OWF5o/Dw4
         bfYg==
X-Received: by 10.180.80.168 with SMTP id s8mr228127wix.8.1419619863631;
        Fri, 26 Dec 2014 10:51:03 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.29.2 with SMTP id js2ls1309683wid.53.gmail; Fri, 26 Dec
 2014 10:51:02 -0800 (PST)
X-Received: by 10.194.77.1 with SMTP id o1mr2204483wjw.1.1419619862808;
        Fri, 26 Dec 2014 10:51:02 -0800 (PST)
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net. [62.24.128.240])
        by gmr-mx.google.com with ESMTP id m5si1504850wiz.2.2014.12.26.10.51.02
        for <msysgit@googlegroups.com>;
        Fri, 26 Dec 2014 10:51:02 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.240 as permitted sender) client-ip=62.24.128.240;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArISAPCsnVQCYJmQPGdsb2JhbABcgwZSTgqGL2y/SoVzBAKBCxcBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMGAQ0GARIIAgECAwEKiAkMunaOQwELAR+Pd4MdgRMBBIkhhHRNgnKGcY9GTYQQPjGCQwEBAQ
X-IPAS-Result: ArISAPCsnVQCYJmQPGdsb2JhbABcgwZSTgqGL2y/SoVzBAKBCxcBAQEBAQEFAQEBATggG4QHBQEBAQECAQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMGAQ0GARIIAgECAwEKiAkMunaOQwELAR+Pd4MdgRMBBIkhhHRNgnKGcY9GTYQQPjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,648,1413241200"; 
   d="scan'208";a="480583310"
Received: from host-2-96-153-144.as13285.net (HELO PhilipOakley) ([2.96.153.144])
  by out1.ip04ir2.opaltelecom.net with SMTP; 26 Dec 2014 18:51:02 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.240 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261829>

From: "Philip Oakley" <philipoakley@iee.org>
> The i18n 5e9637c (i18n: add infrastructure for translating
> Git with gettext, 2011-11-18) introduced an extra '-o' option
> into the make file, which broke engine.pl code for extracting
> the git.sln for msvc gui-IDE.
>
> Add tests to remove these non linker options, in same vein as
> 74cf9bd (engine.pl: Fix a recent breakage of the buildsystem
> generator, 2010-01-22).

It now looks like this resolution is in the wrong direction. The
correct right solution is to include
    NO_GETTEXT = YesPlease
into the _Windows_ section of the Makefile.

Mysgit uses the _MinGW_ section, and fixed the NO_GETTEXT requirement, 
so the breakage in the Windows section build wasn't noticed.

However, the test is still useful for adding a detection step and 
providing a warning to users
    NO_GETTEXT = YesPlease

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> contrib/buildsystems/engine.pl | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/contrib/buildsystems/engine.pl 
> b/contrib/buildsystems/engine.pl
> index 23da787..f48c28a 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -140,6 +140,12 @@ sub parseMakeOutput
>             next;
>         }
>
> +        if ($text =~ /^(mkdir|msgfmt) /) {
> +            # options to the Portable Object translations
> +            # the line "mkdir ... && msgfmt ..." contains no linker 
> options
> +            next;
> +        }
> +
>         if($text =~ / -c /) {
>             # compilation
>             handleCompileLine($text, $line);
> -- 

There are still more issues to be resolved e.g.
  test-svn-fe.obj : error LNK2001: unresolved external symbol _strtoull
 etc.
Philip 

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
