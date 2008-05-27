From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: setup_git_directory_gently contract question?
Date: Tue, 27 May 2008 17:35:49 +0300
Message-ID: <8e04b5820805270735m24ae4966x932ae610606d6e64@mail.gmail.com>
References: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 16:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K10ID-00084U-NK
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbYE0Ofu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755934AbYE0Ofu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:35:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:41630 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbYE0Oft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:35:49 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2968519rvb.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tk5TyzbN7z8angRkHGdwTju46q0Lh5yX2xKDffb0CmA=;
        b=kz7GU6R48da3XjlT1oE0wJ12+l3AYOpnUyxqdq7JjwRd6LjT4eLmCmElJSJmrvz+D8AhuSO4ywBsOaGkd7k+MFWZnXfTrNp+nyCG1pYkccZjWnkmvoATgOUskVE1eGScSAMPp0HJ2WtwjeyQq3oSp8EpVoZ+K4a0b98Iwg3pirA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PSxh4izik+Y4JxaRupuV4SSECzs/SsuICTdLidpRrm1TKHh/Io+XPhV8k5LaPPmLaZFXDWxlyZnRy+R5Tqb48uAI/AkNqY5cLvrlBX/UC2q8E/+EEPflQgvA5uddIv0Dy5fwf7Xs8kpmd7SPBxwsIosZAoC/z3HmE6UjcgbOPFI=
Received: by 10.140.132.8 with SMTP id f8mr577467rvd.122.1211898949225;
        Tue, 27 May 2008 07:35:49 -0700 (PDT)
Received: by 10.141.37.3 with HTTP; Tue, 27 May 2008 07:35:49 -0700 (PDT)
In-Reply-To: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83021>

    Or another question: how can I obtain the git directory (.git)
(absolute) path without updating the current working directory?

    Thanks,
    Ciprian Craciun.


On Tue, May 27, 2008 at 5:10 PM, Ciprian Dorin Craciun
<ciprian.craciun@gmail.com> wrote:
>    Is the function setup_git_directory_gently supposed to change the
> current working directory, or should it keep the initial one?
>    What is the meaning of nongit_ok?
>
>    Because if I use nongit_ok != NULL, but *nongit_ok == 1, this
> function changes the current working directory to the top of the
> worktree directory.
>
>    Thanks,
>    Ciprian Craciun.
