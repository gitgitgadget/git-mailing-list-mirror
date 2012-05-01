From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 14:09:36 -0700
Message-ID: <CAE1pOi00Mr4dOj2ChTJU9XWypUAaVUDDa36-M7LA+9BixW0nKw@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<86r4v3mxf7.fsf@red.stonehenge.com>
	<7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:09:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKKL-0000FY-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab2EAVJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 17:09:37 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34448 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab2EAVJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 17:09:36 -0400
Received: by qadb17 with SMTP id b17so1057192qad.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RTiKOuD5AYL9sHl46HRnBlqLGsJQMGfW5+WzEw4mQDQ=;
        b=UPBnxPRKsYm+hIfahKS57qHGG/ti80e/RCLzT/RU2j/r0u7sQ+PjeZL8FdYVOgei+1
         NUDJ0XPEjm5EVXFV8SWeDyD2Mj19Sqw6iBPOuCRqvpUQpqnWTQdWVgTD4nCIspVgeVdg
         svRCx/w9mj+6n/WY9M+BFI+6qCHQjMfsx1CUzM63bXAHa5YvDdrgwPWYtqomETXAbxju
         mACy9U+gH45qwWLMViMkT34+eTuotcMVQrBZO/AbK7Gsq7tQ3vpDGylQAnHEe8P0VnAE
         zInk8gxKjKvUIqDUB568gUMpV7CE8eG/dEJL1yN67sCxJ/JmEXOXzO7U82ahqJEVwjA1
         2LIw==
Received: by 10.224.184.70 with SMTP id cj6mr10640075qab.77.1335906576289;
 Tue, 01 May 2012 14:09:36 -0700 (PDT)
Received: by 10.229.228.20 with HTTP; Tue, 1 May 2012 14:09:36 -0700 (PDT)
In-Reply-To: <7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196752>

On 1 May 2012 14:03, Junio C Hamano <gitster@pobox.com> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>>>>>>> "Junio" =3D=3D Junio C Hamano <gitster@pobox.com> writes:
>>
>> Junio> By design. =C2=A0Do you want me to include "rm -fr ~hilco" in=
 some hook of
>> Junio> git.git repository?
>>
>> This just came up yesterday at $PRIMARY_CLIENT. =C2=A0One idea we ki=
cked
>> around was having a convention for storing the hooks-to-be-populated=
 in
>> ".githooks" in the repository tree, and then having clone notice tha=
t
>> and offer to install them directly if from a trusted source, or at l=
east
>> move them into a disabled state in .git/hooks otherwise.
>
> We've talked about something like that a few times in the past, but a=
s far
> as I (am concerned / remember) the conclusion has always been that is=
 not
> worth "standardizing", i.e. nothing a ./setup script in-tree or a Mak=
efile
> target cannot offer the same convenience.

This would not keep things up-to-date, though, would it? It seems like
yet another thing developers need to remember and do. I would prefer
something more automatic.
