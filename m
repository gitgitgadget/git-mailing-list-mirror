From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 09:34:43 -0600
Message-ID: <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com> <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com> 
	<o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Wilbert van Dolleweerd <wilbert@arentheym.com>
X-From: git-owner@vger.kernel.org Thu May 06 17:35:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA36d-0004iF-QM
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 17:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758894Ab0EFPfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 11:35:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59988 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab0EFPfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 11:35:06 -0400
Received: by gyg13 with SMTP id 13so58839gyg.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ILksvMaJbOYbajZFxfAflycpY61TJ28WiFmKIqeqY54=;
        b=JvKaI4GYew6XiH6tEHd937bm1thabvqchp157fNuE3bMGbbQLx3dSbdEagUpQBrvYj
         rzu8S6QLa8p/FVOZ7td2Debzdb5SRfwcE8uVAUa59cEw2sAp0QxvI/+SdVsGu66nlAaH
         OBouF00cP0UL+GUEBd9W6k7LGKWKWQpjmGRS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QfjKZggsyB6xntOb86OIcc6Z/LaZeiVMoM50lvvwSKz1Y98tFBx+qG5D1fwQfGshq0
         N9Ib/u0zSYrD/p+QOE9D2FQhzMyx09YQ5jkV4pUqIRshMhZj8LxUHqVCqm4A6arjrxv2
         SVzwWVm6PAgCr3wmdPKE3q0zHl1a9oeHskGx4=
Received: by 10.90.77.17 with SMTP id z17mr84127aga.7.1273160103257; Thu, 06 
	May 2010 08:35:03 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Thu, 6 May 2010 08:34:43 -0700 (PDT)
In-Reply-To: <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146482>

On 6 May 2010 01:29, Wilbert van Dolleweerd <wilbert@arentheym.com> wrote:
>> I personally find that autocrlf causes more confusion than it solves problems.
>>
>> I've yet to see a text editor on windows that can't handle \n line
>> endings. (Notepad doesn't count)
>>
>> Just keep the project with \n line endings, disable autocrlf, and make
>> sure that people are aware of this.
>
> Editors may handle it gracefully but older Windows programs will have problems.
>
> For instance, Visual Studio 6 will barf on Visual Basic projectfiles
> with non-windows line-style endings. (And please don't ask why I know
> this....)
>

Well, this is the exception that proves the rule then :)

Anyway, If it's a VB project, might as well just keep the files with
CRLF endings then.

I don't know all linux editors, but I've yet to see one that can't
handle CRLF endings.
