From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 6 Jun 2014 13:10:28 +0200
Organization: <)><
Message-ID: <20140606111028.GA1909@camelia.ucw.cz>
References: <20140605080519.GB28029@camelia.ucw.cz> <5390A139.2090406@kdbg.org> <5390E893.9060600@gmail.com> <20140606083233.GB1303@camelia.ucw.cz> <53918D27.7060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>,
        msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBJODY2OAKGQEEIYXO5Y@googlegroups.com Fri Jun 06 13:10:31 2014
Return-path: <msysgit+bncBCU63DXMWULRBJODY2OAKGQEEIYXO5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBJODY2OAKGQEEIYXO5Y@googlegroups.com>)
	id 1Wss2Y-0008Ef-E8
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 13:10:30 +0200
Received: by mail-wi0-f184.google.com with SMTP id d1sf87097wiv.11
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 04:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=6LZuLie7e6XgEaS0jL95tdMcJl6vAnvgeB/Ilu5qGNk=;
        b=otl+i6dUzzzn71GYbU5fw9Wk663EdiO/R3mUJbh52ghwnIqKOi/s7eLLaFdOQpSwGG
         JVc9dh8qmZ3n8kW8UH2NklZDTdsgfM50btSNXJQGHodI11coFrlLBuzR7xfpaqqsnpa/
         PvfLVXNx8CkWdtjN/Ty82Q+1THnUpZTgtCxxqek28B9VzE59ga3Ni1onHS1DdqA3dttK
         6jCfyjeuSo5esvbETQx5G6yluGZMURFkMzuzsqYFg9XR0fTBdGrl3qQ4ljMWLEpSZ+Vx
         zVPQU6psOyNlebtR3TdTBatJmGntD9zqHGGG3akAoNcX9x0UBVx9m5RMNayq7Tg7hq1m
         aW1w==
X-Received: by 10.180.90.51 with SMTP id bt19mr11841wib.6.1402053030156;
        Fri, 06 Jun 2014 04:10:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.76.75 with SMTP id i11ls78320wiw.16.canary; Fri, 06 Jun
 2014 04:10:29 -0700 (PDT)
X-Received: by 10.180.211.114 with SMTP id nb18mr806022wic.4.1402053029203;
        Fri, 06 Jun 2014 04:10:29 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id h4si1874538wib.2.2014.06.06.04.10.29
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 04:10:29 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id CA9B31C009F;
	Fri,  6 Jun 2014 13:10:28 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s56BASLO001984;
	Fri, 6 Jun 2014 13:10:28 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s56BAStb001983;
	Fri, 6 Jun 2014 13:10:28 +0200
In-Reply-To: <53918D27.7060604@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250899>

Hi Karsten,

On Fri, Jun 06, 2014 at 11:43:03AM +0200, Karsten Blees wrote:
> [...] Assume all other callers are written
> 'mingw_foo', as suggested by Hannes, and no one except 'mingw_foo'
> has the need to call MSVCRT's 'foo' directly. Then its irrelevant
> whether the #undef is at the top or immediately before 'mingw_foo'.

Yet there is still danger that someone calls foo() by mistake.
It is still best to have a protection:
#define foo choke_here_do_not_use_this

> Thinking about this some more, the best solution is probably to
> eliminate the problem altogether by adding inline-wrappers for
> required CRT-functions, e.g.:

Yes, this is acceptable.  But I wouldn't pollute mingw.h.  You can do
it on top of mingw.c like this:

#undef gethostname
static inline int crt_gethostname(char *host, int namelen)
{
	return gethostname(host, namelen);
}
#define gethostname please_call_the_mingw_or_crt_version

This would also be an acceptable solution, though I still prefer my
solution, because, as you put it:
> Having the #undef in close vicinity of the function definition
> helps removing it when it's no longer needed.

Stepan

PS: Anyway, this is another patch which I can mark as "too much
discussion, try later."  Then I can proceed and submit your unicode
branch.

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
