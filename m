From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Tue, 20 Nov 2012 09:58:50 -0500
Message-ID: <CAFj1UpHs08seVH8Kb3CuoNTaF+x6vA+ybVTEu0TyLX8NYuuidQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 15:59:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TapI2-0008Ev-N8
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 15:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab2KTO6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 09:58:51 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38781 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab2KTO6u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 09:58:50 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so4270382iay.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 06:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NbwUIoRaY2tC0W/l1njIAtXEK218vgz3Rs6evw6dLiA=;
        b=bHG0pvMuNEFy7yczwroukyzBWycOTm24q0DeZ8m0YQrIH9CZ9G6RiA8VV5KSkTWBUC
         7KyoZ7z47MmkiwQMo3owcLueDg/mqk2YwelgLcfS6R7zvlBpXNpXHAZ98DkvMMnJYVVP
         iEP4ZZQiabQZKb82cR9zl53jwxfmtiaEuodAuH+E/7xXaC+TmeNE8ih+zhrti+Amypn0
         8BgF2uKsZNX9QJtBjxUN8Ruln0EAPyiuXbqhzTaWNpztW879Zqlh6HobGCkY6DH7dQhS
         qG34IFrrRR4TPmBCyOVCy/z+MphztEf4FWGrrohOZeMLe/uborlFJg00807QT4wG+PIx
         IgCQ==
Received: by 10.50.195.130 with SMTP id ie2mr10369145igc.40.1353423530134;
 Tue, 20 Nov 2012 06:58:50 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Tue, 20 Nov 2012 06:58:50 -0800 (PST)
In-Reply-To: <CAMP44s30wYnkQdq8yup3z-t=FEf1R+k8OC-o7-uY=19z9VHDPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210101>

On Sat, Nov 17, 2012 at 1:01 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
>> I gather that using a wrapper for zsh causes concerns about
>> backwards-compatibility.
>
> I don't see any concerns.
>
>> if [[ -n ${ZSH_VERSION-} ]]; then
>>   # replace below by zsh completion commands calling `bash
>> ${HOME}/.git-completion.bash`
>
>>   complete git   'p/*/`bash ${HOME}/.git-completion.bash ${COMMAND_LINE}`/'
>>   complete gitk 'p/*/`bash ${HOME}/.git-completion.bash ${COMMAND_LINE}`/'
>
> That doesn't work in zsh. It might be possible to do something
> similar, but it would probably require many more lines.

Hi,

since there doesn't seem to be an agreement that the approach to achieve tcsh
git-completion would be useful for zsh (the other possible shell that could use
it is ksh, but I haven't looked into that), maybe the simplest thing
is to keep the
tcsh solution contained in a tcsh-only script.  This is the latest solution as
proposed here:

[1] http://www.mail-archive.com/git@vger.kernel.org/msg12192.html

For reference, the more general solution was proposed here:
[2] http://www.mail-archive.com/git@vger.kernel.org/msg12122.html

If there is interest in merging [1], please let me know and I'll post another
version which adds a check to make sure that the user properly copied
git-completion.bash to be used by the new git-completion.tcsh.

Thanks for your input.

Marc
