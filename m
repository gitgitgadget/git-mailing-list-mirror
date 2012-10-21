From: Cheeray Huang <cheeray.huang@gmail.com>
Subject: Re: Report a bug, about track remote repository.
Date: Sun, 21 Oct 2012 10:44:05 +0800
Message-ID: <50836175.5020501@gmail.com>
References: <5082F255.9060600@gmail.com> <F15116C3B49A439AB06C8068F79E4C0F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 04:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPlWb-00056z-C4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 04:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2JUCoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2012 22:44:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62563 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab2JUCoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 22:44:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1255872pbb.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DnKmWlNQEC7s/lPad96v3PBt3jkwSCoCWrqWFNFyMto=;
        b=Cz73A3XdVHAlkJ4ogo7ND875vlB1YK32eNkPZbaAIHJWIEuiXNt8QYJaxKFvUYE+lm
         8HJOOvuICMStZTsZ23I65fP3BmFzg7T4yooNDBfZy1DMtlqIGIEsvhH89ILHfiFMvsJU
         wIfH3puaF6coEf2HqCLqRya7gTO9qkL8iWM3t/b5suH+p92l3Ygj7IM4krLCbri00JXE
         j0ADmTrvn67WyBaOXg7ED3e/ZOpby06HbP9Q132a59E768F7UZU/gxClkP10eSxcwJWJ
         h5Yyq0ON31yYoVNvaWXEwW9hMRptSuN1weJ7Bw3laf8DaR3pnUTOMhbJT4/+mTibMZf9
         f8uA==
Received: by 10.68.230.66 with SMTP id sw2mr19168144pbc.119.1350787453159;
        Sat, 20 Oct 2012 19:44:13 -0700 (PDT)
Received: from [192.168.1.101] ([115.195.140.152])
        by mx.google.com with ESMTPS id po4sm3647736pbb.13.2012.10.20.19.44.09
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 19:44:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <F15116C3B49A439AB06C8068F79E4C0F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208100>

On 2012=E5=B9=B410=E6=9C=8821=E6=97=A5 07:46, Philip Oakley wrote:
>
> At this point you have created the 'conflict' - You can't have two=20
> different branches that both track the same identical remote branch=20
> and expect that they can be both different and identical at the same=20
> time.

> Only one push (from two branches trying) can suceed. You either force=
=20
> the remote to match the current branch, and loose any information tha=
t=20
> it had about the other branch, or the remote stays with one branch.=20
> Simply don't do it [that way]. If the local branches are different,=20
> then you need distinct remote branches.

Yes, if it will lead a conflict, I think git should give a warning for=20
it and prevent these operations rather than give a comment to inform yo=
u=20
to push something.



--=20
Best Regards!

Qiyu Huang( Cheeray )
