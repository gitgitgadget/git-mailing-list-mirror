From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Consecutive git gc fails on Windows network share
Date: Tue, 21 Jan 2014 00:53:29 +0100
Message-ID: <CABPQNSafcpACtWGBenE8vAe_XEvJ=5_sxLw8PztrnWp1xJAcjw@mail.gmail.com>
References: <d10603d6-7740-44f8-909f-7ba1ea77d3a2@googlegroups.com>
 <52D9701F.5070009@web.de> <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com>
 <52DD59E0.4090301@web.de> <alpine.DEB.1.00.1401210002080.14982@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
	Jochen <zwanzig12@googlemail.com>, msysGit <msysgit@googlegroups.com>, 
	Git Mailing List <git@vger.kernel.org>, stefanbeller@googlemail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBIXO62LAKGQEXEMWUNQ@googlegroups.com Tue Jan 21 00:54:13 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBIXO62LAKGQEXEMWUNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f188.google.com ([209.85.216.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBIXO62LAKGQEXEMWUNQ@googlegroups.com>)
	id 1W5OfU-0006Vd-Eg
	for gcvm-msysgit@m.gmane.org; Tue, 21 Jan 2014 00:54:12 +0100
Received: by mail-qc0-f188.google.com with SMTP id w7sf1637757qcr.5
        for <gcvm-msysgit@m.gmane.org>; Mon, 20 Jan 2014 15:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=1JXYDJ6PwsBH0DkXd3tOnR+Bl0R1hLZiI08Y5sC0yOA=;
        b=th7SCNhGvaeZ9JOty9tpK7rOWp6FcwJuE+thS2M0Ydm/1BARJPXd0Ss538VVMuffmo
         zTw9I5Ln5DVppxuh7ZiaRJWaIUPzbF88/jZDj+pljeIHzjQYmjOa0hnpgXX2w429lUBR
         QCzsjOaFyb1vKD4IAwOxqTCKQEtbomT0E6mBF/7L1tmc23ZY6UzB8wLEIdEc1CLaUavJ
         Tp5Bler2SXBYcRr/OmulOQQXSwNuX1MKp3Ma0Wk5wmkcOVwAtu4zdhEaN7IgaT763TIA
         pMy5ypIY1TLFfgxG/46ZzJr9aCfRhKcqx0sBj412QZL9TAyJ5ThODbiLdPy4ySl37eFF
         u7Pw==
X-Received: by 10.50.79.130 with SMTP id j2mr287565igx.2.1390262051489;
        Mon, 20 Jan 2014 15:54:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.17.39 with SMTP id gb7ls1993609igd.18.canary; Mon, 20 Jan
 2014 15:54:10 -0800 (PST)
X-Received: by 10.66.220.4 with SMTP id ps4mr7561720pac.18.1390262050672;
        Mon, 20 Jan 2014 15:54:10 -0800 (PST)
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com [2607:f8b0:4001:c05::231])
        by gmr-mx.google.com with ESMTPS id i24si950274yhe.6.2014.01.20.15.54.10
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Jan 2014 15:54:10 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::231 as permitted sender) client-ip=2607:f8b0:4001:c05::231;
Received: by mail-ig0-f177.google.com with SMTP id k19so9328662igc.4
        for <msysgit@googlegroups.com>; Mon, 20 Jan 2014 15:54:10 -0800 (PST)
X-Received: by 10.43.57.146 with SMTP id wg18mr7395209icb.42.1390262050177;
 Mon, 20 Jan 2014 15:54:10 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Mon, 20 Jan 2014 15:53:29 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1401210002080.14982@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240736>

On Tue, Jan 21, 2014 at 12:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 20 Jan 2014, Torsten B=F6gershausen wrote:
>
>> b) add "+++" at the places where you added the stat() and chmod(),
>> c) and to send the question "is this a good implementation ?" to upstrea=
m git.
>>
>> I think your implementation makes sense.
>
> As I said in my other reply, I think that the problem would be addressed
> more generally in compat/mingw.c. It is to be doubted highly that upstrea=
m
> wants to handle cases such as "rename() cannot overwrite read-only files
> on Windows" everywhere they call rename() because the platforms upstream
> cares about do not have that problem.

I'm not so sure. A quick test shows me that this is not the case for
NTFS. Since this is over a network-share, the problem is probably
server-side, and can affect other systems as well.

So a work-around might be appropriate for all systems, no?

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
