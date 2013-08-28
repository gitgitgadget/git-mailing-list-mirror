From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 16:21:41 -0500
Message-ID: <CAMP44s2HydaSUe-VH9yf_6fo0jYqntKGnvQ2DxgYoNpw92SkMw@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnBd-0005f7-K9
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab3H1VVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 17:21:46 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:50031 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab3H1VVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 17:21:43 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so5250726lab.41
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Bdgz7op/4rDub9eEdKZQdmdAR+sCl00Grmj7RiTveq8=;
        b=liPjhrPO598XKkafjUx8I40tNaFMRHfjDUUBt/hPMTiZWHPo0gy384CggWbeAXY+M1
         yg+rMNi6yZy/27MrsppUak5jTdgU01NjXUFGpWnh+XlX6sBsmGkatg1NvtFyglQZPWPj
         IzswrxC2/h0OR+qekKJ0qu9jX3mIe9ylG22AZHAcGO/HEhTbmMUBFx8ELIuhiYkUjtvt
         fHrcRvmb1V1BO/aJD3UFe+PJeI1vHEZj+TKlhovB+oKFcwG3bvkxcT+/MhRlLYTogWv4
         vfTlwJ1yETWCaHuTkbURLDmqJ4I1YoKt+ICrF3/dHZO5h8VgTHrN3K05lVsw3HWBa0ct
         n2cA==
X-Received: by 10.152.8.199 with SMTP id t7mr2796laa.63.1377724901857; Wed, 28
 Aug 2013 14:21:41 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 28 Aug 2013 14:21:41 -0700 (PDT)
In-Reply-To: <vpqy57l4jcx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233218>

On Wed, Aug 28, 2013 at 4:05 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>>> +     bzr log | grep "^committer: " > ../actual
>>>> +     ) &&
>>>> +
>>>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > ex=
pected &&
>>>
>>> Git's source code usually says >../actual and >expected, without sp=
ace
>>> after '>'.
>>
>> Not that usually:
>>
>> % git grep ' > ' t/*.sh | wc -l
>> 1943
>
> Do I really need to quote the paragraph in CodingGuidelines?

Do I need to explain what a guideline is?

--=20
=46elipe Contreras
