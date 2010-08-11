From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 11:33:35 +0300
Message-ID: <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com> 
	<AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com> 
	<20100809234620.GA6418@burratino> <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com> 
	<20100811075503.GD5450@burratino> <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com> 
	<20100811082953.GA16456@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6l7-0008Uj-DE
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab0HKId5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:33:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47358 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab0HKId4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:33:56 -0400
Received: by pwj7 with SMTP id 7so2060473pwj.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:33:55 -0700 (PDT)
Received: by 10.142.180.1 with SMTP id c1mr16048803wff.25.1281515635160; Wed, 
	11 Aug 2010 01:33:55 -0700 (PDT)
Received: by 10.142.178.20 with HTTP; Wed, 11 Aug 2010 01:33:35 -0700 (PDT)
In-Reply-To: <20100811082953.GA16456@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153204>

On Wed, Aug 11, 2010 at 11:29 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> =C4=B0smail D=C3=B6nmez wrote:
>
>> [~/Sources/git/t]> =C2=A0sh t4201-shortlog.sh
>> ok 1 - setup
>> not ok - 2 default output format
>> #
>> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git shortlog HEAD >log &=
&
>> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fuzz log >log.predictabl=
e &&
>> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cmp expect.template=
 log.predictable
>> #
>> ok 3 - pretty format
>
> Oops, my bad.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sh t4201-shortlog.sh --immediate
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cat "trash directory.t4201-shortlog/log"
>
> is what I meant. =C2=A0The idea is to get the log that that log.predi=
ctable
> is based on, by fetching the log from immediately after the failing t=
est.

Ok here we go;


[~/Sources/git/t]>        sh t4201-shortlog.sh --immediate
ok 1 - setup
not ok - 2 default output format
#=09
#		git shortlog HEAD >log &&
#		fuzz log >log.predictable &&
#		test_cmp expect.template log.predictable
#=09
[ismail@havana][11:32:29]
[~/Sources/git/t]> cat "trash directory.t4201-shortlog/log"
A U Thor (5):
      Test
      This is a very, very long first line for the commit message to
see if it is wrapped correctly
      Th=F0=9D=84=9Es =F0=9D=84=9Es a very, very long f=F0=9D=84=9Erst =
l=F0=9D=84=9Ene for the comm=F0=9D=84=9Et message
to see =F0=9D=84=9Ef =F0=9D=84=9Et =F0=9D=84=9Es wrapped correctly
      Th????s ????s a very, very long f????rst l????ne for the
comm????t message to see ????f ????t ????s wrapped correctly
      a								12	34	56	78

Someone else (1):
      Commit by someone else
