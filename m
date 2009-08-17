From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 19:32:07 -0300
Message-ID: <a4c8a6d00908171532n4406c7fcv59bce443c3203dbe@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com> <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com> <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com> <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de> <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com> <alpine.DEB.1.00.0908180005250.8306@pacific.mpi-cbg.de> <3af572ac0908171519h7b72427lba7536506d44460e@mail.gmail.com> <4A89D807.1080202@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="00504501706bd333e104715df851"
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Reece Dunn <msclrhd@googlemail.com>, Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,  msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 00:34:42 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAml-0006My-7I
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 00:34:39 +0200
Received: by ywh4 with SMTP id 4so5285344ywh.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version
         :content-type:received:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-google-approved:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=TJ5qSQPu6OLYdAAIaa3/j5EM7K9kZoPIsP0m7DoLg8s=;
        b=yhMYKHYKQ+DvExWOJYtgeRpkxieyTLNJXZmveUatFWDYP7AeKW16qx5TzmEfvSt81D
         0Sd4AWtXMX0yigiP7H5RUWcCCN8gJhxAg4HxR8dklcS87XjLvCOQwpg9bfgXNMkBY469
         L2VziWTRdRVKNBw7ZJa7qTXHzNtB2szJEoXsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:content-type
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-google-approved:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=vG8DKfe3CHdJZoh5LJHq7efWFzM0ux7LW4tDBjTC50ZbIMVQowwBIswcppAt9DzPep
         xx7gJTcrzwsVCXGAIAAwAEi0RLphZQL9VbTEwwJpyehqdgc38KmwKKih0Eptv5uUcLpr
         y5mFC2QhIsh3S7HVoU8E7A1oDn1K19ei0A8CI=
Received: by 10.100.200.15 with SMTP id x15mr1309279anf.12.1250548473223;
        Mon, 17 Aug 2009 15:34:33 -0700 (PDT)
Received: by 10.176.94.14 with SMTP id r14gr6416yqb.0;
	Mon, 17 Aug 2009 15:34:31 -0700 (PDT)
X-Sender: tfransosi@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.91.102.4 with SMTP id e4mr1974831agm.6.1250548328610; Mon, 17 Aug 2009 15:32:08 -0700 (PDT)
Received: by 10.91.102.4 with SMTP id e4mr1974828agm.6.1250548328455; Mon, 17 Aug 2009 15:32:08 -0700 (PDT)
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com [209.85.210.181]) by gmr-mx.google.com with ESMTP id 13si637193gxk.6.2009.08.17.15.32.07; Mon, 17 Aug 2009 15:32:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of tfransosi@gmail.com designates 209.85.210.181 as permitted sender) client-ip=209.85.210.181;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of tfransosi@gmail.com designates 209.85.210.181 as permitted sender) smtp.mail=tfransosi@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-yx0-f181.google.com with SMTP id 11so4274149yxe.3 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=RZwl5/ntLboeUOH7XmcrJpj5Yr8ibr+z8gRMbtpKcdo=; b=yBX++LrUV7/K2CfvmZfSMBYu7g82LXtt0ZJ45e8FkUCoh5DAHhHFNkNIFSHOjbp9LS Od5egzHx8ARxsRkk6KUhoEFIRl32mnndvVlBPxEcHEX0Xu2xmXKtjoD36cZwI1u+lky+ THvUCXy4dfz1M/kgmcd58oZw21W9nRCM6JvAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=r0G6w9fBQXzzRBkDn9FXon0JNTRkl9SGAYkCxEeC+sgWOSjkmEMWrDEqGDNUq4owYC Lb7Iot+ZArjLPjqRyFcYcC4CoIG2tM5svnkOCaq1pvvVbRxP/iF9uxuSKBinl1Wv85nA rZSd2S9fd3OjoLfj/RS350CEqvyuo2whZvQ+0=
Received: by 10.101.23.2 with SMTP id a2mr4106592anj.190.1250548327329; Mon,  17 Aug 2009 15:32:07 -0700 (PDT)
In-Reply-To: <4A89D807.1080202@gnu.org>
X-Google-Approved: johannes.schindelin@googlemail.com via web at 2009-08-17 22:34:31
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126305>


--00504501706bd333e104715df851
Content-Type: text/plain; charset=ISO-8859-1

What about the common-cmds.h that is in the builtin-help.c? How it will be
generated?I followed the instruction in ReadMe, but I couldn't compile
because of this "missing" file.

--00504501706bd333e104715df851
Content-Type: text/html; charset=ISO-8859-1

What about the common-cmds.h that is in the builtin-help.c? How it will be generated?<div>I followed the instruction in ReadMe, but I couldn&#39;t compile because of this &quot;missing&quot; file.</div>

--00504501706bd333e104715df851--
