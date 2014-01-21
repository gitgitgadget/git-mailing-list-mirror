From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Consecutive git gc fails on Windows network share
Date: Tue, 21 Jan 2014 18:03:30 +0100
Message-ID: <CABPQNSZ5F5osOJzBbA7Q1Rbr2fcoJ7E_ZQwbQeVJwAd_3s1vvg@mail.gmail.com>
References: <d10603d6-7740-44f8-909f-7ba1ea77d3a2@googlegroups.com>
 <52D9701F.5070009@web.de> <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com>
 <52DD59E0.4090301@web.de> <alpine.DEB.1.00.1401210002080.14982@s15462909.onlinehome-server.info>
 <CABPQNSafcpACtWGBenE8vAe_XEvJ=5_sxLw8PztrnWp1xJAcjw@mail.gmail.com> <alpine.DEB.1.00.1401211755330.14982@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
	Jochen <zwanzig12@googlemail.com>, msysGit <msysgit@googlegroups.com>, 
	Git Mailing List <git@vger.kernel.org>, stefanbeller@googlemail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBCWR7KLAKGQEONY2WYA@googlegroups.com Tue Jan 21 18:04:13 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBCWR7KLAKGQEONY2WYA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f183.google.com ([209.85.213.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBCWR7KLAKGQEONY2WYA@googlegroups.com>)
	id 1W5ekG-0000um-AV
	for gcvm-msysgit@m.gmane.org; Tue, 21 Jan 2014 18:04:12 +0100
Received: by mail-ig0-f183.google.com with SMTP id hk11sf1239232igb.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 21 Jan 2014 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=LQLZhP/LPFmS8QxRNTHf7PlmnQC12vD6ttwIvC+L+8o=;
        b=P8XsaVf8Ou7TWOjQeJwr6TianfSpW9wNRGhGH6sylCCE2ABQ/1KWgG/xOy1RGIza6M
         XkPE91FD1bcJHoJ2RPSSn+UYFgKZKyxFQ2Nhj0I7PlF52Mzya5XLNa2wsd2woAXeDfLo
         SXyitC66vOjNhQSGve8ZZQkInQAp8pskJyxHnV5uUy/85GSO6Rht70uflVwx9wD9UEXX
         FQM4Ko9lolhnA52lH/P+vfiG+WjJXASNZMdcjWAf2eCVTOLVxT1nFsLcaw2/jglHspU+
         vdVWn7E6ZzPhNPDeTBSz7zvXi5+dCmuMXwtukFRyFJeoHohmcS8FtdkNdr3A3xSG9qy3
         n0+g==
X-Received: by 10.140.105.54 with SMTP id b51mr28895qgf.29.1390323851440;
        Tue, 21 Jan 2014 09:04:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.36.200 with SMTP id p66ls1189926qgp.74.gmail; Tue, 21 Jan
 2014 09:04:10 -0800 (PST)
X-Received: by 10.58.39.202 with SMTP id r10mr9483830vek.12.1390323850816;
        Tue, 21 Jan 2014 09:04:10 -0800 (PST)
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com [2607:f8b0:4001:c03::22f])
        by gmr-mx.google.com with ESMTPS id l41si1750700yhi.5.2014.01.21.09.04.10
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 09:04:10 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22f as permitted sender) client-ip=2607:f8b0:4001:c03::22f;
Received: by mail-ie0-f175.google.com with SMTP id ar20so5284864iec.6
        for <msysgit@googlegroups.com>; Tue, 21 Jan 2014 09:04:10 -0800 (PST)
X-Received: by 10.50.50.203 with SMTP id e11mr18783285igo.42.1390323850408;
 Tue, 21 Jan 2014 09:04:10 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Tue, 21 Jan 2014 09:03:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1401211755330.14982@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22f
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240757>

On Tue, Jan 21, 2014 at 5:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Tue, 21 Jan 2014, Erik Faye-Lund wrote:
>
>> On Tue, Jan 21, 2014 at 12:25 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Mon, 20 Jan 2014, Torsten B=F6gershausen wrote:
>> >
>> >> b) add "+++" at the places where you added the stat() and chmod(),
>> >> c) and to send the question "is this a good implementation ?" to upst=
ream git.
>> >>
>> >> I think your implementation makes sense.
>> >
>> > As I said in my other reply, I think that the problem would be
>> > addressed more generally in compat/mingw.c. It is to be doubted highly
>> > that upstream wants to handle cases such as "rename() cannot overwrite
>> > read-only files on Windows" everywhere they call rename() because the
>> > platforms upstream cares about do not have that problem.
>>
>> I'm not so sure. A quick test shows me that this is not the case for
>> NTFS. Since this is over a network-share, the problem is probably
>> server-side, and can affect other systems as well.
>>
>> So a work-around might be appropriate for all systems, no?
>
> I do not think that the problem occurs if you run the same commands on
> Linux, on a mounted Samba share. So I guess that upstream Git can enjoy
> their luxury of not having to care.
>
> In any case, if we would need this also for Linux, doing it for only one
> user of rename() would probably not be good enough, either... so somethin=
g
> similar to mingw_rename() would be needed (interfering with mingw_rename
> itself, of course).
>

Indeed. I was thinking of something along the lines of adding a
xrename in wrapper.c.

But you're probably right that this doesn't happen under Samba; surely
Samba would have added a work-around for such a filesystem by now. So
yeah, you've convinced me. mingw_rename is probably the place to do
that.

The work-around would probably look something like this:

diff --git a/compat/mingw.c b/compat/mingw.c
index a37bbf3..580b820 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1697,6 +1697,14 @@ int mingw_rename(const char *pold, const char *pnew)
      */
     if (!_wrename(wpold, wpnew))
         return 0;
+
+    if (errno =3D=3D EPERM) {
+        /* read-only files cannot be moved over on network shares */
+        _wchmod(wpnew, 0666);
+        if (!_wrename(wpold, wpnew))
+            return 0;
+    }
+
     if (errno !=3D EEXIST)
         return -1;
 repeat:

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
