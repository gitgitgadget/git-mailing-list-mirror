From: "Reid Woodbury Jr." <reidw@rawsound.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Fri, 3 Apr 2015 17:19:21 -0700
Message-ID: <701694C7-311A-4625-A871-48D5F04EB0F9@rawsound.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com> <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com> <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com> <20150402193524.GA21555@peff.net> <551DD887.2010403@web.de> <51689E6C-93FD-4E77-8FF3-BB8EC7EA735A@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org list" <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 02:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeBoA-0000RQ-1p
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 02:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbbDDATZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 20:19:25 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34217 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbDDATY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 20:19:24 -0400
Received: by pdbni2 with SMTP id ni2so136464294pdb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 17:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=kqiKw7aqnt6FTdL8u/ve3Ho7TREfLaiSpCqPG5webpY=;
        b=jmy4+cb7A5ybYp64W8jqHrTVWLyioSXBVFwyhADUvbYSROqIUqv3yFAwlPYKtsOtOL
         vpN0CCux8xM3SLRpdKaCmi3PXHcDkTHFA/pyNCQMIUxt/VbEkQUO7f6dTkkI662dDAdK
         +sojpPYiRK4DfhT3jbEShtaXA2lrfZdMFOmlxai87eVvnJFbSI7SiHi3bnBZgLaaR6yg
         TmxrP559uWRuG7Z6VSxKfxnllFcSAdRd3g/csiqm2PW6g3Mi6FlTjrNXcXx31k6ZeEBy
         ZZfI93irINIENu2azPeUYPtUalYBhou56fsGnAxiN7YniT3+qIBZ0Fu0ntC/63DUVnpX
         DDrw==
X-Gm-Message-State: ALoCoQnCk752Znu5SgoOWvD/mWHHzA5ZyU0vOV0vrLZLUgV0/QQLICrSQ8iy+h9YkfF4WjmSFbUR
X-Received: by 10.68.179.100 with SMTP id df4mr8154568pbc.13.1428106763778;
        Fri, 03 Apr 2015 17:19:23 -0700 (PDT)
Received: from [192.168.1.87] (107-128-47-25.lightspeed.irvnca.sbcglobal.net. [107.128.47.25])
        by mx.google.com with ESMTPSA id h9sm9216965pdo.5.2015.04.03.17.19.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 Apr 2015 17:19:23 -0700 (PDT)
In-Reply-To: <51689E6C-93FD-4E77-8FF3-BB8EC7EA735A@gmail.com>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266750>

Thanks for keeping me in the loop!

I have two thoughts on handling input:

As a coder I want to know exactly what's going on in my code. If I've g=
iven erroneous input I'd like to know about it in the most useful and q=
uickest way, never glossed over, liberally accepted, nor fixed for me e=
ven if the input is non-ambigous. I won't learn the right way unless I'=
m told. I enjoy that when I've typo'd a command in GIT it gives useful =
suggestions to what I might have meant.

But, most of the coding *I* do is for the non-coder or the general end =
user. These might be people that would reasonably yell at their compute=
r screen "you know what I meant!" So I try to be more liberal in the in=
put I write code to accept by filtering it, cleaning it, etc. I'll even=
 filter input by keystroke when possible. I have the philosophy: don't =
tell the user that they input something bad, just prevent them from inp=
utting it to begin with. I know, this is appropriate when building a GU=
I and not for CLI.

thanks for listening
Reid Woodbury


> On Apr 3, 2015, at 2:32 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
>=20
> On Apr 2, 2015, at 17:02, Torsten B=F6gershausen wrote:
>=20
>> On 2015-04-02 21.35, Jeff King wrote:
>>> On Thu, Apr 02, 2015 at 12:31:14PM -0700, Reid Woodbury Jr. wrote:
>>>=20
>>>> Ah, understand. Here's my project URL for 'remote "origin"' with a
>>>> more meaningful representation of their internal FQDN:
>>>>=20
>>>> 	url =3D ssh://rwoodbury@systemname.groupname.online:/opt/git/inve=
ntory.git
>>>>=20
>>>> The "online" is their literal internal TLD.
>>>=20
>>> Thanks. The problem is the extra ":" after "online"; your URL is
>>> malformed. You can just drop that colon entirely.
>>>=20
>>> I do not think we need to support this syntax going forward (the co=
lon
>>> is meaningless here, and our documentation is clear that it should =
go
>>> with a port number), but on the other hand, it might be nice to be =
more
>>> liberal, as we were in v2.3.3 and prior. I'll leave it to Torsten t=
o see
>>> whether supporting that would hurt some of the other cases, or whet=
her
>>> it would make the code too awkward.
>>>=20
>>> -Peff
>>=20
>> Thanks for digging.
>>=20
>> This makes my think that it is
>> a) non-standard to have the extra colon
>=20
> It's not.  See RFC 3986 appendix A:
>=20
>  authority =3D [ userinfo "@" ] host [ ":" port ]
>=20
>  port =3D *DIGIT
>=20
> "*DIGIT" means (see RFC 2234 section 3.6) zero or more digits.
>=20
>> b) The error message could be better
>> c) We don't have a test case
>> d) This reminds my of an improvement from Linus:
>> 608d48b2207a61528
>> ......
>>   So when somebody passes me a "please pull" request pointing to som=
ething
>>   like the following
>>=20
>>   	git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.gi=
t
>>=20
>>   (note the extraneous colon at the end of the host name), git would=
 happily
>>   try to connect to port 0, which would generally just cause the rem=
ote to
>>   not even answer, and the "connect()" will take a long time to time=
 out.
>> .....
>>=20
>> Sorry guys for the regression, the old parser handled the extra colo=
n as "port 0",
>> the new one looks for the "/" as the end of the hostname (and the be=
ginning of the path)
>>=20
>> Either we accept the extra colon as before, or the parser puts out a=
 better error message,
>=20
> [...]
>=20
>> Spontaneously I would say that a trailing ':' at the end of a hostna=
me in the ssh:// scheme
>> can be safely ignored, what do you think ?
>=20
> You know, there is a "url_normalize" routine in urlmatch.h/urlmatch.c=
 that checks for a lot of these things and provides a translated error =
message if there's a problem as well as normalizing and separating out =
the various parts of the URL.  It does not currently handle default por=
ts for anything other than http[s] but it would be simple enough to add=
 support for ssh, git, ftp[s] and rsync default ports too.
>=20
> -Kyle
