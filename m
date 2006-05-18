From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Thu, 18 May 2006 13:11:52 +0100
Message-ID: <b0943d9e0605180511v5cf9256dx84825866b1691f51@mail.gmail.com>
References: <20060518064214.GA10390@backpacker.hemma.treskal.com>
	 <20060518065040.GA10497@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 14:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FghML-0004kc-1L
	for gcvg-git@gmane.org; Thu, 18 May 2006 14:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWERMLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 May 2006 08:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWERMLy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 08:11:54 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:64010 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750737AbWERMLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 08:11:53 -0400
Received: by wx-out-0102.google.com with SMTP id s6so332239wxc
        for <git@vger.kernel.org>; Thu, 18 May 2006 05:11:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sE43nlFNcNxbMut9K5oPu0+TOh4OiyvNqrn3wCrUA/S1NlTLz2aotq25DUTm67mETbgooG4d7UeMf/H58U0jy1WWoS8+ZhYxIHbd3NFrHo+cOImGmBLuhFmf+NC5gFdaQj+v3ovX7eyO4iF2N2kvkUvPUvcbJ9KtWuhypgt/lZM=
Received: by 10.70.76.17 with SMTP id y17mr561711wxa;
        Thu, 18 May 2006 05:11:52 -0700 (PDT)
Received: by 10.70.31.2 with HTTP; Thu, 18 May 2006 05:11:52 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20060518065040.GA10497@backpacker.hemma.treskal.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20282>

On 18/05/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Teach stgit to handle branch names with slashes in them; that is,
> branches living in a subdirectory of .git/refs/heads.
[...]
> Catalin, I hope you're paying attention when trying to pick the
> correct three patches out of the salvos I've sent you. :-)

Hopefully, I applied them correctly. I'll update the public repository
tonight and you can check whether they are OK or not.

> --- a/stgit/commands/common.py
> +++ b/stgit/commands/common.py
[...]
> +    if len(dirs) !=3D 0:
> +        # We have branch names with / in them.
> +        branch_chars =3D r'[^@]'
> +        patch_id_mark =3D r'//'
> +    else:
> +        # No / in branch names.
> +        branch_chars =3D r'[^@%/]'

I removed % from the above regexp.

Thanks for the patches. Great work.

--=20
Catalin
