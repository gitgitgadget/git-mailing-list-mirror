From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Regarding GIT API
Date: Tue, 15 Feb 2011 12:21:04 +0100
Message-ID: <AANLkTi=eSsxTj4V25a9Lk75NfDZ5S5Ag8A-_mLUQ8dEF@mail.gmail.com>
References: <loom.20110215T120434-373@post.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Abhinav Goyal <honeykool23@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 12:21:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpIyS-0004ps-L4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 12:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab1BOLV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 06:21:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60398 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab1BOLV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 06:21:26 -0500
Received: by fxm20 with SMTP id 20so55779fxm.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=hRKt/qzLj5zhg2wYTd3ChR7RAcJjH/x4hhO9e97WJog=;
        b=D0jDnulHyGnE/U9VdUCkMInKBRlqRhAu2fkVbIl2P6ZQfHbvn59mOn+cgVaE6J/D/I
         ok7r5F0Gv59r41sSJgqCAPowqRnHAAju79ri4IVRONGwuOWlj9MnrwbQlctBBmDVJMtL
         xip53rB1kpru/ea6YsVeS81jGQIu6JZ7KYL40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=egqIeagxXuHYy2L5a1fZpEaD7VdoPuQnY6hSWhAozmnpaMB21+CAKwp+ZgISi538OB
         ufvS9cgkoWX2kcrm2rOkVlMV6avhb+A/b83o9RdOdof1vGZrgvM0dsF5xcVNQSjXn787
         b179UCxAfuKP4QV3bX8cScPpt4cD8v/K6biFU=
Received: by 10.223.71.200 with SMTP id i8mr4961363faj.142.1297768885215; Tue,
 15 Feb 2011 03:21:25 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Tue, 15 Feb 2011 03:21:04 -0800 (PST)
In-Reply-To: <loom.20110215T120434-373@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166837>

On Tue, Feb 15, 2011 at 12:08 PM, Abhinav Goyal <honeykool23@gmail.com> wrote:
> hello All,
>
> I searched a lot but all in vain to find GIT API from which I can call
> git commands from my C++ Application. I tried my hands on libgit2 but found that
> it deals with very low level git functionality .I just need the git command
> support for my C++ application. I have my own reason for not using command
> prompt system call. Please help me if you have any idea regarding API that I can
> use.
>

Git's API is constructed through calling the plumbing commands, not by
calling C/C++ functions. If you want an example of how to do that, you
could look at the git-cheetah source code:
http://repo.or.cz/w/git-cheetah.git

LibGit2 is the most complete alternative for C/C++ to my knowledge.
