From: "Fredrik Kuivinen" <frekui@gmail.com>
Subject: Re: [PATCH] git-reset --hard: use quotes when we tell the user what HEAD was reset to
Date: Sun, 7 Jan 2007 13:56:59 +0100
Message-ID: <4c8ef70701070456k2f0585f4ga6c35bd77c939c59@mail.gmail.com>
References: <20070106102322.7468.57615.stgit@c165>
	 <7v8xgg553u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 13:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3XaE-0001Rz-Ma
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 13:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbXAGM5D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 07:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbXAGM5B
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 07:57:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:42376 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528AbXAGM5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 07:57:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7693730wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 04:56:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fePfEw9fKJwkTZrCXxoEqdyulOPlD/yvAkwA/fhbe5UAiAzwf8JbWpXXYxnrbCcWkQ4ELnsTEn+nyKAP+qRizM3cqgZFtwSW1K/tJXVIaohPAs77N2HAuXLzWgxeTN3kLdAowqfwJff8pu3d+r85WFSi+D/mPCo9n0ENd3DxrMc=
Received: by 10.70.80.14 with SMTP id d14mr46641154wxb.1168174619895;
        Sun, 07 Jan 2007 04:56:59 -0800 (PST)
Received: by 10.70.50.13 with HTTP; Sun, 7 Jan 2007 04:56:59 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xgg553u.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36168>

On 1/6/07, Junio C Hamano <junkio@cox.net> wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
>
> > Idea and motivating example from Andy Whitcroft:
> >
> >     apw@pinky$ git checkout -b bar master
> >     apw@pinky$ git reset --hard ac9c1108d8915f0937795e354ad72c4ae6890a3f
> >     HEAD is now at ac9c110... git-fetch: remove .keep file at the end.
> >
> >     Huh, fetch?  Remove what .keep file?  Did I do a fetch?  What?
> >
> >     I think we need to delimit the name better, probabally we need to quote
> >     it.  Perhaps something like:
> >
> >     HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".
>
> I've also considered something along that line, but:
>
>  (1) I think this 'confusion' is only because you are futzing
>      with a project that deals with git-fetch and friends and
>      not a general problem.
>
>  (2) With "HEAD is now at xxxxx..."  prefix, even two characters
>      are precious to fit the title of the commit on a single
>      line.
>
> With these in mind, do you still want to do this?

I don't think the second point is much of an issue. Is it really that
irritating to
read a word-wrapped line of text? I agree with the first point though, in most
cases it will not be a problem in other projects.

I still think it is worth doing it, but it certainly isn't super
important. Feel free
to drop the patch if you want to.

- Fredrik
