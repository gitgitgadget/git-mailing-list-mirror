From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH] core.filemode may need manual action
Date: Thu, 16 Oct 2014 21:40:40 +0200
Message-ID: <54401F38.7080101@virtuell-zuhause.de>
References: <54401CAD.4090606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git-win-sdk@googlegroups.com, msysGit <msysgit@googlegroups.com>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>, 
 git@vger.kernel.org
X-From: msysgit+bncBCL7JHHTPAILVPUAUICRUBGIJ6TVC@googlegroups.com Thu Oct 16 21:40:50 2014
Return-path: <msysgit+bncBCL7JHHTPAILVPUAUICRUBGIJ6TVC@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAILVPUAUICRUBGIJ6TVC@googlegroups.com>)
	id 1Xequh-0008M8-Bo
	for gcvm-msysgit@m.gmane.org; Thu, 16 Oct 2014 21:40:43 +0200
Received: by mail-wi0-f185.google.com with SMTP id n3sf25140wiv.22
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Oct 2014 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=ZQNWm0bOqBswNlxzWlmvWnlYLVVo85QSIT8dgrU7WS0=;
        b=X/mz7EnFQk+QA7xbJXT7fFj5rSLRUqUJNKvvEhwdIMt8rX4QpuE6Jem/TFFXJA95Ga
         TfSwHTdKV3PirwSBv/Qqkxhc9Ql8jVi711VpCeLvbMFyqTt3k/HxinIF0puOgsJsC+Dk
         rGOp4OfEaIgBNa/DuE8NtXvthstRX7vczUcffh0KXJJavIcKbGPgy6UA9jesJNtW68zd
         uZUsFMaD97hzyJzvM8ik9YUDddFlVdCsdNBJpXxcDvWJcJnajWzShY0k60IsbkZSqDjF
         clFx1OQTwkoOuVopN608Ze/d32l7b8u1OZvbK8SMyQfE5sh6Jeq/8j8x/1uBMTG+oIQZ
         a9+A==
X-Received: by 10.180.99.10 with SMTP id em10mr147119wib.20.1413488443116;
        Thu, 16 Oct 2014 12:40:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.170 with SMTP id s10ls328289wia.30.gmail; Thu, 16 Oct
 2014 12:40:42 -0700 (PDT)
X-Received: by 10.180.36.176 with SMTP id r16mr3037228wij.7.1413488442239;
        Thu, 16 Oct 2014 12:40:42 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id us10si2068737lbc.1.2014.10.16.12.40.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 Oct 2014 12:40:42 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc190d.dip0.t-ipconnect.de ([93.220.25.13] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Xequf-00079g-7a; Thu, 16 Oct 2014 21:40:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54401CAD.4090606@web.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1413488442;21d64568;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Am 16.10.2014 um 21:29 schrieb Torsten B=C3=B6gershausen:
> core.filemode is set automatically when a repo is created.
> But when a repo is exported via CIFS or cygwin is mixed with Git for Wind=
ows
> core.filemode may better be set manually to false.
> Update and improve the documentation.
>=20
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>=20
> Does this reflect the discussion via email ?
> Or is more tweaking needed ?
>=20
>=20
>  Documentation/config.txt | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4333636..b4fea43 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -204,8 +204,23 @@ advice.*::
>  --
> =20
>  core.fileMode::
> -	If false, the executable bit differences between the index and
> -	the working tree are ignored; useful on broken filesystems like FAT.
> +	Tells Git if the executable bit of files in the working tree
> +	is to be honored.
> +
> +	Some filesystems lose the executable bit when a file that is
> +	marked as executable is checked out, or checks out an
> +	non-executable file with executable bit on.  "git init" and
> +	"git clone" probe the filesystem to see if it records
> +	executable bit correctly when they create a new repository
> +	and this variable is automatically set as necessary.
> +
> +	A repository, however, may be on a filesystem that records
> +	the filemode correctly, and this variable is set to 'true'
> +	when created, but later may be made accessible from another
> +	environment that loses the filemode (e.g. exporting ext4 via
> +	CIFS mount, visiting a Cygwin managed repository with
> +	MsysGit).  In such a case, it may be necessary to set this
> +	variable to 'false'.
>  	See linkgit:git-update-index[1].
>  +
>  The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
>=20

[CC'ing msysgit aka git-for-windows/sdk for input]

I'm not really happy with the term MsysGit here.
Would it be too bold to say
[... ] visiting a Cygwin managed repository with Git for Windows.
?

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
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
