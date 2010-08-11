From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 12:01:46 +0300
Message-ID: <AANLkTi=sBNmMoZmqO_-AFNO6bVqtJmXbdXYUf7-bKars@mail.gmail.com>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com> 
	<AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com> 
	<20100809234620.GA6418@burratino> <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com> 
	<20100811075503.GD5450@burratino> <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com> 
	<20100811082953.GA16456@burratino> <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com> 
	<20100811084443.GF16495@burratino> <AANLkTinS0BeHWNJ0mCtTbVRz=7FBwE0_OTKDfS2gPXdN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:02:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj7CQ-00043F-FB
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763Ab0HKJCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 05:02:07 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:58965 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640Ab0HKJCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 05:02:06 -0400
Received: by pxi10 with SMTP id 10so383127pxi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 02:02:06 -0700 (PDT)
Received: by 10.142.158.21 with SMTP id g21mr13983407wfe.161.1281517326189; 
	Wed, 11 Aug 2010 02:02:06 -0700 (PDT)
Received: by 10.142.178.20 with HTTP; Wed, 11 Aug 2010 02:01:46 -0700 (PDT)
In-Reply-To: <AANLkTinS0BeHWNJ0mCtTbVRz=7FBwE0_OTKDfS2gPXdN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153216>

Hi again;

On Wed, Aug 11, 2010 at 11:47 AM, =C4=B0smail D=C3=B6nmez <ismail@namtr=
ac.org> wrote:
> On Wed, Aug 11, 2010 at 11:44 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed "s/^ \{6\}[CTa].*/ =C2=A0 =C2=A0 =C2=A0=
SUBJECT/g" <"trash directory.t4201-shortlog/log"
>>
>
> A U Thor (5):
> =C2=A0 =C2=A0 =C2=A0SUBJECT
> =C2=A0 =C2=A0 =C2=A0SUBJECT
> =C2=A0 =C2=A0 =C2=A0SUBJECT
> =C2=A0 =C2=A0 =C2=A0SUBJECT????s ????s a very, very long f????rst l??=
??ne for the
> comm????t message to see ????f ????t ????s wrapped correctly
> =C2=A0 =C2=A0 =C2=A0SUBJECT
>
> Someone else (1):
> =C2=A0 =C2=A0 =C2=A0SUBJECT
>
> I will try updating my sed, thanks!

Downgrading my sed to v 4.1.5 fixed the issue. Thanks for your help!

Regards,
ismail
