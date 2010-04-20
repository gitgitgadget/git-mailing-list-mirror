From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git commit --amend --author troubles.
Date: Tue, 20 Apr 2010 21:29:19 +0200
Message-ID: <m2pfabb9a1e1004201229zd3b75801j5889783724669225@mail.gmail.com>
References: <j2n3abd05a91004201218k73256ecaj8921f3bd7e9cc20d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 21:29:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4J8l-0005j8-ON
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 21:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab0DTT3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 15:29:42 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:55247 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab0DTT3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 15:29:41 -0400
Received: by ewy20 with SMTP id 20so2180517ewy.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=4qvecgNn4UCG1Za5onfr4LJdArCFcLE6uz1hE/GjqiU=;
        b=b2YGrl6YBNeLGaVlahlqwJvtrZmb4RGk9eOeV3dPbmHuVHqrBMXJiF4/YwRkOu4+Ut
         NJ5rZnPet1C/iY3RhwqN3byrpmSiaHxbWHHDZm/dcEtwBGh9EoRXIC9BBkedIu7fzqHT
         JyCIIUdxC8qbQjB9OH0kzCdx90XyFFKgif8YU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vF1HRyb0dzqoX84EYJIQY0YsBaJkwYsJu0BrnJN0MYewVrOV6u7mw4Zz/O8JJPAr+D
         D7pQ4v2b3QIQDoVHFy6/Pph4w075wWRnD1ExUAgtqpPPYuAnRUl+Wfqc4n4ij8h552p5
         6QsAQCTSerQ6PDpqAMv4lkD3nhRM9Ws2r8pHU=
Received: by 10.103.168.14 with HTTP; Tue, 20 Apr 2010 12:29:19 -0700 (PDT)
In-Reply-To: <j2n3abd05a91004201218k73256ecaj8921f3bd7e9cc20d@mail.gmail.com>
Received: by 10.102.170.9 with SMTP id s9mr668825mue.77.1271791779125; Tue, 20 
	Apr 2010 12:29:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145394>

Heya,

On Tue, Apr 20, 2010 at 21:18, Aghiles <aghilesk@gmail.com> wrote:
> Just did a 'git init .' and then committed some files. git rightfully
> told me to check my user name and suggested the '--amend'
> and '--author' flags to change the author of my first commit.
> I tried it immediately but 'git log' shows the initial user as if
> nothing has changed. The amended commit message also
> shows the original name (in the comment).

Weird, works for me (on git 1.7.1):

sverre@laptop-sverre:~/code$ git init firsttest
Initialized empty Git repository in /home/sverre/code/firsttest/.git/
sverre@laptop-sverre:~/code$ cd firsttest/
sverre@laptop-sverre:~/code/firsttest$ echo "hi" > foo
sverre@laptop-sverre:~/code/firsttest$ git add foo
sverre@laptop-sverre:~/code/firsttest$ git commit -m "Initial commit"
[master (root-commit) 6284b75] woot
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
sverre@laptop-sverre:~/code/firsttest$ git commit --amend --author="Piet"
fatal: No existing author found with 'Piet'
sverre@laptop-sverre:~/code/firsttest$ git commit --amend
--author="Piet Hein <piet.hein@example.com>"
[master 17ff92a] Initial commit
 Author: Piet Hein <piet.hein@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo

Could you post a similar example?

-- 
Cheers,

Sverre Rabbelier
