From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: Suggestion: git status --untracked
Date: Mon, 11 Feb 2008 11:54:27 +0100
Message-ID: <b77c1dce0802110254g724d4218l7219c9d9f9ec8027@mail.gmail.com>
References: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
	 <vpq63wvztqc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWJV-0007Cp-5T
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYBKKya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbYBKKya
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:54:30 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:28847 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbYBKKy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:54:29 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4728008wxd.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 02:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yoJeq8FCgPNqQq4KgkJhhsmN1NREASbs3gsovJ22E24=;
        b=Qo9lwO7LH4RGCYroCWLBGSOEqGBumePnt1SjxdBVY3qhUzG4nj2bTQROqON6ZYZaqj/X26fikIXKuTTquDq3d94k7Fz+pErCE02GHN4YTfBbAt1VWhR8YPIVSf3vOGEV1veZW8gHITFml7awygmbskuWAwDRVOX0TAnG28gF074=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HbT8E4ndJUJl5FJY38jNET2gVmVM9akaJHuZhFYerbwDz+7nZUm/rYCLhLWkV9V7S0cGLIwkaRkoOyddkwRpjUYtL+V6PQpQx5gc5erIxKqMw8WcyVvCDQvamCJULRi9y3vqmOJ8iNi8P4JtHxPLNMcQKgsvKd7+rj3sSAjHHvI=
Received: by 10.142.114.15 with SMTP id m15mr4476452wfc.235.1202727267536;
        Mon, 11 Feb 2008 02:54:27 -0800 (PST)
Received: by 10.142.156.10 with HTTP; Mon, 11 Feb 2008 02:54:27 -0800 (PST)
In-Reply-To: <vpq63wvztqc.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73512>

On 11/02/2008, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Actually, it's already available (since a few weeks in master IIRC,
> not sure whether it's in the latest release), as
>
>   git ls-files --exclude-standard -o
>
> The --exclude-standard tells git ls-files to read .gitignore and
> friends as most commands do, and -o means "show 'other' files".

Ah, many thanks. (Still not familiar with the plumbing.) I'm already
adding an alias for that command in my config!
