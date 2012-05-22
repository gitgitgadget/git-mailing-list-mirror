From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Question about submodules and absolute paths
Date: Tue, 22 May 2012 23:25:43 +0300
Message-ID: <CAOmKuSoxf_mRJRyjXj99NQLoa+fD-HU_oUYPrJYPNTPmvhs46g@mail.gmail.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
	<CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
	<7vk4043wc5.fsf@alter.siamese.dyndns.org>
	<CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
	<70952A932255A2489522275A628B97C31348C70D@xmb-sjc-233.amer.cisco.com>
	<CAOmKuSqRHMS+hvCXL4Ok6ReTPW-3xT9SunGeibjCCCgVk9SU6Q@mail.gmail.com>
	<70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Tue May 22 22:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWveQ-00015P-7u
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575Ab2EVUZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:25:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34619 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab2EVUZo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 16:25:44 -0400
Received: by obbtb18 with SMTP id tb18so10050184obb.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Rc2lgfs3r8Y6jzcbG9iZINZrS9jouYw8Jv6P9Q24Bus=;
        b=JiPBqHlrvj0O13XaCBO2L2EJ71M8YK5ZlOHfMkE74zo291KLbxwsV+g6Sslzq7voVw
         /CDNY5azPhsQksc+yTMrI0l2twsMTBjMM7DABRGCc6XXvYZ5sT554aRPyP6qXFgDFhrk
         ieo+MNdN0xSyhDabsA8p8yVFAI94TmhGactQPXiuKmP8E/TQvCbB36LgmXvVXCsQt4MH
         98/j1L3aJNpNP9niO3W24/0n3105+zlWEPOEQateSU+OcB8OexIlJeyofUy7v9sZawpE
         Gbkz5qT6U+PPGGK5DbsTB5jjBgu88yAy2lZwYGdB7aZ+T7y+00eeU3sGowOpUyktXd6b
         L8Jw==
Received: by 10.182.45.72 with SMTP id k8mr1775915obm.51.1337718343899; Tue,
 22 May 2012 13:25:43 -0700 (PDT)
Received: by 10.182.72.65 with HTTP; Tue, 22 May 2012 13:25:43 -0700 (PDT)
In-Reply-To: <70952A932255A2489522275A628B97C31348C71F@xmb-sjc-233.amer.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198241>

Getting back to the topic, who has what opinions on it?

On Tue, May 22, 2012 at 10:36 PM, Matt Seitz (matseitz)
<matseitz@cisco.com> wrote:
>> From: Alexey Pelykh [mailto:alexey.pelykh@gmail.com]
>>
>> Indeed this is a workaround, what I was thinking about to use. The
> thing I
>> wanted actually to discuss whether it worth to research possibility =
of
>> replacing these absolute paths with relative ones.
>
> Sure. =A0I just wanted to offer an immediate, interim solution until =
there
> is a decision on the permanent solution.
>
