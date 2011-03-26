From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Listing top tracked files and directories only
Date: Sat, 26 Mar 2011 17:28:16 +0100
Message-ID: <AANLkTikbJt6-wz4dw-o4oLKc=0u_8EUFaAoYxokd3GPN@mail.gmail.com>
References: <AANLkTi=OMXTJm=mvr70KudS+S9c857z7Kv1qVE1FFdD_@mail.gmail.com>
	<AANLkTi=0oWTtUbLFjQsh5-Koghz3UwmaPcrFiR2W-hdS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 17:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3WLe-00022T-9d
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 17:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab1CZQ2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 12:28:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56790 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1CZQ2R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2011 12:28:17 -0400
Received: by pzk9 with SMTP id 9so297463pzk.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=inAosL8el1P6yOs36DGGNypBUoYONsQKWn2LXglzwHY=;
        b=FYlZ92NlzLiQCK1B0lX7014IikqHveuXMjNr3EKX0EmZlV1nXVLyJ1kImxNkFmvHtM
         U9CtOj+2yA8C6AP5pKkLQYfiCUOHFK6h+/sSVPuCS5gW3TvZXbfg/cXaFVnkaYZTiOrC
         fZPXAYrXreNBvhDfDAqOwWFNRAUTNOePpSY8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xf0LbVH8jzIqtbE35DwGB6sT1pO3cqFjZjDnBtxWeljKbgWb5mId3Ce6/tLjcJui9l
         +3AAmf4ZjVmFuK1YNsYCnUe9piAifVErFwcNC1aK5ERM/5FsRz2pbRFNoyso4nUV+Y9L
         1fXJbZFdKsUpZGjwybSJ2iV0NE8zIKUFSPzxQ=
Received: by 10.142.50.19 with SMTP id x19mr1812140wfx.204.1301156896839; Sat,
 26 Mar 2011 09:28:16 -0700 (PDT)
Received: by 10.143.177.4 with HTTP; Sat, 26 Mar 2011 09:28:16 -0700 (PDT)
In-Reply-To: <AANLkTi=0oWTtUbLFjQsh5-Koghz3UwmaPcrFiR2W-hdS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170058>

On Sat, Mar 26, 2011 at 5:24 PM, Scott Chacon <schacon@gmail.com> wrote=
:
> Hey,
>
> On Sat, Mar 26, 2011 at 9:18 AM, Francis Moreau <francis.moro@gmail.c=
om> wrote:
>> Hello,
>>
>> I'd like to find a way to list files and directories tracked by git
>> but which are only in the top directory of the tracked project.
>>
>> For example, in a kernel repository:
>>
>> =A0$ git-magic-command --magic-options
>> =A0.gitignore
>> =A0.mailmap
>> =A0 COPYING
>
> $ git ls-tree --name-only [branch]

cool thanks a lot !
--=20
=46rancis
