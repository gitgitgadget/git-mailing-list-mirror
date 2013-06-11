From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: New feature discussion: git rebase --status
Date: Tue, 11 Jun 2013 10:18:28 -0700
Message-ID: <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
 <20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSDd-0002r5-H1
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab3FKRSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:18:49 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:40987 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3FKRSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:18:49 -0400
Received: by mail-vc0-f172.google.com with SMTP id ib11so5646540vcb.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wxOwntE6XzpO2mKg6bTB23jy3K8UApFyiFG3ZR67Pqc=;
        b=IVrBsYDnr1lI+m69C9l36tUPXKI9SybHg/N3DBX95uWkyC8TZpchDl6RaOcG13DFBe
         DlF5isVZgsIX+TVrZk7Tp3Nv5elxcLz8+ipTI72pZQ3GGOqUryjOLTL/R5OrFvB2QFvt
         2P3NnA2e8WJlJmzWLg1pcIAEE44Mv0VrBJEwKlfOX0uyGuwbKfum4fKydL4tRqRD6E7J
         P7CjI3JNtHAtSJb7ZY9Ycq2SGg99EFQyNAEJOfT4Ovo1Zcp6AVZkotLUc2ybyBhSFe5s
         5lEHIeEZSvR3czsLadgXMAjNpQ4CivJuKDfVHYXnd55E3gbhE3u/FMVnYuxcsnerXClI
         Vkfg==
X-Received: by 10.52.93.46 with SMTP id cr14mr7076439vdb.132.1370971128339;
 Tue, 11 Jun 2013 10:18:48 -0700 (PDT)
Received: by 10.58.229.106 with HTTP; Tue, 11 Jun 2013 10:18:28 -0700 (PDT)
In-Reply-To: <vpqbo7c4wen.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227469>

On 11 June 2013 06:19, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> The one piece of information that I often want is the SHA1 of the commit
>> that is currently being applied.  Currently I have to look through my
>> scrollback for the "stopping" message or poke around in .git/.
>>
>> Having that in the output of "git status" would be really nice,
>
> ... and should be rather easy as it is the content of
> .git/rebase-merge/stopped-sha
>
> Perhaps "git status" could say stg like "(applying 1d3fb08, 2/5)"
>
>> output format you've posted is a big improvement over what we have at
>> the moment for this case.
>
> My idea when I wrote the item on the wiki was to keep the a very short
> summary in "git status", and to put all the information one could whish
> in a separate command. I'd describe it as a complement more than an
> improvement ;-).

Having "git status" display (even more) "context sensitive"
information during "git rebase" or "git merge" would be very welcome.
Please, if at all possible, don't make that a separate command.
