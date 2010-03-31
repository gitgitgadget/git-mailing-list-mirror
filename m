From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Are the patches used to build git on cygwin available in a git 
	repo somewhere?
Date: Wed, 31 Mar 2010 23:58:18 +1200
Message-ID: <w2y2cfc40321003310458vc0fc3dddjb47a8a7dddb1c41e@mail.gmail.com>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
	 <20100331025626.GA13501@progeny.tock>
	 <20100331025856.GB13501@progeny.tock>
	 <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
	 <4BB336C1.4000504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 13:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwwYz-0006St-SP
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 13:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab0CaL6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 07:58:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52000 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097Ab0CaL6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 07:58:19 -0400
Received: by pwi5 with SMTP id 5so4162pwi.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tDwis5wCoyyS1/T5ufOlD2gQL6Ed0/9LDmuKukxQq/M=;
        b=avQdDtWV73FHqanPLtKEKPAMISDFAMQotS8HWNoSqMyPjRFHp5jtrhqHJqI1uuc++1
         vve6AaHSU4QnHKgaLB2pV6xN0da+vQSUABdghiaKB0OSccnTb7GbMtagH/OvKOVJBMHb
         p8qNbneZ5CO/bjRqawlKw6LWXn01g3IC+eeME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Eq6BcrMb/mmqyAMZLa1IJTzqgQgU84fjOSAwSfRFcX7KmWTsrX5JidfYt1krAEMkz1
         74AEXMKgSsaCLPHLUtOKHdXPJErX0xt4JTanQhwXvm1q3j35/F8nzNwb/nd9VgYk0EGN
         QsK/iad+ZkH2GTX+gWpT9YMpru5wW+oG2HlZ8=
Received: by 10.114.13.5 with HTTP; Wed, 31 Mar 2010 04:58:18 -0700 (PDT)
In-Reply-To: <4BB336C1.4000504@redhat.com>
Received: by 10.115.38.31 with SMTP id q31mr7577083waj.113.1270036698728; Wed, 
	31 Mar 2010 04:58:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143665>

On Wed, Mar 31, 2010 at 11:49 PM, Eric Blake <eblake@redhat.com> wrote:
> According to Jon Seymour on 3/31/2010 1:55 AM:
>> What I was looking for was a git repo that contains a branch with th=
e
>> patches that the cygwin folks mutate the official git release with.
>> Such a repo would be quite useful because people could, in theory, u=
se
>> these to produce their own cygwin git builds at arbitrary commits
>> instead of having to wait for cygwin to catch up.
>>
>> Admittedly, it is not a big deal to build such a branch using the
>> patch from the cygwin package source, but I was just wondering wheth=
er
>> there was a well-known repo that contained the patches already.
>
> Nope - the patchset that I apply when building the cygwin port is so =
small
> that so far I have just maintained it manually, rather than publishin=
g a
> git repo. =C2=A0But if you want me to make it more public, I can cert=
ainly look
> into doing that. =C2=A0And yes, now that 1.7.x is out for some time n=
ow, I
> should probably advance the cygwin port beyond 1.6.6.1.
>

As you say, it's probably not worth the effort, but if you ever do
decide to set such a thing up, do let me know.

jon.

> --
> Eric Blake =C2=A0 eblake@redhat.com =C2=A0 =C2=A0+1-801-349-2682
> Libvirt virtualization library http://libvirt.org
>
>
