From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Consecutive git gc fails on Windows network share
Date: Tue, 21 Jan 2014 17:57:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1401211755330.14982@s15462909.onlinehome-server.info>
References: <d10603d6-7740-44f8-909f-7ba1ea77d3a2@googlegroups.com> <52D9701F.5070009@web.de> <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com> <52DD59E0.4090301@web.de> <alpine.DEB.1.00.1401210002080.14982@s15462909.onlinehome-server.info>
 <CABPQNSafcpACtWGBenE8vAe_XEvJ=5_sxLw8PztrnWp1xJAcjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
    Jochen <zwanzig12@googlemail.com>, msysGit <msysgit@googlegroups.com>, 
    Git Mailing List <git@vger.kernel.org>, stefanbeller@googlemail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBGGO7KLAKGQETYGKKOQ@googlegroups.com Tue Jan 21 17:58:03 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBGGO7KLAKGQETYGKKOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f61.google.com ([209.85.214.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBGGO7KLAKGQETYGKKOQ@googlegroups.com>)
	id 1W5eeH-0006q0-IK
	for gcvm-msysgit@m.gmane.org; Tue, 21 Jan 2014 17:58:01 +0100
Received: by mail-bk0-f61.google.com with SMTP id d7sf597128bkh.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 21 Jan 2014 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=PLU5dlDPrb1HgxUZAjKb0kphmVClQzmX72X/y35tWEM=;
        b=l2otxDisUV9WYOdNevDXgAUvF3ha4N8GzCL2peb9pwaNuDmfAcvSI1ciMRALnr/80A
         BjwwSywe2h5Rp33zvpnYFw5C8hnipZsFJ4N4waCta3voYbNMiuovGSj5OaO3nT09dn4I
         bCzxaY4rU1jaDquRY/KIVMoC3LxWN86qDNozx3SA7FhSTGeOvL8BQaFPnvqeHmnck0TJ
         qa8lW3WgDEQrgjmLFJ2Sh/tILSWoFSbcOWxOklDpeA8FcEa1IEDODBBPMdvncgUWbJmt
         XtpRqZiF84uyfyyZbR/GRBpGk5Csaco1o7sTN6IWSXdKPilgHVn2umecSreifNTyDNZP
         DGRw==
X-Received: by 10.152.171.231 with SMTP id ax7mr30229lac.10.1390323481289;
        Tue, 21 Jan 2014 08:58:01 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.138 with SMTP id o10ls496819lal.33.gmail; Tue, 21 Jan
 2014 08:58:00 -0800 (PST)
X-Received: by 10.112.141.162 with SMTP id rp2mr11331216lbb.13.1390323480452;
        Tue, 21 Jan 2014 08:58:00 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id c48si1209884eeb.1.2014.01.21.08.58.00
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2014 08:58:00 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LnxQO-1VPkJr3s3U-00g38u
 for <msysgit@googlegroups.com>; Tue, 21 Jan 2014 17:58:00 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSafcpACtWGBenE8vAe_XEvJ=5_sxLw8PztrnWp1xJAcjw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nZ48xTm7nchoRjfMnqhGj06RPGyGUBrI6DJr0gtaak3zU792Giq
 /BfzjFEpQLQFUFpGAFX05Lw95fey48DYX91XUTtRla9pdt4ew9aZ6P04PHUtciKbAaPq3p9
 EKyjQvxGGyY2xKlsFrsOyVH2t1lbaFhwUznEFk+uSm/8vEqs9jWXWMwBAzfXiJpahg/C5mr
 aYvCatSSf4FZp9NhDD4IQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240755>

Hi kusma,

On Tue, 21 Jan 2014, Erik Faye-Lund wrote:

> On Tue, Jan 21, 2014 at 12:25 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 20 Jan 2014, Torsten B=F6gershausen wrote:
> >
> >> b) add "+++" at the places where you added the stat() and chmod(),
> >> c) and to send the question "is this a good implementation ?" to upstr=
eam git.
> >>
> >> I think your implementation makes sense.
> >
> > As I said in my other reply, I think that the problem would be
> > addressed more generally in compat/mingw.c. It is to be doubted highly
> > that upstream wants to handle cases such as "rename() cannot overwrite
> > read-only files on Windows" everywhere they call rename() because the
> > platforms upstream cares about do not have that problem.
>=20
> I'm not so sure. A quick test shows me that this is not the case for
> NTFS. Since this is over a network-share, the problem is probably
> server-side, and can affect other systems as well.
>=20
> So a work-around might be appropriate for all systems, no?

I do not think that the problem occurs if you run the same commands on
Linux, on a mounted Samba share. So I guess that upstream Git can enjoy
their luxury of not having to care.

In any case, if we would need this also for Linux, doing it for only one
user of rename() would probably not be good enough, either... so something
similar to mingw_rename() would be needed (interfering with mingw_rename
itself, of course).

Ciao,
Dscho

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
