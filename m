From: "Marcus D. Hanwell" <marcus.hanwell@kitware.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sun, 18 Mar 2012 01:43:43 -0400
Message-ID: <CAMkPkZVuW-5=o=pdfrymVkPu3k_DS1DDH_wuGXoXnq3=Z+LN_w@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
	<CADVrmKSGbA2gWVyPLMCBay3EikOykwq3eEH1+qWCpZvOron3Aw@mail.gmail.com>
	<4F655E53.6030408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: fREW Schmidt <frioux@gmail.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 06:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S98ul-0001BU-5Z
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 06:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab2CRFnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 01:43:45 -0400
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:33865 "HELO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1752899Ab2CRFnp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 01:43:45 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]) (using TLSv1) by na3sys009aob128.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT2V2D7F61N7p7l8EYb2BMFk4f+TaQQVT@postini.com; Sat, 17 Mar 2012 22:43:44 PDT
Received: by mail-wg0-f43.google.com with SMTP id dr12so424967wgb.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 22:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=x9NNEJuwQ7S6aXusRdX3WueGZVlXEA8Ip/3HYX3I3Q8=;
        b=aN/QLLw5DX4vwI9Sp8iFejrHaf1ZdWL75+fyFoLBUOCsMzb1ic1xdqwSDGdhKdbtDz
         eoRQjF9iGwuAcd1vASIejfcNIBRDdaV2Us4eoWAXyJd0OuGTgHn39RNK8fjzvgEyA+eK
         H/zoCNdLfAKbY1BZxovdyR4Ie2zVdwkXqnN80EtE0sNWCGSTojYuzreDlOtEjSvYQbht
         jnN/IoZrzuDDIIAR1uypWxdAqMXjaZmGzEKYVh0cf/IyqoCFpQfu1mvnDyq5GKfZOYsV
         YWDi1PzEO/VNPtwd1L+/suOCgm6hOfbvnXxbv8eFgBlnabye3AiF9KmRoExqg2H2Y1ad
         bivA==
Received: by 10.180.96.168 with SMTP id dt8mr10245669wib.18.1332049423578;
 Sat, 17 Mar 2012 22:43:43 -0700 (PDT)
Received: by 10.227.59.196 with HTTP; Sat, 17 Mar 2012 22:43:43 -0700 (PDT)
In-Reply-To: <4F655E53.6030408@zytor.com>
X-Gm-Message-State: ALoCoQm6V7tqN1P/Hm5+lNZPiDBcHQIz5g67EUcmNMVssmE7AC1Cvt7jIAH2ueS/RSqcogzp3nKi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193371>

On Sun, Mar 18, 2012 at 12:02 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 03/17/2012 11:43 AM, fREW Schmidt wrote:
>> On Sat, Mar 17, 2012 at 12:10 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>
>>> There is a proposal to change the default behaviour of 'git push' o=
n the
>>> Git mailing list. The goal of this message is to encourage you to d=
iscuss
>>> it before it happens (or the change is aborted, depending on the ou=
tcome
>>> of the discussion).
>>
>> I personally much prefer the one where it pushes the current branch =
to
>> its tracking branch only. =A0That leaves very little room for surpri=
ses
>> and mistakes (the one exception being git push after git checkout -b
>> new-branch origin/master.)
>>
>
> I would agree with this being the least surprising behavior. =A0I bel=
ieve
> this is what push.default =3D upstream does.
>
I agree that the least surprising default is to push the current
branch to its tracking branch only. It always surprised me that other
branches tried to push too.

Marcus
