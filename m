From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Tue, 20 Nov 2012 13:20:15 -0500
Message-ID: <CAFj1UpFTu7GnpKSvs6qGH6XjAT16RAk4rmdX0sPFOo9ABg8BKg@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
	<7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0y3UPVT+ndELaKNsWXAPG3kv-Xq_Wf6ONDF3Z99A5zMQ@mail.gmail.com>
	<CAFj1UpFbuHVhPOQVB9-sPjW2aBN=H+OUyYnz00qASZ5ssbwmGw@mail.gmail.com>
	<CAMP44s30wYnkQdq8yup3z-t=FEf1R+k8OC-o7-uY=19z9VHDPg@mail.gmail.com>
	<CAFj1UpHs08seVH8Kb3CuoNTaF+x6vA+ybVTEu0TyLX8NYuuidQ@mail.gmail.com>
	<CAMP44s1i59VtX9xMmM-j3Gzcufg6jtKy34MMuwrfenmSw3oLAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:20:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TasR3-0004GS-29
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 19:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab2KTSUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 13:20:22 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65268 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab2KTSUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 13:20:19 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so9040601iea.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ungx6qLkZG/MYkylC9RIneWRfLBl1J69hCDpOM5YuS4=;
        b=cqMO33iV5nStetnBGTvsE8upJB9qxO5LovQJyvmVJWR12WBecQ0xHXkm1/nB9JHCuo
         K8nDvHETBgO3FVmxjv/NjOeRK05W9vxQ8x0B2+2JGrp3JMo24FKLZbUmkVJaEFe8613a
         /+oVQczHXfw1yLn5VAHfn43VNL++l6Wln/cU5ksByZvdOTGRaiMT0v0hBtGrAMJcEdms
         V/eXCmZq9hZ5CxAm+2+3EY9RCPS5Zl4MVYmvZnjg2JawkrqvmfH/FufaJ4f6IKyIuDtl
         SzV84ob8RRlptFf+yeQGStMYkHJKMRiUJRD0KubDtQHLihoe7ofF8iVLI1xCtnNc82py
         NkAw==
Received: by 10.50.140.104 with SMTP id rf8mr11143555igb.40.1353435616713;
 Tue, 20 Nov 2012 10:20:16 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Tue, 20 Nov 2012 10:20:15 -0800 (PST)
In-Reply-To: <CAMP44s1i59VtX9xMmM-j3Gzcufg6jtKy34MMuwrfenmSw3oLAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210104>

On Tue, Nov 20, 2012 at 10:15 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Nov 20, 2012 at 3:58 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>
>> Hi,
>>
>> since there doesn't seem to be an agreement that the approach to achieve tcsh
>> git-completion would be useful for zsh (the other possible shell that could use
>> it is ksh, but I haven't looked into that), maybe the simplest thing
>> is to keep the
>> tcsh solution contained in a tcsh-only script.  This is the latest solution as
>> proposed here:
>>
>> [1] http://www.mail-archive.com/git@vger.kernel.org/msg12192.html
>
> This one is already merged to 'next'.

Awesome!  I didn't notice.

If I want to suggest an improvement (like checking if the bash script
is available),
do I just post a patch here?

Thanks a lot for moving forward with this so quickly!

Marc
