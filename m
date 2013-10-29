From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Limiting disk usage
Date: Tue, 29 Oct 2013 14:50:32 +0100
Message-ID: <CAA01Cso+yTzatiAaQahx5h2N0nnOON7FsnWNSYrN-pV=8qzn7g@mail.gmail.com>
References: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com>
	<vpqob68ebcu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 29 14:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb9gs-0008OX-E7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 14:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab3J2Nue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 09:50:34 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:57955 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab3J2Nud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 09:50:33 -0400
Received: by mail-ee0-f43.google.com with SMTP id b47so2632875eek.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E5STbBlC1RGzpGmBdfzB/CM6taetiIwM0aYmVysraZE=;
        b=HlCvLvEIOGtk+qDioXaZ4VObXfkZqg5gkjT23oVDM7UnUKlx15iaDBvott6rHlMLrJ
         DuOoQ6ge39/8bMQZpLrbOg5D1zNksnWYI+lUHu6xH1eEc1Grv6LRyN2JxIgXvyrvt74a
         289wVPIZgwjOK9Fpexaqws6ZfA+KU0EfcIxFGVJrKwxDq75oV7fBL2Zt08nibq33yCED
         UQAtW47adeNZZELwQHt/9zzuTxyS/ddgMhMrqrGer9RGSgjMN+SE88bwWwMcVJh9s4wC
         jxincEbfZ4DL1+0xsSU5FH/vHsqFupgyNLlmpT96oIb+KyXqKNScwCsfKDa7lVgYUd7C
         5NbA==
X-Received: by 10.14.214.73 with SMTP id b49mr2792510eep.89.1383054632648;
 Tue, 29 Oct 2013 06:50:32 -0700 (PDT)
Received: by 10.223.168.9 with HTTP; Tue, 29 Oct 2013 06:50:32 -0700 (PDT)
In-Reply-To: <vpqob68ebcu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236923>

[resending as sent previous version as HTML, sorry about that]

On Tue, Oct 29, 2013 at 9:21 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
> > Hi,
> >
> > What can be done to limit amount of space occupied on clone and
> > checkout? I know about shallow clone and sparse checkout, anything
> > else?
>
> Sorry if I'm stating the obvious, but "git gc" is a good start. If you
> did something wrong with your repo before, maybe "git gc --aggressive"
> can help.

Yes, I put a lot of code into the repository. I know it is wrong from git POV ;)
That's why I wrote about splitting repository into multiple smaller
repositories, but AFAIK git is not very good at managing that too...

(Background: we're thinking about migrating svn repository into git.
Currently there is one svn repository containing many related
directories. They are branched/merged/tagged together. Often work is
done on all/many of them, but there are some use cases where we need
only some of them)


-- 
Piotr Krukowiecki
