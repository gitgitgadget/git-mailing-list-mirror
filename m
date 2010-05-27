From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() 
	emulation
Date: Thu, 27 May 2010 14:57:52 +0200
Message-ID: <AANLkTiliJFXWKXnksQryvAivadrkTUeZ1Wu7FkUGm2YZ@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>
	<AANLkTinXwM1fem6E3RgnLW9vqLD1fV7JvaQnxzZVRakA@mail.gmail.com>
	<AANLkTinX8nK68rZtN5dwJ-fGQm4gR2G84xo9raxb4vLY@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org, 
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>, 
	Michael J Gruber <git@drmicha.warpmail.net>, Johannes Sixt <j6t@kdbg.org>, 
	msysGit <msysgit@googlegroups.com>
To: Marko Kreen <markokr@gmail.com>
X-From: msysgit+bncCOPdven-DxDU2PnfBBoEfBVZjg@googlegroups.com Thu May 27 14:58:21 2010
connect(): No such file or directory
Return-path: <msysgit+bncCOPdven-DxDU2PnfBBoEfBVZjg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDU2PnfBBoEfBVZjg@googlegroups.com>)
	id 1OHcfE-0006JF-U0
	for gcvm-msysgit@m.gmane.org; Thu, 27 May 2010 14:58:21 +0200
Received: by wwb24 with SMTP id 24sf214664wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 May 2010 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:received
         :reply-to:in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=+mO8wzAfDViJxc1U+H8x0jdSiOw7di6gRB7CgqUOQiw=;
        b=WnjZ6Vlvkz1SUXvpZzsefNOmyhJR4Yy2ZgdxXP2sCNI9RGJAS8UG9A3JdWCGrE1sii
         HrYQWV7RynQo+ajz9t9gYcUrAI16JB/vHo2VPGcOJ7ysOMuYg46Xe/ZT54/Xmm+wGvPk
         +MXbdkyLD+db5mAB6ABT9vXlopWNHJADLHNqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=o3Z/fJfgpkA2NfIdIAPkgFNY8MdJXodbwRtkfFraUEcIJut4i1ZXKm5huqPA8GhkM2
         nhfrbdg6jeeqrhkYXkMGghHecz3g4j90dHCURTbtZo3KYSrECDN9KwM0qGmSVI8xYlhZ
         rCCBmmH0QSgtkmLcU/YFaP1RpcL4HEnKkAvf8=
Received: by 10.216.67.2 with SMTP id i2mr643189wed.8.1274965076814;
        Thu, 27 May 2010 05:57:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.27.65 with SMTP id h1ls1043896wbc.1.p; Thu, 27 May 2010 
	05:57:55 -0700 (PDT)
Received: by 10.227.155.85 with SMTP id r21mr661190wbw.13.1274965075179;
        Thu, 27 May 2010 05:57:55 -0700 (PDT)
Received: by 10.227.155.85 with SMTP id r21mr661189wbw.13.1274965075153;
        Thu, 27 May 2010 05:57:55 -0700 (PDT)
Received: from mail-ww0-f50.google.com (mail-ww0-f50.google.com [74.125.82.50])
        by gmr-mx.google.com with ESMTP id h25si1293860wbc.4.2010.05.27.05.57.54;
        Thu, 27 May 2010 05:57:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.82.50 as permitted sender) client-ip=74.125.82.50;
Received: by mail-ww0-f50.google.com with SMTP id 33so1560948wwc.37
        for <msysgit@googlegroups.com>; Thu, 27 May 2010 05:57:54 -0700 (PDT)
Received: by 10.216.91.12 with SMTP id g12mr624921wef.78.1274965073087; Thu, 
	27 May 2010 05:57:53 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 05:57:52 -0700 (PDT)
In-Reply-To: <AANLkTinX8nK68rZtN5dwJ-fGQm4gR2G84xo9raxb4vLY@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 74.125.82.50 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147850>

On Thu, May 27, 2010 at 2:36 PM, Marko Kreen <markokr@gmail.com> wrote:
> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Thu, May 27, 2010 at 1:39 PM, Marko Kreen <markokr@gmail.com> wrote:
>> =A0> On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> =A0>> On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.=
com> wrote:
>> =A0>> =A0> Implement the subset of poll() semantics needed by git in ter=
ms of
>> =A0>> =A0> select(), for use by the Interix port. =A0Inspired by commit =
6ed807f
>> =A0>> =A0> (Windows: A rudimentary poll() emulation, 2007-12-01).
>> =A0>> =A0>
>> =A0>>
>> =A0>>
>> =A0>> A possible problem with this approach is that the maximum number o=
f
>> =A0>> =A0file descriptors poll can handle limited by RLIMIT_NOFILE, wher=
eas the
>> =A0>> =A0maximum number of file descriptors select can handle is limited=
 by
>> =A0>> =A0FD_SETSIZE.
>> =A0>>
>> =A0>> =A0I don't think this is a big problem in reality, though - both v=
alues
>> =A0>> =A0seem to be pretty high in most implementations. And IIRC git-da=
emon is
>> =A0>> =A0the only one who needs more than 2, and it doesn't even check
>> =A0>> =A0RLIMIT_NOFILE.
>> =A0>>
>> =A0>> =A0If we decide to go this route, perhaps it'd make sense to chang=
e to
>> =A0>> =A0this code for Windows also? Our Windows-implementation of poll(=
) has
>> =A0>> =A0some annoying limitations...
>> =A0>
>> =A0> Example of poll() compat without FD_SETSIZE limit:
>> =A0>
>> =A0> =A0http://github.com/markokr/plproxy-dev/blob/master/src/poll_compa=
t.c
>> =A0>
>>
>>
>> How does this code convince FD_SET() that the buffer has increased? It
>> =A0looks to me like it depends on a specific FD_SET() implementation...
>> =A0For instance, Windows' FD_SET() implementation is like this:
>>
>> =A0#define FD_SET(fd, set) do { \
>> =A0 =A0 if (((fd_set FAR *)(set))->fd_count < FD_SETSIZE) \
>> =A0 =A0 =A0 =A0 ((fd_set FAR *)(set))->fd_array[((fd_set FAR
>> =A0*)(set))->fd_count++]=3D(fd);\
>> =A0} while(0)
>>
>> =A0...so unless another set is passed in, it won't add any more fds once
>> =A0fd_count reaches FD_SETSIZE.
>>
>> =A0Also, FD_SETSIZE is 64 on Windows. IIRC it's 1024 on Linux, so it is
>> =A0much more likely that we encounter this issue on Windows than on
>> =A0Linux, at least ;)
>
> Hm, good catch. =A0Seems such compat poll() cannot be done without
> OS-specific hacks.
>

Perhaps getrlimit() could overridden to return FD_SETSIZE for both the
soft and hard limit when asking about RLIMIT_NOFILE? In such cases,
anyone who passes nfds above FD_SETSIZE hasn't consulted
RLIMIT_NOFILE, and should be outside the standard. But your point
might have been about a limitless poll()-implementation, like the code
you linked tried to achieve. In that context, no. I doubt it's
possible to do in a robust fashion.

For git, I don't think this is necessary, though. As said, I think
git-daemon is the only call-site for poll where nfds can be above 2.
And git-daemon's default max-connection is 32, which shouldn't cause
much problems. There's the theoretical problem of someone setting
--max-connections above their platform's limit, but I don't think we
need to touch that ;)

> Do you know perhaps what other OS-es have non-bitmap fd_set?

No, I don't have much low-level file-descriptor knowledge about other
OS'es than Windows, really.

--=20
Erik "kusma" Faye-Lund
