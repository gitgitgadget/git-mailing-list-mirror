From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Python extension commands in git - request for
 policy change
Date: Tue, 27 Nov 2012 16:33:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211271632030.7256@s15462909.onlinehome-server.info>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com> <20121125051809.GA3670@thyrsus.com> <CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com> <20121125095429.GB22279@thyrsus.com>
 <CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com> <20121125175051.GD32394@thyrsus.com> <CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com> <20121125215635.GA6937@thyrsus.com> <CAMP44s2FcrjDhNzond=Rzmn5QOBnZbQC1d73ZmKNeyCRvJNvyA@mail.gmail.com>
 <CAJDDKr4cr3VXqx=CXgXSQrVTSjE=f=55HZns-xfNziJOXb3Vsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>, esr@thyrsus.com, 
    Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: David Aguilar <davvid@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBUV22OCQKGQEFFRZPFQ@googlegroups.com Tue Nov 27 16:33:53 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBUV22OCQKGQEFFRZPFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBUV22OCQKGQEFFRZPFQ@googlegroups.com>)
	id 1TdNAU-0000Cs-9Q
	for gcvm-msysgit@m.gmane.org; Tue, 27 Nov 2012 16:33:50 +0100
Received: by mail-ye0-f186.google.com with SMTP id m9sf3390569yen.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 27 Nov 2012 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=BGs4SU8kwELT01J3+HR3yxSxwqb2Njpn5sBr5QCpGuk=;
        b=SQSzm+JQoX9WxhAfpYi5S8O2YW1dLikSZZ0lGcVYp/U7QuBoNTxoJbWc4pipYAN8xE
         40PtyNUoWfPEyTzy5ubTM+j7zjxP+NH94Z2KnbpRLChsBh11cs877+99TFK+At2qJc1T
         y/JDgIjr1gQxyMMrj801Ld/ZamAeKj+bi6xu2Z7UxcMRUzOoynI+enrv4a05qxyIUR9f
         9virxI3rwHKJyIBKAMBXM/SzFIicqgZUmSn+wXPE5wObu3JPQ1ldw593Miedt2ViCPJC
         ytHn4wveIhc64CnOoG 
Received: by 10.49.116.1 with SMTP id js1mr3334763qeb.19.1354030419180;
        Tue, 27 Nov 2012 07:33:39 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.50.201 with SMTP id e9ls938860qeo.39.gmail; Tue, 27 Nov
 2012 07:33:38 -0800 (PST)
Received: by 10.100.83.14 with SMTP id g14mr2705672anb.22.1354030418434;
        Tue, 27 Nov 2012 07:33:38 -0800 (PST)
Received: by 10.100.83.14 with SMTP id g14mr2705671anb.22.1354030418418;
        Tue, 27 Nov 2012 07:33:38 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id i27si1316332yhb.0.2012.11.27.07.33.37;
        Tue, 27 Nov 2012 07:33:38 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 27 Nov 2012 15:33:37 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp004) with SMTP; 27 Nov 2012 16:33:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5vXlhJB75GbY3islyEh9FE8Kxk1Kb1K+KOTd7lc
	M+StQRbd3824+U
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAJDDKr4cr3VXqx=CXgXSQrVTSjE=f=55HZns-xfNziJOXb3Vsw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210561>

Hi David,

On Mon, 26 Nov 2012, David Aguilar wrote:

> *cough* git-cola *cough*

If you had a couple of free cycles to help us get Python/Qt compiled in
msysGit, I will be happy to make a Git for Windows package including
git-cola.

Ciao,
Dscho

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
