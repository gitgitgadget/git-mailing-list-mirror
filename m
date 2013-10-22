From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Re: Windows performance / threading file access
Date: Tue, 22 Oct 2013 16:49:30 +0200
Message-ID: <CAHGBnuOVpMU6wBmjesYK7qWWpKPyCFhmDcWny7MN5nM4zYFjDA@mail.gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
	<52570BC1.2040208@gmail.com>
	<52574B90.3070309@gmail.com>
	<CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>
	<3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com>
	<52601562.2090301@gmail.com>
	<49cde110-f3e5-43d9-b399-6b5a6ce59014@googlegroups.com>
	<52668C0F.9050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: pro-logic <pro-logic@optusnet.com.au>, 
	msysGit Mailinglist <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>, szager@google.com
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDZMLEGXWQLBB7FATKJQKGQEKTMFNIY@googlegroups.com Tue Oct 22 16:49:35 2013
Return-path: <msysgit+bncBDZMLEGXWQLBB7FATKJQKGQEKTMFNIY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBB7FATKJQKGQEKTMFNIY@googlegroups.com>)
	id 1VYdH3-0003Lh-5f
	for gcvm-msysgit@m.gmane.org; Tue, 22 Oct 2013 16:49:33 +0200
Received: by mail-lb0-f184.google.com with SMTP id u14sf555624lbd.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Oct 2013 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=8q0/JekXGTXxz9xH6AXARPiMhVjGXO/EbJePZYfRglA=;
        b=WIMhzGgRAi7PyR3hRcBDq7qokazDfYXrj3d9qCMqdifRa4hXTby0IhsUpngRV+XqKG
         5ehmUpYbWEvY4pGXZghu/zpc6KksLwE9mgr2bPgLV0VvGFcckHyBeUPu4zU8zIAqoGQ/
         rEkO9Dz6d6L99eumncNjKr4itzXLnoYkTBCjJeE+rXyYj768zlz64iUARCpT0jQfoNF6
         rW8UkhvL6SMtmiwKOVC7jdPaFXDNtCcr0UgpcTUK5bTTi9UUIkCMSD9Uvp7ol62zOUnT
         KfkAfonwiqDafKZS/OGYpVrNOMrMGvwN1yw7J6WUxGO52IrN48XCgLy99ZAyDLlCV3Mo
         b5lA==
X-Received: by 10.180.20.239 with SMTP id q15mr208505wie.5.1382453372913;
        Tue, 22 Oct 2013 07:49:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.71 with SMTP id s7ls698999wif.17.canary; Tue, 22 Oct
 2013 07:49:32 -0700 (PDT)
X-Received: by 10.204.238.194 with SMTP id kt2mr4128373bkb.6.1382453371966;
        Tue, 22 Oct 2013 07:49:31 -0700 (PDT)
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com [2a00:1450:4010:c03::22f])
        by gmr-mx.google.com with ESMTPS id ja10si1675308bkb.2.2013.10.22.07.49.30
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 07:49:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::22f as permitted sender) client-ip=2a00:1450:4010:c03::22f;
Received: by mail-la0-x22f.google.com with SMTP id ep20so3988356lab.20
        for <msysgit@googlegroups.com>; Tue, 22 Oct 2013 07:49:30 -0700 (PDT)
X-Received: by 10.112.130.138 with SMTP id oe10mr17259546lbb.1.1382453370161;
 Tue, 22 Oct 2013 07:49:30 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 22 Oct 2013 07:49:30 -0700 (PDT)
In-Reply-To: <52668C0F.9050702@gmail.com>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::22f
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236474>

On Tue, Oct 22, 2013 at 4:30 PM, Karsten Blees <karsten.blees@gmail.com> wrote:

>>> Could you post details about your test setup? Are you still using
>>> WebKit for your tests?
>> I'm on Win7 x64, Core i5 M560, WD 7200 Laptop HDD, NTSF, no virus
>> scanner, truecrypt, no defragger.
>>
>
> OK, so truecrypt and luafv may screw things up for you (according to my measurements, luafv roughly doubles lstat times on C:).

Aren't we disabling UAC / LUAFV on a per-executable basis using
manifests? At least the blog article at [1] suggests that we are in
fact doing it the right way using our script to genera the manifests
[2].

Oh but wait, we're not generating a manifest for git.exe itself, only
for executables that contain "setup", "install", "update", "patch"
etc. So maybe having a manifest for git.exe, too, would improve
performance?

[1] http://blogs.msdn.com/b/alexcarp/archive/2009/06/25/the-deal-with-luafv-sys.aspx
[2] https://github.com/msysgit/msysgit/blob/master/share/msysGit/make-manifests.sh

-- 
Sebastian Schuberth

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
