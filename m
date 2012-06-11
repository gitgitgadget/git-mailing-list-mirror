From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone', but
 not a single file present
Date: Mon, 11 Jun 2012 16:28:04 +0100
Message-ID: <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com>
References: <4FD5C263.9010307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ilya Dogolazky <ilya.dogolazky@nokia.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6Xb-0007bX-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab2FKP2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:28:08 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50096 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab2FKP2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:28:05 -0400
Received: by wibhn6 with SMTP id hn6so3072530wib.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 08:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=tF0uZpn8G3MxHaW73VROsZyrSTOBmIee8jON7OfFn/A=;
        b=UbqUll77Wk//Jiza9Uj+BaD+zt83+IOdNoToqjf8sa6R6bOyAbDGfH/toYX9XLEzoO
         Eq6A+c45Bu6xvkbfzffv2DVMwT+kzMY8pRAjAh5UrzJwmZC4Wf+IkfvYbf208q61W2dF
         YK0s6oyxp91IYuEJUFT3+0vQ0qUqEveDo08LAAxJYmaxzfHiJH1chZBzp/hj5ACec5u3
         Ssv/1sCYXb4Ux/g2rUHZtOf53fk6VxQZY2Pnf4LVswUfzjVmcFkrRhZ3qF9CAedj5UWX
         +cl1/+L4ycxj8imEfcLaTKw7mQSpIFR5YvewJa5PApgDINMJ0ijc9DIdzHMt/JMpBf0h
         gLuA==
Received: by 10.180.109.197 with SMTP id hu5mr21753810wib.8.1339428484217;
 Mon, 11 Jun 2012 08:28:04 -0700 (PDT)
Received: by 10.216.193.160 with HTTP; Mon, 11 Jun 2012 08:28:04 -0700 (PDT)
In-Reply-To: <4FD5C263.9010307@nokia.com>
X-Gm-Message-State: ALoCoQm0U907NUEgcNqC+JGWukZ3RLkF+PndgXXHg28tMWSNPyxm+GxkPjZBJnf+S3F2BsfYnSkS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199660>

On Mon, Jun 11, 2012 at 11:03 AM, Ilya Dogolazky
<ilya.dogolazky@nokia.com> wrote:
> Hi !
>
> I hope this is the right mailing list for question regarding the usage of
> git-p4, sorry if I'm wrong.

This is the right place!

>
> Here is my problem: I'm issuing the command
> 'git p4 clone //kalma/xxx/yyy@all'. (the depot //kalma/xxx/yyy/ exists on my
> machine and is full of files). After this command the directory 'yyy' is
> created and the history of commits is visible there by 'git log -p'.
>
> Every commit contains author name, a title (related to the project I'm
> working on, so obviously coming from perforce depot) and a single line
> looking like this:
>
> [git-p4: depot-paths = "//kalma/xxx/yyy/": change = 17473]
>
> Beside of that, the commit is empty: not a single line of code is
> changed/added. And the directory 'yyy' contains only the '.git'
> subdirectory, so not a single file of the project is visible.
>
> Please help me to understand what could be going on there, and what could I
> have done wrong.

If you do something like "p4 describe 17473" what does that show?
Are the files changed all contained with //kalma/xxx/yyy?

It could be that there's a p4 version problem going on - which version
of p4 are you
using? And which platform are you using?

Thanks,
Luke
