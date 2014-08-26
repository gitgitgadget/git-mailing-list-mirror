From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: Re: [PATCH 0/2] describe: support the syntax "--abbrev=+"
Date: Tue, 26 Aug 2014 15:04:31 -0300
Message-ID: <CABXqP=hhc6zXm5x7CpAzP8n2exUPRNOAeg7ENVUL7T=gXGmVcg@mail.gmail.com>
References: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 20:04:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XML6j-0004U9-3N
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 20:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbaHZSEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 14:04:32 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36114 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbaHZSEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 14:04:32 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so11682711obc.36
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=LLdHG0q8DZL1xp5fNku4RLy9eBSl5+z8QqgKhYE2UlE=;
        b=M367Z/JFAfa/slpCP2sl9ZmgCYcODoWne0OhOh+knxEzNez0HkQA8uG5TNHWteSxMW
         mSy/RKqklrsuQ/RhoZp6/9AyMfy8Irk1uOewyZ9/+TMQMcByTbsljWDe53LZe/KnJ9sx
         DpE77yVSAvMcM5bxqznmcxgtpicJIoGmg5NBslRG/VdoDeIVlMpLa6MqpkNAGJMxTSTd
         61vcOelgcL7i0zLMVd7a5g6Q7+y50Fho/fOLoqh+Jtdk53ebi5H6HlOjxskGAAG0PkxD
         H19oxbfZX8GVfb/JH4SPNfzjlOB3iprRciQf3HI4vytnplx0JJ597oJQXH6SN2pEYSS6
         zI9A==
X-Received: by 10.60.45.234 with SMTP id q10mr29279710oem.25.1409076271602;
 Tue, 26 Aug 2014 11:04:31 -0700 (PDT)
Received: by 10.76.11.3 with HTTP; Tue, 26 Aug 2014 11:04:31 -0700 (PDT)
In-Reply-To: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255932>

hi there!
just a ping here, these are my first patches to git.
any comment, feedback?

2014-08-23 14:13 GMT-03:00 Jonh Wendell <jonh.wendell@gmail.com>:
> Sometimes it's interesting to have a simple output that answers the question:
> Are there commits after the latest tag?
>
> One possible solution is to just print a "+" (plus) signal after the tag. Example:
>
>> git describe --abbrev=1 5261ec5d5
> v2.1.0-rc1-2-g5261ec
>
>> git describe --abbrev=+ 5261ec5d5
> v2.1.0-rc1+
>
>
> Jonh Wendell (2):
>   describe: support the syntax "--abbrev=+"
>   describe: Add documentation for "--abbrev=+"
>
>  Documentation/git-describe.txt |  6 ++++++
>  builtin/describe.c             | 26 +++++++++++++++++++++-----
>  2 files changed, 27 insertions(+), 5 deletions(-)
>
> --
> 1.9.3
>



-- 
Jonh Wendell
http://www.bani.com.br
