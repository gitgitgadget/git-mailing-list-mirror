From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Installing GIT Server
Date: Fri, 10 Aug 2012 13:57:25 -0400
Message-ID: <CAM9Z-nkPU6YP6_hvwLNmnjDymWXVgyeVD+TBW3sLK8-+V26msg@mail.gmail.com>
References: <41E7B95B-70F0-4DCD-ADCE-213BCE4B2FAC@YAHOO.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Andrew Keller <andrew@kellerfarm.com>
To: Neeraj Mathawan <NEERAJM@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SztSm-0005XK-Ly
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 19:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203Ab2HJR51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 13:57:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63132 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616Ab2HJR50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 13:57:26 -0400
Received: by bkwj10 with SMTP id j10so696206bkw.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L57Fxkr1GywXzUg5fjJzpgIi+dc+q6p0QgePcgZamE4=;
        b=HtylFxP0O+6ERzpo4ruprcNssQLmJMxshxw2UxernOVbOeqxrG7IwX2pzQwqcgV4u7
         U/5paeSIEP97vIXqoJgJliMnkNuFtV1cyDJa9W6UE80SPC5PigzEK+AMrXU9Tb7Sfs87
         xGcQpWAwzju8PregYlOW1d4AdTll16HhXGLn+O1Ob0jSbM3WMwl1pz6X1ftEq0Dl91io
         wIBUfMRIfj3D7J2amHvULxt9803saXEN5eRUXl3B8MWAyBYzccuOYuCCSlonKvmFcI8w
         Z3r2poAUSaNbp1VojC5JTqppU9ivrh/+ngPe6rUHp32FY6MBquFSFN0ZZxyUm3RURog8
         derQ==
Received: by 10.205.129.10 with SMTP id hg10mr1533153bkc.78.1344621445235;
 Fri, 10 Aug 2012 10:57:25 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Fri, 10 Aug 2012 10:57:25 -0700 (PDT)
In-Reply-To: <41E7B95B-70F0-4DCD-ADCE-213BCE4B2FAC@YAHOO.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203240>

On Fri, Aug 10, 2012 at 11:17 AM, Neeraj Mathawan <NEERAJM@yahoo.com> wrote:
> Hi,
> We have decided to use GIT for a huge government implementation, I am looking for some help with installation of GIT SERVER.
>
> Few questions:-
>
> 1. What platform to choose - UNIX, MAC or Windows? We have lot of windows 2008 installations, and if there are no trade off's we would love to use Windows 2008 server and install the GIT server compoent there.
>
> 2. Once that is done, the client machine mostly MAC OSX development machines...will they be able to connect using SSH or file share?
>
> Can someone help me with this?

Raj,
You may find that using Gitolite [1] (and following the documentation
that comes with it) to be a good solution to what you are trying to
do.

(1): https://github.com/sitaramc/gitolite/

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
