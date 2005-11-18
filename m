From: John Benes <smartcat99s@gmail.com>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 16:49:29 -0600
Message-ID: <437E5A79.9070402@gmail.com>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 19 00:52:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdF3G-0002LJ-BZ
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVKRWtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 17:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVKRWtr
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:49:47 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:54091 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbVKRWtr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 17:49:47 -0500
Received: by zproxy.gmail.com with SMTP id 13so323010nzn
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:49:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=l+mSIqNS2N0JdC+a5HqgkVzNEXSuLdK9JeVvej5WNqCRbdUT+mSzbfXok3MVvNNSfmKnJhZ/AQrNgEonsRZ3kOPrb76i0941r8rLr9IW9Swj93rYGfGPD17CGVazKp/ycs1t14VZnU2M3qBWwjQUYzjVhAcQeTxcK+VBcAGaWQw=
Received: by 10.36.20.16 with SMTP id 16mr257385nzt;
        Fri, 18 Nov 2005 14:49:46 -0800 (PST)
Received: from ?192.168.0.198? ( [68.96.128.241])
        by mx.gmail.com with ESMTP id 24sm285123nzn.2005.11.18.14.49.44;
        Fri, 18 Nov 2005 14:49:46 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051118)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12291>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> I *think* this is the same problem as I fixed tonight with help
> from LASCM and John Benes, and I'm hoping to push the fix out
> before going to bed tonight.  If you are impatient the patch has
> already been sent out.

I can verify that "make test" now passes on Cygwin without NO_MMAP
uncommented.
Commit: 2e67a5f449f4026097494569f871d79bf263ab28
Desc: Cygwin *might* be helped with NO_MMAP

- --
John Benes
GPG Fingerprint: D519 25DB BB5C 38FC 9D02  02E7 596D BC50 F880 27FA
"It is not only the living who are killed in war." - Isaac Asimov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBQ35aeWF0oWcU9kCNAQIpgg/9GFi++HvW5J2GYZbcHhAld2cqd6KtgbPN
oUsbPuvGKSM9uP/9pKhOxp+DKJMuFd9mK5FG63jS8i8bthbEzegErLWcfbfM1+Js
0kYIfQEZpJu0+S1uMfsHX1CfS/OtjHebQCD7M9jgMFa1kgJXZl0Zu1rvG5hxTIZV
OwssVwxz9Z2/gWzKFlAwyL4UgI4/mr2f7t43AVSKI0gR0Dry8Ou6B7vjBid9clMd
JNoVHF437FVzAypoSUjmgHJJt+GHYn5noQTOMD0KnokznQckFVxNdALXaoAgkT1Q
adgY+8TObmTbctJ9q2Qi1Z9Y0CAncC0TEGt8D8FBxiH+eJKqEKdmL7JT3ckaQO6S
WZJf/u9SnkUJ089rYbYCvV10hqXz0y5XcGxo8kRKS6XGnY+Ff0hqtxVtHqbog8+y
RtPyeST3vymkPuxx3g/gHrGtXJSZStE2/uNTKyA6IHA9dRUkLn70vHRKZsKKyj/f
n5Ka1CJhIw+DzN4tANsQz9U/Q1olbQIr1khykds5DOhTvdSydSQtT3yOx9Wtt8QZ
OH16pbWSGRNuL/vtwmonnVDsX/JJkUKSn3Z5gwmIvThvrD5TbJjyyYBaYZ9xvtkK
XShm05Xf0yaryVlyUNCjlfNoLhi+gBoTVeaZmx/c1yrDZL6I53g3S79Bktdfd/rE
r0eQqS7GEWc=
=+a+2
-----END PGP SIGNATURE-----
