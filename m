From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] git-compat-util.h: reduce optimization
 level to 1 on MinGW env.
Date: Wed, 25 Sep 2013 21:50:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1309252142220.1191@s15462909.onlinehome-server.info>
References: <1380123941-25941-1-git-send-email-wnoguchi.0727@gmail.com> <20130925191527.GY9464@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>, git@vger.kernel.org, 
    msysgit@googlegroups.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB4H4RSJAKGQEK6KO7PA@googlegroups.com Wed Sep 25 21:50:10 2013
Return-path: <msysgit+bncBCZPH74Q5YNRB4H4RSJAKGQEK6KO7PA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB4H4RSJAKGQEK6KO7PA@googlegroups.com>)
	id 1VOv69-0006F5-01
	for gcvm-msysgit@m.gmane.org; Wed, 25 Sep 2013 21:50:09 +0200
Received: by mail-la0-f61.google.com with SMTP id ea20sf17459lab.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Sep 2013 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=+xwL4vMnLRTAjLuUKW1kkLlGy/X1I1vLUDE7QW4daY0=;
        b=wBxDMpKyKoKfTx0nMngmuWoEad61btfdEQ2T+i/ai0E/xGk11usN58sS8I5UB8gG+/
         7aGCaBwhS7QrXUVeyv4k+fPnlx7OfpzJis2zYkXAT55E+s22B76lFO0UU65JfhcQTYlI
         sd19Di6PoHj1x++lNjPwAVpRoX+rOf/xNBQC1rQpEe67/Sby6280ccnPxq9QP3Hzvm+x
         WDP6LDemdN0CQ6LtY2J0oioFoLxyRij5+NGrYXh0eXNrtnLq89G5t/c/TrLQliEwh1iw
         4NHxch63s1UjXC9Cw7OY/SdG95E4gmJ/n6HZCeoRYOUMlSLzqLwVfgcSXNMjjDmHaLcu
         Ei8w==
X-Received: by 10.180.206.176 with SMTP id lp16mr985377wic.10.1380138608725;
        Wed, 25 Sep 2013 12:50:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.37.232 with SMTP id b8ls481593wik.6.gmail; Wed, 25 Sep
 2013 12:50:07 -0700 (PDT)
X-Received: by 10.14.251.134 with SMTP id b6mr32093874ees.2.1380138607598;
        Wed, 25 Sep 2013 12:50:07 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id cd45si6079502eeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Sep 2013 12:50:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MEtba-1Vdhrx0uHy-00G2Mv
 for <msysgit@googlegroups.com>; Wed, 25 Sep 2013 21:50:07 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20130925191527.GY9464@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:3dh1qIRfR5Vscje+KtO0PCGNlDyS2p9EadljTz+s/Yo+eStzGpj
 UlMUUfFE7tUDcqrwoVnSEQPPjMxJJhrFlsQIkZwjpuGtrYhJY0QqigHDtPYGhJmmtOuJL66
 Uj7yjGxtantS8RNbFZSF9kuRW8bzkO5czdm/JiNP5LFqNXO1w6WGvJuqN+yo93qCFmyiOst
 0yKGq3Ltj93vSedDi0nGg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235374>

Hi,

On Wed, 25 Sep 2013, Jonathan Nieder wrote:

> Wataru Noguchi wrote:
>=20
> >   - actually file name is decoded.]
> >   %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83=
%88%E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%8=
7%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%=
E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%=
83%AA%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82=
%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A=
5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%2=
05-long-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%=
AA%AD%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
> >
> > This commit reduce gcc optimization level from O2 to O1 when MinGW
> > Windows environment.
>=20
> Do you know why reducing the optimization level avoids a crash?

I suspect that the optimization level causes smaller (or no) buffer bytes
between data structures and the crash is the symptom of a buffer overflow.
In that light, I think that reducing the optimization level is most likely
just working around this particular issue, and other scenarios might still
crash until we fix the underlying bug.

Most likely the problem is with our Windows-specific UTF-8 handling, I
would not be surprised if it is my "favorite" bug: an off-by-one.

To find out what the real cause is, I suggest using a tool similar to
valgrind. Valgrind does not run on Windows, but I DuckDuckWent e.g.
http://code.google.com/p/drmemory/ as an alternative that could be tried
to identify the problem.

Ciao,
Johannes

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
