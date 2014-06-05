From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Thu, 05 Jun 2014 16:51:39 +0200
Message-ID: <539083FB.6040707@gmail.com>
References: <20140605080519.GB28029@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCH3XYXLXQDBB64HYKOAKGQEK7AUVVI@googlegroups.com Thu Jun 05 16:51:40 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB64HYKOAKGQEK7AUVVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB64HYKOAKGQEK7AUVVI@googlegroups.com>)
	id 1WsZ11-0005kg-Vc
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 16:51:40 +0200
Received: by mail-lb0-f186.google.com with SMTP id c11sf132223lbj.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=kdp4/ZgoI/dxLuHLZBWbotbwWWP72fqnWcbs527TrJg=;
        b=BKXQXz5Om0NM7L9qd5Rncibv6R5lu89lTLGdbeQu+FiwVfuZr+7CebP2yOPYDksjM7
         baav0nv5kDdZYaWXczzt/nmzeW/pjHAaYwQEm8F74xibTnMHj5zq1WChXK5gnQTvuHAk
         +F01qp11NhnlLg2hp/wpOVxuOZHxB7BhackwCLoyxKSw0EXTkDT1Y+Sn3mypto567a0G
         si77Lwk4oaIIK9at5zi+44jmeOd/qGJQ3gFn2iA6BYfidh13ADYLyU6QYZDNCU1c9DbL
         43b0tXB8hOv3VswjIp7KE04J0GP6ECoqLRn/SDAEilA44JRfBJ2b4tD0Cqz0UI+Z49AL
         NVbA==
X-Received: by 10.152.42.225 with SMTP id r1mr59018lal.13.1401979899807;
        Thu, 05 Jun 2014 07:51:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.22.131 with SMTP id d3ls45124laf.95.gmail; Thu, 05 Jun
 2014 07:51:38 -0700 (PDT)
X-Received: by 10.152.115.195 with SMTP id jq3mr6944935lab.4.1401979898785;
        Thu, 05 Jun 2014 07:51:38 -0700 (PDT)
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com [2a00:1450:400c:c00::230])
        by gmr-mx.google.com with ESMTPS id m20si277070wij.1.2014.06.05.07.51.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 07:51:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::230 as permitted sender) client-ip=2a00:1450:400c:c00::230;
Received: by mail-wg0-x230.google.com with SMTP id n12so1025122wgh.7
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 07:51:38 -0700 (PDT)
X-Received: by 10.14.225.65 with SMTP id y41mr718900eep.75.1401979898700;
        Thu, 05 Jun 2014 07:51:38 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 44sm15068309eer.35.2014.06.05.07.51.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 07:51:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140605080519.GB28029@camelia.ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::230
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250841>

Am 05.06.2014 10:05, schrieb Stepan Kasal:
> mingw.c defines several wrapper functionsi, like mingw_unlink().
> These wrappers are deployed by macros like this:
> 	#define unlink mingw_unlink
> The function itself is preceded by #undef, leaving the wrapper out
> of the game for the rest of mingw.c.
>=20

In the current msysgit HEAD, most of these #undef's can simply be removed o=
r have already been removed (e.g. there's no '#undef mingw_unlink'). The re=
ason is that the mingw_unlink implementation calls the unicode version _wun=
link, so there's no name clash here.

If you apply this patch in msysgit, you'll most likely get compile errors d=
ue to redefining macros.

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
For more options, visit https://groups.google.com/d/optout.
