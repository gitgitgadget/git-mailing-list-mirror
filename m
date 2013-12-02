From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please update grep in the Windows Git distro
Date: Mon, 2 Dec 2013 11:59:51 -0800
Message-ID: <20131202195951.GA29959@google.com>
References: <CACAE+cGBvwVRjm8=-3e+w_xQozP1nfsphK4-ndky2yZoCoMjxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Tom Byrer <tombyrer@gmail.com>
X-From: msysgit+bncBD6LRKOE4AIRBS6N6OKAKGQEIHWQ7LI@googlegroups.com Mon Dec 02 21:00:14 2013
Return-path: <msysgit+bncBD6LRKOE4AIRBS6N6OKAKGQEIHWQ7LI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f59.google.com ([209.85.212.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBS6N6OKAKGQEIHWQ7LI@googlegroups.com>)
	id 1VnZfA-0003nM-IX
	for gcvm-msysgit@m.gmane.org; Mon, 02 Dec 2013 21:00:12 +0100
Received: by mail-vb0-f59.google.com with SMTP id g10sf3636688vbg.24
        for <gcvm-msysgit@m.gmane.org>; Mon, 02 Dec 2013 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=4HE0H2Ie7Yxbs8p4OOp8f8nzDJnHuf+MdMGC8THlSjE=;
        b=OFazUFWZWsSq7QJ9BAkl0qK8vBjHh1qCWSNMel+5+qBjn1ZaqEUvgwARRbjGyFm+v4
         lYD+xed7aAqe8jt8xgBE7LHxq8FbFLI+lwy9DiFfl2svlM117RoANRZRz8mdRwJujUsq
         Gl9VIETqMToVTOuYVc00RJR5GXp+4PhjCrSkNqacSr1ZFF0jItCKfAthSi5qxrNmly0y
         wV98k85zf7fw5Wr3TYCsKAX+qdIJQOxNnh0rWUbxdjPgECIBjNbmvsXtNzI/3pfNXlze
         WupJnmeXJYq9r8XM+geWezHRr6x3We7iRo5Jih4lMChPlAEJgXs2n3ll8N+/CW0llGvC
         iLhw==
X-Received: by 10.49.51.104 with SMTP id j8mr105453qeo.18.1386014411601;
        Mon, 02 Dec 2013 12:00:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.12.11 with SMTP id u11ls4967541qeb.25.gmail; Mon, 02 Dec
 2013 12:00:11 -0800 (PST)
X-Received: by 10.236.135.79 with SMTP id t55mr31392628yhi.39.1386014410063;
        Mon, 02 Dec 2013 12:00:10 -0800 (PST)
Received: from mail-yh0-x22d.google.com (mail-yh0-x22d.google.com [2607:f8b0:4002:c01::22d])
        by gmr-mx.google.com with ESMTPS id o30si3663850yhn.1.2013.12.02.12.00.10
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 12:00:10 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::22d as permitted sender) client-ip=2607:f8b0:4002:c01::22d;
Received: by mail-yh0-f45.google.com with SMTP id v1so8130454yhn.4
        for <msysgit@googlegroups.com>; Mon, 02 Dec 2013 12:00:10 -0800 (PST)
X-Received: by 10.236.138.202 with SMTP id a50mr47598yhj.156.1386014405866;
        Mon, 02 Dec 2013 12:00:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g25sm44047666yhg.6.2013.12.02.12.00.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 12:00:05 -0800 (PST)
In-Reply-To: <CACAE+cGBvwVRjm8=-3e+w_xQozP1nfsphK4-ndky2yZoCoMjxw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::22d
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238649>

(cc-ing the msysgit@ group, which maintains Git for Windows)
Hi,

Tom Byrer wrote:

> Seems that grep.exe is too outdated for some scripts:
> https://github.com/creationix/nvm/issues/75#issuecomment-13735767
>
> Updating to a newer grep distro fixes the problem:
> https://github.com/creationix/nvm/issues/75#issuecomment-29054164

If you have time for it, your best bet is to contribute this change by
forking msysgit.git on GitHub.

See
 https://github.com/msysgit/msysgit/wiki#how-to-participate
 https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions#i-want-to-upgrade-perl-how-do-i-do-that
for hints.  (Short answer: the usual way would be to add a
/src/grep/release.sh script that builds and installs 'grep', imitating
others /src/*/release.sh scripts, to make it easy to keep grep.exe up
to date in the future.)

Thanks for your interest, and hope that helps,
Jonathan

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
