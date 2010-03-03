From: John Tapsell <johnflux@gmail.com>
Subject: Re: How to move a big branches to a new base?
Date: Wed, 3 Mar 2010 03:54:23 +0000
Message-ID: <43d8ce651003021954o1411efd2i1a1f26e9b8ed5d54@mail.gmail.com>
References: <10d816431002251918vf13a5e8uf0396aa861081bcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 04:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmffK-0001EC-4N
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 04:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab0CCDy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 22:54:26 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36753 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab0CCDyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 22:54:24 -0500
Received: by pwj8 with SMTP id 8so619300pwj.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=dKE2zHJJBcJp1z/tnq1hKkgERKLN4w9sNM+PJzZV8F4=;
        b=HOO9hTnCBDI+0Os38Pu9JhKNprkvtR3MelMrbYPX42VEyENP/j8poDDA4OsaOUPi7D
         gabkPRFiuLJ/pZq0KYmT5rFB252vacFERivd3KfZ/Tfrr44xl3kUPCvU3EcZ/vRoDoUt
         8Ds3a4Tdje8Zs7HdezZAB22r5WPIeUzcaC+Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=WkMnDzObT/9+P5soH7C7PBqeChY9r28dZHynUCJeUzZkQ2/3jcASU4mGfxEujxh05F
         +/g+YxUB1olc/C0krOL8pT45H9SLKR6JZIaagoDvG+0JeH+vU6c8cEcpae2XS+g+nYI6
         z44bnrbXrswzjHJhWldfhHoY1Owy9Z7cg3YSg=
Received: by 10.114.215.8 with SMTP id n8mr3937001wag.212.1267588463958; Tue, 
	02 Mar 2010 19:54:23 -0800 (PST)
In-Reply-To: <10d816431002251918vf13a5e8uf0396aa861081bcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141434>

On 26 February 2010 03:18, Lin Mac <mkl0301@gmail.com> wrote:
> Hi,
>
> I have a branch that have about 10 descendent branches. Now I would
> like to move this branch, and all the descendent branches, to a new
> base, and I might need to do so quiet frequently before I merge it to
> master branch.

I tend to keep my branches as small as possible - a few commits at
most.  And avoid merges like the plague.  This seems to work pretty
well.
Remember you can squash your commits together to keep the branches
clean and well-ordered.

John
