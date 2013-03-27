From: Jim Kinsman <jakinsman@gmail.com>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 13:15:43 -0500
Message-ID: <CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
	<vpqr4j0rccf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKutQ-00051J-0R
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab3C0SPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:15:44 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:64135 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3C0SPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:15:43 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so9166772oag.15
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VoVKyEGSukNuOMA/ktdLgrpwYZhYx/tvLgipOC70JuU=;
        b=ep3IllDZlRjfCR5n3vgwmEl66DLFngUhYL0ziMokQXF/eElCXjOl0hM5yFgqdWx5Ov
         8MQEh8rTrLZ+/8Jnc658T2He5jogBFMxhGHPsOzd6f8ch6YRlEH3ql3FgelKnRulZVsp
         JjW3tfnkAOlyPu9M/BYQ2bHsojRpvHfMcBybgpEmibsNmG6oWd8CeMVaABBIpxIr4yJR
         02xsZQddCscJGIfbEBEa/cGQSIGIEju3JaRJPfnyeymYR5kRbudYRE7+bI/RZgXB0wOy
         7kMP8EH1/26ZeFzZwusRfWdNgbj/4MZCYOjIFbkPioZB8NQldY7JuMRRG7aEk93j5qHY
         kZ4w==
X-Received: by 10.60.6.133 with SMTP id b5mr15421249oea.81.1364408143218; Wed,
 27 Mar 2013 11:15:43 -0700 (PDT)
Received: by 10.182.250.133 with HTTP; Wed, 27 Mar 2013 11:15:43 -0700 (PDT)
In-Reply-To: <vpqr4j0rccf.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219295>

The only anti-virus I have installed is Microsoft Security Essentials
I turned off and it was still the same:
$ cat /usr/bin/gitstatus
start_time=`date +%s`
git status && echo run time is $(expr `date +%s` - $start_time) s


$ gitstatus
# On branch test
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   orgoptions.php
#       modified:   update_import_contacts.php
#
no changes added to commit (use "git add" and/or "git commit -a")
run time is 10 s

On Wed, Mar 27, 2013 at 12:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jim Kinsman <jakinsman@gmail.com> writes:
>
>> git status takes 30 seconds on Windows 7.
>
> Any anti-virus installed? They can interfer badly with disk-intensive
> tasks ...
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
