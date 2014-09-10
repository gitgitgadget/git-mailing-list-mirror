From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 2/2] wincred: improve compatibility with
 windows versions
Date: Thu, 11 Sep 2014 00:32:43 +0200
Message-ID: <CABPQNSbp92V1n_VoyKbS+qrrNuBLd3uB0br0xZDGbRM_z8k6=g@mail.gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
 <50EEAFB1.2090604@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Jeff King <peff@peff.net>
To: Karsten Blees <blees@dcon.de>
X-From: msysgit+bncBDR53PPJ7YHRBM5DYOQAKGQEW2NLA3I@googlegroups.com Thu Sep 11 00:33:25 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBM5DYOQAKGQEW2NLA3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f56.google.com ([209.85.219.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBM5DYOQAKGQEW2NLA3I@googlegroups.com>)
	id 1XRqS5-0004Dw-B8
	for gcvm-msysgit@m.gmane.org; Thu, 11 Sep 2014 00:33:25 +0200
Received: by mail-oa0-f56.google.com with SMTP id g18sf18122oah.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 10 Sep 2014 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=XLkib3qrSPZN+qqgovSwvVb73Jjxd+sN+BXALnyl5FQ=;
        b=CQ0scFwP/mfhbd7Clp3WMbTM/b2QMIQnumO9d00/SVijQJ3o9a9++64OKpuZSsloxG
         iMtITqipqcfBAzXZ29kPJtCVwX+ulYqjN6O3j5VDP42R4AOwWJzggNBwWihbcElupf7C
         NpQux0M6c/1gNH83Uj9CtpSMSEB9Vuffng626pFwf10eMdS83j1KXjqBISp4POvyb1Qt
         R58SfuZiRY49/gWPaOoyo1JRbpOz56e5yn3eQgVFwyxOiC4qHhKNTrLhfu31KjDm28Kc
         IOUTcPhUrbJ8WVAlEzQlMCcbXKSOXobe5CBUtOmxZNTuKbYzJP4+rERe0a7qiJ49blBd
         77FQ==
X-Received: by 10.50.2.6 with SMTP id 6mr67326igq.10.1410388404428;
        Wed, 10 Sep 2014 15:33:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.17.3 with SMTP id ga3ls42730igd.35.gmail; Wed, 10 Sep 2014
 15:33:23 -0700 (PDT)
X-Received: by 10.66.187.8 with SMTP id fo8mr28154534pac.32.1410388403499;
        Wed, 10 Sep 2014 15:33:23 -0700 (PDT)
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com [2607:f8b0:4001:c05::22d])
        by gmr-mx.google.com with ESMTPS id s5si293711igm.1.2014.09.10.15.33.23
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 15:33:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22d as permitted sender) client-ip=2607:f8b0:4001:c05::22d;
Received: by mail-ig0-x22d.google.com with SMTP id l13so24352iga.6
        for <msysgit@googlegroups.com>; Wed, 10 Sep 2014 15:33:23 -0700 (PDT)
X-Received: by 10.43.138.1 with SMTP id iq1mr5493423icc.11.1410388403405; Wed,
 10 Sep 2014 15:33:23 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Wed, 10 Sep 2014 15:32:43 -0700 (PDT)
In-Reply-To: <50EEAFB1.2090604@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22d
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256776>

On Thu, Jan 10, 2013 at 1:10 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>  static int match_cred(const CREDENTIALW *cred)
>  {
> -       return (!wusername || !wcscmp(wusername, cred->UserName)) &&
> -           match_attr(cred, L"git_protocol", protocol) &&
> -           match_attr(cred, L"git_host", host) &&
> -           match_attr(cred, L"git_path", path);
> +       LPCWSTR target = cred->TargetName;
> +       if (wusername && wcscmp(wusername, cred->UserName))
> +               return 0;
> +
> +       return match_part(&target, L"git", L":") &&
> +               match_part(&target, protocol, L"://") &&
> +               match_part(&target, wusername, L"@") &&

This seems to have broken credentials with '@' in the username, which
isn't all that unusual these days... :(

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
