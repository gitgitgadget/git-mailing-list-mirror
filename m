From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 22:30:20 +0100
Message-ID: <46d6db660903081430m35da0d2eoc97377dfec54b1b5@mail.gmail.com>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Reply-To: christian.michon@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 08 22:32:00 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQbE-0005hc-A4
	for gcvm-msysgit@m.gmane.org; Sun, 08 Mar 2009 22:31:56 +0100
Received: by yx-out-2122.google.com with SMTP id 22so842141yxm.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Mar 2009 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Fec2yb7/aUkFod0VMyvMzEAAUC/opgsg7Ujh8GMMGkc=;
        b=DYdhGkWmAPVUctXHLvv6O9hfQtX3JvMxt1ON+cZDqpo5vIyrySPxatW2GdDxOqThYl
         nH6mAgkFuFgk9088TvYVcIesMbhtiHMigSj0LCMHDkQE2L49Xz0G2hHb3xDgRB7t9dqG
         IfuDh9hN2C6t62iwrE6wynYrgjZfQdmU0kx1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=jVvabQRhP19OGW23NNDIt0ceaY9kP2IW+6n78a8hIGt03e5cjhQ0TnSUwBMnNrC/79
         gQIP2WO4A0wvd89TbDjHgpjBjPcPrxnhC33iOaxUFYAr3ddbPFRpm20lLsWwfCyZpdVG
         QfcqgKQnQ1it80ZJzblXa+SEEN4j5sRITFRQ0=
Received: by 10.90.115.13 with SMTP id n13mr918531agc.26.1236547822909;
        Sun, 08 Mar 2009 14:30:22 -0700 (PDT)
Received: by 10.177.127.42 with SMTP id e42gr3888yqn.0;
	Sun, 08 Mar 2009 14:30:22 -0700 (PDT)
X-Sender: christian.michon@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.29.19 with SMTP id c19mr54927fgc.21.1236547821750; Sun, 08 Mar 2009 14:30:21 -0700 (PDT)
Received: from mail-bw0-f175.google.com (mail-bw0-f175.google.com [209.85.218.175]) by gmr-mx.google.com with ESMTP id 5si157879fge.3.2009.03.08.14.30.20; Sun, 08 Mar 2009 14:30:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of christian.michon@gmail.com designates 209.85.218.175 as permitted sender) client-ip=209.85.218.175;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of christian.michon@gmail.com designates 209.85.218.175 as permitted sender) smtp.mail=christian.michon@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-bw0-f175.google.com with SMTP id 23so901930bwz.28 for <msysgit@googlegroups.com>; Sun, 08 Mar 2009 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=tqq3pymOKaQ2TDUgKWa0FOC9hVsj1eB5X3foaddrXKc=; b=A8tYjb+K7oehAlIufU2ElGd0xEh+ljwWiobUyZZlVSn4cawhdisNAyQ9J4Wol0EEW9 yaWLR8ZZIuiwEipG65chlya4ph1IhkcRZcVoP1S/JLHeuvyuAG21snf/Y+K5/B9ZV7TJ UhS+IVsRvILqQd11DeRG92mDeT0GGJArSev74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=IqODrhtEdbFqzV8WI2iulhS4j8RUayb2UWchnCEaxnacsyDfKrQUXuhKt75Zs+4xCg o2Lru+c83hMY39EpRYHl1ROJ0+FUseYDhstoiF4n6QTE19uIIFT8P6vP4+vdrI0BT2tn 5RNhV5GNl+8643Ef9jUuBsO46XvU/nkQgCLzw=
Received: by 10.103.226.20 with SMTP id d20mr2288384mur.8.1236547820634; Sun,  08 Mar 2009 14:30:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112647>


On Sun, Mar 8, 2009 at 3:10 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> I just released a new version of Git for Windows (TAFKA WinGit). =A0It is
> basically Git 1.6.2 plus a few patches. =A0Please find the installer here=
:
>
> =A0 =A0 =A0 =A0http://msysgit.googlecode.com/
>

I noticed the PS1 change too :)

Something is wrong with vim-7.2 apparently: syntax highlighting is not
working apparently.

I'll look at what could be wrong right now.

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git ins=
ide !
