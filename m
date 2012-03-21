From: elton sky <eltonsky9404@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Wed, 21 Mar 2012 23:01:58 +1100
Message-ID: <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	<87aa3aw5z8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 21 13:02:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAKEv-0002Cj-M8
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 13:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab2CUMB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 08:01:59 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34249 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab2CUMB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 08:01:58 -0400
Received: by vcqp1 with SMTP id p1so926627vcq.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SSuDbGZbnPpY+ZDIji4iQpAeJufAidoIKq7HxoiNM2k=;
        b=oEMPj2y4EpIJvyJ1aZZckTkt+QcBIcziyX5vXXJxc+Q/FTM1giZn5XQNcYgBaf2VSk
         +9hpjKxd8RnipzIs4OnzFWhPezk7Kq/2YQGTmZpln9gLY8ucb2WiYZ+zJxBqXIUUOB91
         /xBPi7KrSvh0SH2N8FEmxwBeopxXL2E1v0hgpbIYMmTV7BEylE/Zi8ZjioXHLNLpmI0K
         oLoboFrWkX9FmfPVmYAEXECWjYV8EbCF79I8fna/yuXIahuP3prUapxfLoMapf5yyf3/
         3DqET4wZBxOjjCXrUeOdMJYHEq8egz8hWuSDUgunHcCvKPABoP5Hy3p6at4g7wusNHMf
         +mlQ==
Received: by 10.52.29.244 with SMTP id n20mr1471326vdh.22.1332331318142; Wed,
 21 Mar 2012 05:01:58 -0700 (PDT)
Received: by 10.52.182.233 with HTTP; Wed, 21 Mar 2012 05:01:58 -0700 (PDT)
In-Reply-To: <87aa3aw5z8.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193572>

Hi Nguyen, Thomas

Thanks for the points &clues. Processing them...

-Elton

On Wed, Mar 21, 2012 at 10:25 PM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> elton sky <eltonsky9404@gmail.com> writes:
>
>> I got questions like: how each operations affect index? how cache tr=
ee
>> data and index is stored?
>> Maybe you can point me how I should catch up quickly. I went through
>> the article "git-for-computer-scientists", that quite makes sense.
>
> In addition to what Nguyen Thai Ngoc Duy said, check out the
> (sub)threads
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/190016/focu=
s=3D190132
> =A0[origins of the GSoC project idea]
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/192014/focu=
s=3D192025
> =A0[perspectives of core developers in reply to the idea]
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/186244/focu=
s=3D186282
> =A0http://thread.gmane.org/gmane.comp.version-control.git/186357
> =A0[the last few discussions about cache-tree]
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
