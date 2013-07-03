From: Dany <nessup@gmail.com>
Subject: Re: Feature request:
Date: Wed, 3 Jul 2013 16:53:18 -0700
Message-ID: <686269E5-8539-42F9-B0B6-D7CA996A4FF2@gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com> <vpqehbgrnrx.fsf@anie.imag.fr> <CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com> <7vppuzfrde.fsf@alter.siamese.dyndns.org> <loom.20130704T013747-723@post.gmane.org> <67824DCD-A486-476D-9A04-D18B083DB090@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 04 01:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuWrV-0002Tb-IM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 01:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183Ab3GCXxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 19:53:22 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36689 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3GCXxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 19:53:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so721189pab.25
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=quUnqX3afcE41CS+sC10e7dEG3wFSGWzxsYCzIf/ruc=;
        b=FzN74WPgL6ORySPMYbBSC+/5Da8rN9w0dVPdZOk2a/MRS/H5F7AAaOxcYbDb3U8V6c
         3WHaK5h+omeZdFm4mAvGsOzJj7jUHYDeHt47Jz1wrU1vyViZEx8uIPOpSMnoOf6WJyXj
         6nRehdw1OtlK63CdbJXjSXRMYNUzue6dLljhHu6m8hiYP3nScCTBZ7TSMuCDCCqHpMlt
         mezvtsEnf+rPcRHmP9xiL7Qb5/6OD5Byd0HW1bLC/Ywb3fJ0AtpjxEFr6u/lbnq3Ct1J
         s8AI3hurGG7u9IKYZr9QVg297FwAZjSSyRkBzs2tG5s8Id09WyDEE8QxxCmQI6tKG8a0
         i30Q==
X-Received: by 10.68.1.226 with SMTP id 2mr2907202pbp.150.1372895600905;
        Wed, 03 Jul 2013 16:53:20 -0700 (PDT)
Received: from [192.168.1.20] (c-76-102-3-186.hsd1.ca.comcast.net. [76.102.3.186])
        by mx.google.com with ESMTPSA id zn4sm696719pac.21.2013.07.03.16.53.19
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 16:53:19 -0700 (PDT)
In-Reply-To: <67824DCD-A486-476D-9A04-D18B083DB090@gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229550>

lol, confusion abound. this message was intended to be in response to "=
Re: Feature request: prevent push -f from pushing all branches at once"

On Jul 3, 2013, at 4:52 PM, Dany <nessup@gmail.com> wrote:

> Hey Jonathan,
>=20
> Thanks for the quick reply. I think that's a great message; I do have=
 to say that I wouldn't have known what the `matching` and `simple` mod=
es are without that message; I just had to look it up is all. It may be=
 helpful to tell users that `simple` is probably what they want :)
>=20
> @DanyJoumaa
> 1 520 991 5001
>=20
> On Jul 3, 2013, at 4:46 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>=20
>> [I'm sorry about breaking Cc: chain - responding via GMane web inter=
face]
>>=20
>> Junio C Hamano <gitster <at> pobox.com> writes:
>>> Ed Hutchins <eh <at> demeterr.com> writes:
>>>=20
>>>> I'm not trying to change the way git does things (which works perf=
ectly
>>>> well), I'm asking for some extra information to be added to the co=
mmit
>>>> so that analysis of the ancestry graph can be tied to the branch t=
opics
>>>> that the original author was working from. [...]
>> [...]
>>> It is not just misleading but is actively wrong to recording the
>>> name of the original branch in commits and carrying them forward vi=
a
>>> rebase. If you want a record of what a group of commits were about,
>>> the right time to do so is when you merge.
>> [...]
>>=20
>> There is even git-resurrect.sh script in 'contrib/' that makes
>> use of that practice to find merged-in and deleted branches,
>> and resurrect them (among other tools).
>>=20
>> --=20
>> Jakub Nar=C4=99bski
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
