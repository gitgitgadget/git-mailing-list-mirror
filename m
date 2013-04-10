From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Script for handling UTF-16 files
Date: Wed, 10 Apr 2013 20:59:56 +0200
Message-ID: <5165B6AC.5090403@gmail.com>
References: <608a349b-cc71-4cba-9197-3783049e9f47@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Ken Ismert <kismert@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBBLPNS2FQKGQEWKMMC3I@googlegroups.com Wed Apr 10 21:00:04 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBLPNS2FQKGQEWKMMC3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBLPNS2FQKGQEWKMMC3I@googlegroups.com>)
	id 1UQ0FS-0007yf-VP
	for gcvm-msysgit@m.gmane.org; Wed, 10 Apr 2013 20:59:59 +0200
Received: by mail-lb0-f189.google.com with SMTP id o10sf259690lbi.6
        for <gcvm-msysgit@m.gmane.org>; Wed, 10 Apr 2013 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=3P6HXyN5TLlzVUHoOBFZl8tTHoixiwVx5uyd/Xb+0zA=;
        b=B+ropnJiQdM8bXAK4opmf+ZVwISCSeTFHXsQtr5GbyxghCQOjUl2OyFgy7WHnLQgQ3
         /a7kAXCqahQJqNF3mwCqZDLAbdcLvURREHP6HRTxYMWGdCE+flxDFG7ns8Uatt8n4wtk
         lx1NnCgoVAJo6/tlrnN3HfTv01YVC6paYyku79jDbqFmE2+3YHMdd0fxSLOiezuERFvp
         SZ4DkKbvjeTCZodnnvq02V48EqD/nPLC8fbGT6blaXDApSxzbkxM03ILxXw7yTpfprwp
         jzTDG 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:received-spf:x-received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=3P6HXyN5TLlzVUHoOBFZl8tTHoixiwVx5uyd/Xb+0zA=;
        b=upDd21EIPmrmmE9gwnAQxBHBenVG3fEQ3vBrZCTzmtsrHvi6FLFfznr6JfnF89Rowv
         o5i36rSTWSIgeszrYVSwW6pvxHOUltzCMMCKYzBTY3/Y5DGK+coY0XwiMaCkwIO4YiJm
         /0pOEzarLqhjrroqUq2xKwbCohDSqUY4L+/YYMrH/1ZcSf/v9HZWO6qRzgz1wvIYTuBt
         YywrhHxAa0L69nUtcwtgqqJ+k6E0pf78dji8+ELwvBcx7FPhA82O6b06E+IHHMkKMX31
         DmOjkJ/Y0nRJ 
X-Received: by 10.180.185.132 with SMTP id fc4mr2025318wic.1.1365620398513;
        Wed, 10 Apr 2013 11:59:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.211.172 with SMTP id nd12ls320847wic.4.gmail; Wed, 10 Apr
 2013 11:59:57 -0700 (PDT)
X-Received: by 10.15.107.200 with SMTP id cb48mr3742069eeb.4.1365620397375;
        Wed, 10 Apr 2013 11:59:57 -0700 (PDT)
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
        by gmr-mx.google.com with ESMTPS id d43si249490eeu.1.2013.04.10.11.59.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 11:59:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 74.125.83.47 as permitted sender) client-ip=74.125.83.47;
Received: by mail-ee0-f47.google.com with SMTP id t10so390429eei.20
        for <msysgit@googlegroups.com>; Wed, 10 Apr 2013 11:59:57 -0700 (PDT)
X-Received: by 10.15.101.200 with SMTP id bp48mr8153936eeb.38.1365620397286;
        Wed, 10 Apr 2013 11:59:57 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id bc1sm1410360eeb.11.2013.04.10.11.59.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 11:59:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <608a349b-cc71-4cba-9197-3783049e9f47@googlegroups.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 74.125.83.47 as
 permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220722>

Am 10.04.2013 01:47, schrieb Ken Ismert:
>=20
> I bumped into the UTF-16 display problem with Git Extensions running on t=
op of msysGit. After lots of searching and experimenting, I came up with a =
solution that works for me.
>=20
> Note: Please see questions below.
>=20
> This method is for MSysGit 1.8.1, and is tested on Windows XP. I use Git =
Extensions 2.44, but since the changes are at the Git level, they should wo=
rk for Git Gui as well. Steps:

There has been a discussion about handling UTF-16 on the git ML a while bac=
k, see http://thread.gmane.org/gmane.comp.version-control.git/159708

As suggested there, I would try to use a clean/smudge filter (i.e. store UT=
F-16 files as UTF-8 in the repository and convert back to UTF-16 on checkou=
t). That way git can treat your UTF-16 files as text in most cases (i.e. yo=
u can merge them, git-grep works, gitattributes work (eol-conversion, ident=
-replacement, built-in diff patterns...)).

If you use a textconv filter, UTF-16 content will be treated as binary by m=
ost git operations.

There's also an 'encoding' attribute and a 'gui.encoding' setting which in =
theory should solve your issue (i.e. specify encoding of files for display =
by GUI tools). I don't know if Git Extensions supports that, or whether its=
 supposed to work for binary files at all.

> 3) Modify the global ~/Git/etc/gitconfig or your local ~/.git/config file=
, and add these lines:
>=20
>     [diff "astextutf16"]
>         textconv =3D astextutf16

Why not simply "textconv =3D iconv -f utf-16 -t utf-8", without the extra s=
cript?

> c) I had success with iconv, but is there any built-in UTF-16 to UTF-8 co=
nverter that ships with msysGit?

There are ready-to-use UTF-conversion functions in the codebase, but these =
are not accessible as a git command or built-in filter.

> As a quick fix, how hard would it be to add a 'utf16' diff filter, simila=
r to cpp or |csharp? Or is this simply the wrong place to put in a work-aro=
und?

As described above, I think a diff filter is not the right tool for the job=
. The only universal format for text content that works reasonably well wit=
h established text-based technologies (merge algorithms, regex etc.) is UTF=
-8. If we want to benefit from these technologies, git should store text fi=
les as UTF-8 and convert from / to platform-specific formats on checkin / c=
heckout or for display.

Bye,
Karsten

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
