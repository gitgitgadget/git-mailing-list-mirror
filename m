From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 06 Jun 2014 11:43:03 +0200
Message-ID: <53918D27.7060604@gmail.com>
References: <20140605080519.GB28029@camelia.ucw.cz> <5390A139.2090406@kdbg.org> <5390E893.9060600@gmail.com> <20140606083233.GB1303@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBJU2Y2OAKGQEXBDOMPA@googlegroups.com Fri Jun 06 11:49:52 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBJU2Y2OAKGQEXBDOMPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJU2Y2OAKGQEXBDOMPA@googlegroups.com>)
	id 1Wsqfv-0001Jt-0r
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 11:43:03 +0200
Received: by mail-wi0-f191.google.com with SMTP id r20sf62395wiv.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=+iuXZvpILPH/KXjz9HpJj4wQVNYARlo3Fl5TtEU1RuI=;
        b=A5WtBIIgxRsfPpU0+WE8IkCo348b9bGC81+gNuOeoFk6tbP5znhwfacQBFqVbahtzS
         /1OuaQG1/qTzMjQG4IoyTFK85PK2g2KL6bmxIp2cA5tXzAXvdHokl4YMTb1gqTJRP3tD
         RRgx46GsdUBty3Rl5G0MR5a1/WN2c2rRMbw3pSLU5e2heC3uZgljS/VOkgi/T+MuYVQw
         713Zor9U2smTr9Voc2hppVBEjV0fyIsckOurnUwKUUCADpGwpnmO4KZsZg03cD6mzSAc
         lbLYxwiF0XY+SBsPjqUyj2cD2bdqAcoOxy1dpFTFfNjPsxLTz1xEPdk/5XIn2pCICfEF
         yMzQ==
X-Received: by 10.152.37.200 with SMTP id a8mr6066lak.19.1402047782573;
        Fri, 06 Jun 2014 02:43:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.200 with SMTP id u8ls111235lau.33.gmail; Fri, 06 Jun
 2014 02:43:01 -0700 (PDT)
X-Received: by 10.152.6.97 with SMTP id z1mr1179463laz.0.1402047781511;
        Fri, 06 Jun 2014 02:43:01 -0700 (PDT)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id e12si1612599wiv.1.2014.06.06.02.43.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 02:43:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231 as permitted sender) client-ip=2a00:1450:400c:c00::231;
Received: by mail-wg0-f49.google.com with SMTP id m15so2553046wgh.32
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 02:43:01 -0700 (PDT)
X-Received: by 10.14.203.199 with SMTP id f47mr617690eeo.3.1402047781414;
        Fri, 06 Jun 2014 02:43:01 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ci54sm21657010eeb.19.2014.06.06.02.42.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 02:43:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140606083233.GB1303@camelia.ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250897>

Am 06.06.2014 10:32, schrieb Stepan Kasal:
> Hello,
>=20
> On Fri, Jun 06, 2014 at 12:00:51AM +0200, Karsten Blees wrote:
>> Am 05.06.2014 18:56, schrieb Johannes Sixt:
>>> Within mingw.c, if some other function inside mingw.c wants to use
>>> mingw_unlink, then it should be written as 'mingw_unlink(foo)', not
>>> 'unlink(foo)'.
>> I very much like this approach. In fact, we already do this for e.g. min=
gw_raise.
>=20
> Hannes, this is consistent with your commit 06bc4b7.  Settled.
>=20
>> Other callers would typically want the wrapped version (i.e.
>> mingw_*).
>=20
> If this assumption were true, then we have to keep the wrapper macros
> defined, both above and below the wrapper function definition.

That's not what I meant. Assume all other callers are written 'mingw_foo', =
as suggested by Hannes, and no one except 'mingw_foo' has the need to call =
MSVCRT's 'foo' directly. Then its irrelevant whether the #undef is at the t=
op or immediately before 'mingw_foo'. Having the #undef in close vicinity o=
f the function definition helps removing it when its no longer needed.

Thinking about this some more, the best solution is probably to eliminate t=
he problem altogether by adding inline-wrappers for required CRT-functions,=
 e.g.:

mingw.h:

static inline int crt_gethostname(char *host, int namelen)
{
	return gethostname(host, namelen);
}
int mingw_gethostname(char *host, int namelen);
#define gethostname mingw_gethostname

mingw.c:

int mingw_gethostname(char *name, int namelen)
{
    ensure_socket_initialization();
    return crt_gethostname(name, namelen);
}

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
