From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension
 more robust
Date: Tue, 31 Mar 2009 00:49:07 +0200
Message-ID: <43168.7221433551$1238455980@news.gmane.org>
References: <200903300030.03733.markus.heidelberg@web.de> <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302> <200903300851.43164.markus.heidelberg@web.de> <20090330141510.GW23521@spearce.org>
Reply-To: giuseppe.bilotta@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
To: "Shawn O. Pearce" <spearce@spearce.org>, msysgit@googlegroups.com, git@vger.kernel.org,Markus Heidelberg <markus.heidelberg@web.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Mar 31 01:32:53 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoQwY-0002w7-70
	for gcvm-msysgit@m.gmane.org; Tue, 31 Mar 2009 01:31:02 +0200
Received: by qyk35 with SMTP id 35so3601371qyk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 30 Mar 2009 16:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :message-id:from:subject:to:date:references:lines:user-agent
         :mime-version:content-type:content-transfer-encoding:x-face
         :x-google-approved:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=FtaFSem9EkdCBV2kR+XyP11gQaPZjqll0NQh0SyF5E0=;
        b=ptOR7rOe1KFG8Z/W9fUm5nKA5DSnpfXooL0njAVniqFmW3I6LVoDF5bK0bdXNkIwVN
         CiGSlvKaZMABYQYfRXBmXYaXDlU8SvqkZqoXqROvyBMXRg5VC8AWcBcOJi5WcbgE7BR4
         7lxjSHkTno2f2d48kthwTuPZy8TYsx8JnPcqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:from:subject:to:date:references:lines:user-agent
         :mime-version:content-type:content-transfer-encoding:x-face
         :x-google-approved:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=3CU6cuA9+hIdF4yst9t4ajbwNqP62UwGu1NnlYwxM2FAEhcIFdY6I5dYLdBGE/7Gd8
         VmYgXO8zmlYMh70SMoVhz+Wewx9HwiOHvsJurZrUeZruLM2/Mjn5usLN6eBkKxprb4fG
         FkHn9YVeVF8VvBQbr7ZBo61HsrdESjLwxKezs=
Received: by 10.224.19.146 with SMTP id a18mr786749qab.8.1238455767069;
        Mon, 30 Mar 2009 16:29:27 -0700 (PDT)
Received: by 10.176.167.11 with SMTP id p11gr4554yqe.0;
	Mon, 30 Mar 2009 16:29:27 -0700 (PDT)
X-Sender: giuseppe.bilotta@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.69.6 with SMTP id x6mr141125bki.28.1238453353648; Mon, 30 Mar 2009 15:49:13 -0700 (PDT)
Received: from joe.mail.tiscali.it (joe.mail.tiscali.it [213.205.33.54]) by gmr-mx.google.com with ESMTP id 13si501883bwz.7.2009.03.30.15.49.13; Mon, 30 Mar 2009 15:49:13 -0700 (PDT)
Received-SPF: neutral (google.com: 213.205.33.54 is neither permitted nor denied by domain of giuseppe.bilotta@gmail.com) client-ip=213.205.33.54;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 213.205.33.54 is neither permitted nor denied by domain of giuseppe.bilotta@gmail.com) smtp.mail=giuseppe.bilotta@gmail.com
Received: from oblomov.local (78.13.53.34) by joe.mail.tiscali.it (8.0.022) id 499F039601E4A981; Tue, 31 Mar 2009 00:49:12 +0200
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
X-Google-Approved: johannes.schindelin@googlemail.com via web at 2009-03-30 23:29:26
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115201>


On Monday 30 March 2009 16:15, Shawn O. Pearce wrote:

> Markus Heidelberg <markus.heidelberg@web.de> wrote:
>> 
>> But I just noticed, that it will obviously "cd .." forever, if no .git/
>> was found. Somehow the root directory has to be catched.
> 
> Yup.  I'm dropping this patch for now because of this issue, but
> I'll look at it again if its addressed in another version.  :-)

I have a couple of pending patches to fix git gui handling of repositories,
including support for nonstandard repository locations and bare repositories.
You can find them at

http://git.oblomov.eu/git

and specifically

http://git.oblomov.eu/git/patches/b2e4c32e13df1b7f18e7b4a9f746650471a3122e..a63526bf3238cf25d9a5521f7ee35ed1bd11cb16

I got distracted by real-life issue and forgot to resend them. I'll try
to find the time again later on this week. I'm not entirely sure these
solve Markus' problem though.

-- 
Giuseppe "Oblomov" Bilotta
