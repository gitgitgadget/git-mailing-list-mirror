From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 16:56:35 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125215635.GA6937@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
 <20121125051809.GA3670@thyrsus.com>
 <CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
 <20121125095429.GB22279@thyrsus.com>
 <CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
 <20121125175051.GD32394@thyrsus.com>
 <CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBCKNNHOUZUERBR5IZKCQKGQEEORE7CI@googlegroups.com Sun Nov 25 22:57:47 2012
Return-path: <msysgit+bncBCKNNHOUZUERBR5IZKCQKGQEEORE7CI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCKNNHOUZUERBR5IZKCQKGQEEORE7CI@googlegroups.com>)
	id 1TckCq-0005n2-7Z
	for gcvm-msysgit@m.gmane.org; Sun, 25 Nov 2012 22:57:40 +0100
Received: by mail-oa0-f58.google.com with SMTP id l10sf7417144oag.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 25 Nov 2012 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:in-reply-to:organization
         :x-eric-conspiracy:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=aoGJ2rKXTRcKDgLB8NY7OBqIzig1o4lPLnPlsv53PIY=;
        b=VoG8QDNkpXbZjcbmWyYAWkucKORr3C/0H2MrCKtgJ5P2dHx5ZYXWMJTFzi2Wmfq4GB
         IM9t4+3Gq6oN5tuhSts7+3Zfk/cZTtxGYYGTNPf5bC+zXvPJIGIJDPLlg4KGVvbSp7Ox
         XRWlEYMp9yXBeXik7JmWDlGH+EfKK8dHpNdRSxBgUzqXlNbNnyiAzYHZO0/WxGQfEQSh
         u2M9DJ2hFRnnbVabdeWcRyfDYFJnilAEDj9dyO7d75cZDRQRdYhVXzSaFH1ngGHzq0Er
         jiSnh353fbPhsg 
Received: by 10.49.26.39 with SMTP id i7mr1916907qeg.18.1353880648538;
        Sun, 25 Nov 2012 13:57:28 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.2.42 with SMTP id 10ls1418967qer.10.gmail; Sun, 25 Nov 2012
 13:57:27 -0800 (PST)
Received: by 10.58.239.41 with SMTP id vp9mr2937746vec.38.1353880647642;
        Sun, 25 Nov 2012 13:57:27 -0800 (PST)
Received: by 10.58.239.41 with SMTP id vp9mr2937745vec.38.1353880647615;
        Sun, 25 Nov 2012 13:57:27 -0800 (PST)
Received: from snark.thyrsus.com (static-71-162-243-5.phlapa.fios.verizon.net. [71.162.243.5])
        by gmr-mx.google.com with ESMTP id bn19si934851vdb.0.2012.11.25.13.57.27;
        Sun, 25 Nov 2012 13:57:27 -0800 (PST)
Received-SPF: pass (google.com: domain of esr@thyrsus.com designates 71.162.243.5 as permitted sender) client-ip=71.162.243.5;
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 79B274065F; Sun, 25 Nov 2012 16:56:35 -0500 (EST)
In-Reply-To: <CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: esr@thyrsus.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of esr@thyrsus.com designates 71.162.243.5 as permitted sender) smtp.mail=esr@thyrsus.com
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210386>

Felipe Contreras <felipe.contreras@gmail.com>:
> And gitk is an integral part of git. But if you have different
> numbers, what are they?

I looked at the Makefile.  I saw that there are shell variables that collect
C commands, shell command, Perl commands, and Python commands.  There are no
collections of other commands.  That makes them the top languages in the
universe we are concerned about

Please don't waste further time on quibbling.  We all know that gitk is
an uncomfortable special case and that the project would be far better
off, maintainability-wise, if it were successfully ported to one if these
other languages.  Trying to catch me out by triumphantly pointing at gitk 
is...juvenile.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

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
