From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Question about submodules and absolute paths
Date: Tue, 22 May 2012 22:18:16 +0300
Message-ID: <CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
	<CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
	<7vk4043wc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 21:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWubB-0006jA-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 21:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237Ab2EVTST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 15:18:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58282 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab2EVTSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 15:18:18 -0400
Received: by obbtb18 with SMTP id tb18so9978710obb.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=07LUgYaiRR9jlCpdnS2I1gJn+/UCgyN0tMK77MJFDl8=;
        b=L/9Hofcbw373KFG8dVKvkzlCD+hCwUjTnVROlZz2LQZcj/hSo+jCu4qvs4PEmi48mI
         KESgiqiipIYcvBkUECQXS9ePou868KvB1fMeDewk4GkFSV+fwY4k+L+UY9WLL5FCBPy5
         OYUv/PXbWMDiXDJT9y38N1lnwF7ZTYN7E51hoeCDyFfOCS/Y4UGd7YVfC6F9cz39d7LE
         eq8StGoXQ+/eWJgcVCYLJeZ/64zg8go80mSFjuiYDFkCd6Qi4g2xSiBc5DskjNV22HjN
         jvGqwb25/AmdVquGNv4Wdt6u8dNFezY4sf20jO3T34MLPiUh1veLAzOHk/V2H1GymfxV
         HH2A==
Received: by 10.182.212.4 with SMTP id ng4mr1195354obc.75.1337714296927; Tue,
 22 May 2012 12:18:16 -0700 (PDT)
Received: by 10.182.72.65 with HTTP; Tue, 22 May 2012 12:18:16 -0700 (PDT)
In-Reply-To: <7vk4043wc5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198228>

Not on two machines, on single machine but with two OSes
Windows + Linux + shared 'work' partition :) So both Windows and Linux
use same repo clone that is stored on a 'work' partition. But due to
those absolute paths, it gives '/cygdrive/d/work' on windows and
'/media/work' on linux. Thus I have to keep 2 copies of each
repository that uses submodules (and that is very inconvenient :( )

On Tue, May 22, 2012 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Alexey Pelykh <alexey.pelykh@gmail.com> writes:
>
>> since these paths differ from OS to OS and thus I have to keep two c=
lones of
>> each repository.
>
> I am not sure what "absolute path" has with this. =A0If you are worki=
ng on
> two machines, don't you need two clones, one for each, anyway?
