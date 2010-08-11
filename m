From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 03:44:43 -0500
Message-ID: <20100811084443.GF16495@burratino>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com>
 <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
 <20100809234620.GA6418@burratino>
 <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
 <20100811075503.GD5450@burratino>
 <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
 <20100811082953.GA16456@burratino>
 <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6wz-0005ip-22
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717Ab0HKIqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:46:12 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35362 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612Ab0HKIqL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:46:11 -0400
Received: by gxk23 with SMTP id 23so4027752gxk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bgsn/CPVQpSgMjyDdixdBgjd1MSs0tsxwGHKV6rp+hA=;
        b=fuVm7b+w7/o8nwb3sIefnNXEpNYl2OflBvCjAgiE5ddmtC2fMxKNhUxowrl3dMTUrr
         B3h3cLmluG96gNVbBwGuoHEzfo9vIMreZvCnp+s3hW5UdnlDB+cOjwq1nlDuRBG8iapA
         6KqlW8dzG0dSLXKAkXRdetOnDh9DtVCN5ePew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AZMuhPtmqTMuI7xe40RsZgaAB04fN/8pL/lEgtDNrQ8RVvxfm92RVDD6CVpAv1S6Rj
         GSOp+JvLestLylsfVQpNw7DDE1ic5DUx1VGd97Dhge8Jr1El56JTEWHHnaru6O48Q7lr
         DcIwI2a9G4TPWIdB1Xov+hVL22QPNuxjdUMcc=
Received: by 10.100.152.9 with SMTP id z9mr11200985and.245.1281516371073;
        Wed, 11 Aug 2010 01:46:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a12sm12282618and.36.2010.08.11.01.46.10
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:46:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153214>

=C4=B0smail D=C3=B6nmez wrote:
> On Wed, Aug 11, 2010 at 11:29 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sh t4201-shortlog.sh --immediate
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cat "trash directory.t4201-shortlog/log"
>>
>> is what I meant. =C2=A0The idea is to get the log that that log.pred=
ictable
>> is based on, by fetching the log from immediately after the failing =
test.
>
> Ok here we go;

Okay, I=E2=80=99m stymied.  It *looks* like a sed bug even if a quick
test did not catch it in the act.

I guess the last thing to try is

	sed "s/^ \{6\}[CTa].*/      SUBJECT/g" <"trash directory.t4201-shortlo=
g/log"

because then you would have a test case to report to your sed
supplier.

Hopefully someone else with Mac OS X can reproduce this. =20

Thanks again.
