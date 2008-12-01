From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 01 Dec 2008 10:06:42 +0100
Message-ID: <4933A922.7080300@viscovery.net>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
Reply-To: j.sixt@viscovery.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: dhruva <dhruvakm@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Dec 01 10:08:04 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L74l9-0006e6-PF
	for gcvm-msysgit@m.gmane.org; Mon, 01 Dec 2008 10:08:03 +0100
Received: by yx-out-2122.google.com with SMTP id 22so691886yxm.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 01 Dec 2008 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:x-spam-report:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=SdjeXqx931g8u4WwnbsnUzM/I18o6qUQu58q5uk53Wc=;
        b=RL5aslGtZsuxu50b0PI1pmphh3J48zc8sdYz0zw+vs5LtmWMTq0mgKTpKrY+LT6oFb
         bCDxPg08bCKBNWlNSD5U6ytg/n2QqxO+lhG2rWcLNqQKcCAUvqJQtovbFasP9g+K2NkI
         NUdz6ndpXM04mRRG4DnS+1PX+lf3awhT3YN4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-spam-score:x-spam-report:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=5sur1PJ7aSsYNdxqUTswX40q48WAFRXoE4Aa8hYG0uhp0Vh6PJzU97DyMKmODTJTgd
         DyzipcPinVD3h/OB1Kp9ToBxXbq/qK28VydHOJDfTT00+Hm3XORdsEngh5qEfKDa6Km9
         fQrw+QHnlflx/d/3wmQF9V1Y95/j0QuW67xvM=
Received: by 10.90.78.14 with SMTP id a14mr939759agb.5.1228122405652;
        Mon, 01 Dec 2008 01:06:45 -0800 (PST)
Received: by 10.230.7.197 with SMTP id e5gr3188vbe.0;
	Mon, 01 Dec 2008 01:06:45 -0800 (PST)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.52.1 with SMTP id z1mr3922182agz.21.1228122404116; Mon, 01 Dec 2008 01:06:44 -0800 (PST)
Received: from lilzmailso01.liwest.at (lilzmailso01.liwest.at [212.33.55.23]) by mx.google.com with ESMTP id 22si5473375yxr.1.2008.12.01.01.06.43; Mon, 01 Dec 2008 01:06:43 -0800 (PST)
Received-SPF: neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.23;
Authentication-Results: mx.google.com; spf=neutral (google.com: 212.33.55.23 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com) by lilzmailso01.liwest.at with esmtpa (Exim 4.69) (envelope-from <j.sixt@viscovery.net>) id 1L74jq-0004J7-1N; Mon, 01 Dec 2008 10:06:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96]) by linz.eudaptics.com (Postfix) with ESMTP id C887569F; Mon,  1 Dec 2008 10:06:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has identified this incoming email as possible spam.  The original message has been attached to this so you can view it (if it isn't spam) or label similar future email.  If you have any questions, see the administrator of that system for details. Content preview:  dhruva schrieb: > Hello, > I build git on msys environment regularly. With the recent changes to > add cache preload facility (commit ID: > 671c9b7e315db89081cc69f83a8f405e4aca37bc) brings in dependency on > pthreads. This is not available in the msys distribution which was > part of the git build distro. I installed libpthread for mingw to get > the related headers and libraries. I had to make some minor changes to > libpthread installation.
  I copied the 'setjmp.h' from my other mingw > installation and had to had edit it to remove some mingw specific > macros. > > @:/e/users/dhruva/stub/repo/git/git > [520]$ diff -u /e/tools/gnu/include/setjmp.h /mingw/include/setjmp.h > --- /e/tools/gnu/include/setjmp.h Sun Oct 5 04:01:15 2008 > +++ /mingw/include/setjmp.h Sun Nov 30 16:18:00 2008 > @@ -36,7 +36,7 @@ > * The function provided by CRTDLL which appears to do the actual work > * of setjmp. > */ > -_CRTIMP int __cdecl __MINGW_NOTHROW _setjmp (jmp_buf); > +int __cdecl _setjmp (jmp_buf); > > #define setjmp(x) _setjmp(x) > > @@ -44,7 +44,7 @@ > * Return to the last setjmp call and act as if setjmp had returned > * nVal (which had better be non-zero!). > */ > -_CRTIMP void __cdecl __MINGW_NOTHROW longjmp (jmp_buf, int) > __MINGW_A
 TTRIB_NORETURN; > +void __cdecl longjmp (jmp_buf, int); > > #ifdef __cplusplus > } > > Also, > had to copy a pthread library with a dfferent name to the standard name: > $cp libpthreadGC2.a libpthread.a > > The build went fine and am using the new binaries. [...]  Content analysis details:   (-1.4 points, 7.0 required) pts rule name              description ---- ---------------------- -------------------------------------------------- -1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102005>


dhruva schrieb:
> Hello,
>  I build git on msys environment regularly. With the recent changes to
> add cache preload facility (commit ID:
> 671c9b7e315db89081cc69f83a8f405e4aca37bc) brings in dependency on
> pthreads. This is not available in the msys distribution which was
> part of the git build distro. I installed libpthread for mingw to get
> the related headers and libraries. I had to make some minor changes to
> libpthread installation. I copied the 'setjmp.h' from my other mingw
> installation and had to had edit it to remove some mingw specific
> macros.
> 
> @:/e/users/dhruva/stub/repo/git/git
> [520]$ diff -u /e/tools/gnu/include/setjmp.h /mingw/include/setjmp.h
> --- /e/tools/gnu/include/setjmp.h       Sun Oct  5 04:01:15 2008
> +++ /mingw/include/setjmp.h     Sun Nov 30 16:18:00 2008
> @@ -36,7 +36,7 @@
>   * The function provided by CRTDLL which appears to do the actual work
>   * of setjmp.
>   */
> -_CRTIMP int __cdecl __MINGW_NOTHROW _setjmp (jmp_buf);
> +int __cdecl _setjmp (jmp_buf);
> 
>  #define        setjmp(x)       _setjmp(x)
> 
> @@ -44,7 +44,7 @@
>   * Return to the last setjmp call and act as if setjmp had returned
>   * nVal (which had better be non-zero!).
>   */
> -_CRTIMP void __cdecl __MINGW_NOTHROW longjmp (jmp_buf, int)
> __MINGW_ATTRIB_NORETURN;
> +void __cdecl longjmp (jmp_buf, int);
> 
>  #ifdef __cplusplus
>  }
> 
> Also,
>  had to copy a pthread library with a dfferent name to the standard name:
> $cp libpthreadGC2.a libpthread.a
> 
> The build went fine and am using the new binaries.

Would you please push your addition to the mob branch of
git://repo.or.cz/msysgit.git? The push URL is repo.or.cz:/srv/git/msysgit.git

(But notice that some commits are on the mob branch currently that are not
in any other branch; hence, you better build on top of them so that they
are not lost when you push to mob.)

-- Hannes
