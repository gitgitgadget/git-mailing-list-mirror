From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git for collaborative web development
Date: Thu, 26 Mar 2009 20:18:00 +0100
Message-ID: <fabb9a1e0903261218y329562f6uf18613f3f9e15836@mail.gmail.com>
References: <loom.20090326T184207-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Carlo <mr.spoon21@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 20:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmv7m-0000X5-IP
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 20:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbZCZTSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 15:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbZCZTSU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 15:18:20 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42605 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbZCZTST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 15:18:19 -0400
Received: by fxm2 with SMTP id 2so719780fxm.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5E+c2qCEmBqT/6SZuhrpavxgor4fnTFt/YwxZ4cAMP4=;
        b=RHKJ6gE9koA+VcxmJ0U6CQdGTKN31+s8dn0qIcD4ykMNAZi9Rl2zVHZ8T2wpb9RnpE
         dOiIYepkoVcX2hQ0U94MJm9+HE1g3C8zhcaPC0/r0WLAhi9JMwRjuUQliUWHGvGx2C+7
         K2AIaziXFdZQqNvHwjhbR7eY5XqjvRukbEtbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xPyBMfVNQ/V9oTixIAF8YZ78zQkObUHnvDHbtp5/5rO6ljnqJ9DUw/wvqKRCoE6qC5
         uArA7EdG/mNZ07Mws865NBzAnMB3woq18ICkNpFa3AwKgpQQUQWlo9TqgHzrL1K0mD1h
         IVOjE5YnuFV0HGlWnvQ5kAhXpUNPU0YKmqr88=
In-Reply-To: <loom.20090326T184207-345@post.gmane.org>
Received: by 10.103.225.11 with SMTP id c11mr22933mur.115.1238095095420; Thu, 
	26 Mar 2009 12:18:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114810>

Heya,

On Thu, Mar 26, 2009 at 19:51, Carlo <mr.spoon21@gmail.com> wrote:
> Using git he should save, commit, add, push... so it's a bit longer.
>
> Is there a nice compromise? Or a better way to use git for such a task or web
> development in general?

$ git config alias.tryout "!git branch -f tryout && git checkout
tryout && git add . && git commit -m TryOut && git push shared_repo
tryout"

You can even see the page live if you set the proper attributes ;).

-- 
Cheers,

Sverre Rabbelier
