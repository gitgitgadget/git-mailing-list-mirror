From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] git-fetch: Allow branch."branchname".remote=.
Date: Fri, 13 Oct 2006 11:08:53 +0200
Message-ID: <8aa486160610130208s67ea0746o8a54910860b3fb78@mail.gmail.com>
References: <87y7rk3b9n.fsf@gmail.com>
	 <7vpscwd4ya.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 11:09:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYJ2I-0002p9-IY
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 11:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWJMJIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Oct 2006 05:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWJMJIz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 05:08:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:43001 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750847AbWJMJIy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 05:08:54 -0400
Received: by wx-out-0506.google.com with SMTP id s14so806891wxc
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 02:08:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rX/conwW4P7vAENifki+Hec8vOFDTi6a9cqshV4Osiw4UQ3qLvBTsFiK9NblYhTBK+1ZkYz+X1wiuPK8oCQP2ljWGxXPvz6UrgYs1dSOJtWKmPbgACN6IgF57nw+7aSLzGTb1DybqOBaQ8nergQQLJSJOHb+JRceMoxt8fSQNRI=
Received: by 10.70.96.3 with SMTP id t3mr4837056wxb;
        Fri, 13 Oct 2006 02:08:53 -0700 (PDT)
Received: by 10.70.46.8 with HTTP; Fri, 13 Oct 2006 02:08:53 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpscwd4ya.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28834>

2006/10/13, Junio C Hamano <junkio@cox.net>:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>
> What does it do?
>

It allows to define that the default remote repository is the local
one. For example, in git.git you could have:

[branch "next"]
   remote=3D"."
   merge=3Dmaster

so the default merge in the next branch is the master branch in the
local repository.

Santi
