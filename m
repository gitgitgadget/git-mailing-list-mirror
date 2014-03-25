From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 084/144] t6111-rev-list-treesame.sh: use the $( ... )
 construct for command substitution
Date: Tue, 25 Mar 2014 10:52:31 +0100
Message-ID: <CA+EOSBka3T-UvoY0ntOeEZbMM0Djnv0hOV4gRNTBAPf38qM4=Q@mail.gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
	<1395735989-3396-85-git-send-email-gitter.spiros@gmail.com>
	<vpqob0u3bj6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSO2D-0005FM-7s
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 10:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbaCYJwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 05:52:37 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:33376 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaCYJwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 05:52:36 -0400
Received: by mail-ve0-f176.google.com with SMTP id cz12so225632veb.7
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uqXjPL2oujG9bvQaQlbIM8w0w7lPu2vGQfBafE+D/c4=;
        b=aBdnlW/Ns5xFmlEc3cP//oVUAcN9GJMse1Q0KJVoUMXAdcRvkabZBxyR49kHTao6r/
         zC/4zXVpWcpod5A7CaeMYg+jxja94TTNR5IINvrzoZNxbeK0tWwOpa0QhNd5d8o0DNK9
         12Lp27gT/juxXplr9F90qNHr6jkZc6oQeDIi5Gb8P4mDP0Q/hv/Ms0SFrbWsv4eODEvS
         A2YtWLH6jWiX2ysZmd/y8JCA5FT0uOyi2u4OnxkKZ/aBtAulUMWhwn9C49TjQ+nnZX8X
         iAllX9lz37RinC8BFmdpXRqGlZxuLiSlx6Sakc+GJpKGdVVgXWsx9EMiSan/MN/KVBgT
         zMjQ==
X-Received: by 10.220.191.134 with SMTP id dm6mr55402355vcb.16.1395741151868;
 Tue, 25 Mar 2014 02:52:31 -0700 (PDT)
Received: by 10.52.15.33 with HTTP; Tue, 25 Mar 2014 02:52:31 -0700 (PDT)
In-Reply-To: <vpqob0u3bj6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245024>

2014-03-25 9:52 GMT+01:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> --- a/t/t6111-rev-list-treesame.sh
>> +++ b/t/t6111-rev-list-treesame.sh
>> @@ -4,7 +4,7 @@
>>  #       /        \ /             \*
>>  # *A--*B---D--*F-*G---------K-*L-*M
>>  #   \     /*       \       /
>> -#    `-C-'          `-*I-*J
>> +#    $(-C-'          )-*I-*J
>
> The original version was more readable ;-).

:=)

I am sorry. The change was made by an automated script, can happen
that i missed something.

Please skip this patch.

Thank you very much for the review.


Elia
>
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
