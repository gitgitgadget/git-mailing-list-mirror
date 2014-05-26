From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Can we stage all files using "git add" command, except some
 specific files ?
Date: Tue, 27 May 2014 05:24:56 +0700
Message-ID: <CACsJy8B7TeeT-xOoZyPc6_LLEL-ugdgzbKf3FYci28f9eGrpvA@mail.gmail.com>
References: <8392138.j8Dle5WGbS@linux-wzza.site> <1401135802.25483.1.camel@spirit>
 <11486854.4deTbW34tQ@linux-wzza.site> <CALZVapnUgEnw6rv630awF7AjnfhRzzK8H5wP6jTLN6XZGVJDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arup Rakshit <aruprakshit@rocketmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo Cansino <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 00:25:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3Kl-0006tb-J7
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbaEZWZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:25:28 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34708 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaEZWZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:25:27 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so12775827qga.34
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b6bu15MWkxMP1q09r5R900gXoWstS47OtUF8XmKwm90=;
        b=OFZEWfEOZOoAQXhwd8UdclxB87CyIwLgidvXgzVxuWNTohW/Hb7qoV4D1kfKEJ0U94
         W6wW4wnaWbefBeiBAZP0+X9aNEY+IqoNiyuNjbhAlGEjwnTccq2lyBKEPLYIqwDqiUaX
         Ev+0sTqBuCzoD90KHfPI/NtWeTan9hhRxFV6Z9VVEsG/TYh2X/IMnaMCwzlrqxE6ENe2
         +0W/J3xFAjvgcMM4zYViZLACLD+i5YPv6g5yeX07w8vBMNr017hHLcGkRgmi9Bs4I4xe
         162pyWByPeFD+E+l70LOJnnHhatiLFZJyB4KpuQ3pu7OsGpt+tFldrj+XYRhS2s3xHY/
         9pBQ==
X-Received: by 10.140.107.137 with SMTP id h9mr34375882qgf.30.1401143126594;
 Mon, 26 May 2014 15:25:26 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 26 May 2014 15:24:56 -0700 (PDT)
In-Reply-To: <CALZVapnUgEnw6rv630awF7AjnfhRzzK8H5wP6jTLN6XZGVJDEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250130>

On Tue, May 27, 2014 at 5:06 AM, Javier Domingo Cansino
<javierdo1@gmail.com> wrote:
> If you don't want an specific file, but you neither the .gitignore,
> just use .git/info/exclude file for project specific or
> $HOME/.config/git/ignore for user level.

This is actually better. 'git add' does not allow to specify exclude
patterns in command line (more convenient then editing .gitignore)
like ls-files. Perhaps we should add it for one-shot exclusion?

> Anyway, this is all in man gitignore
>
> [1] Git ignore man page: http://git-scm.com/docs/gitignore
> Javier Domingo Cansino
-- 
Duy
