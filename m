From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] config.txt: update branch.<name>.merge documentation
Date: Sun, 4 Feb 2007 01:30:02 +0100
Message-ID: <8aa486160702031630l4fd3e29did4f249713cf2ce81@mail.gmail.com>
References: <87irejgsyj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 01:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVGj-0005b0-Ce
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 01:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXBDAaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 19:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbXBDAaG
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 19:30:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:39670 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXBDAaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 19:30:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1051499uga
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 16:30:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=beHTdwyzB99eKZkGOfn6nDbILg43gkwRdmKReyA13Ih/drSsDhbLKbqH7ghuHHf2dHsGrLxetRpGFMIvEpK6aI85ail9rnNv/pbgHdYyAaGV2Dd11kyGnAi+0S/X4yj2SAtAxR1VKJwQyw158QcloZ+l60j2KIk2mtpWPmSYC+E=
Received: by 10.78.165.16 with SMTP id n16mr950663hue.1170549002904;
        Sat, 03 Feb 2007 16:30:02 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Sat, 3 Feb 2007 16:30:02 -0800 (PST)
In-Reply-To: <87irejgsyj.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38623>

On 2/3/07, Santi B=E9jar <sbejar@gmail.com> wrote:
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -233,11 +233,12 @@ branch.<name>.remote::
>  branch.<name>.merge::
>         When in branch <name>, it tells `git fetch` the default refsp=
ec to
>         be marked for merging in FETCH_HEAD. The value has exactly to=
 match
> -       a remote part of one of the refspecs which are fetched from t=
he remote
> -       given by "branch.<name>.remote".
> +       the remote or local part of one of the refspecs which are fet=
ched
> +       from the remote given by "branch.<name>.remote".

It is OK, but

>         The merge information is used by `git pull` (which at first c=
alls
>         `git fetch`) to lookup the default branch for merging. Withou=
t
> -       this option, `git pull` defaults to merge the first refspec f=
etched.
> +       this option and when fetching a non default remote, `git pull=
`
> +       defaults to merge the first refspec fetched.
>         Specify multiple values to get an octopus merge.

=2E.. but this is not. I interpreted it wrongly, sorry.

Santi
