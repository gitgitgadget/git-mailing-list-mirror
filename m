From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git rebase : knowing where I am...
Date: Thu, 11 Apr 2013 15:45:38 +0800
Message-ID: <CALUzUxrkt-7svY83FFnn23Xk0bTp=vW3OiFB8xq_Aw_0AcV_Mw@mail.gmail.com>
References: <1124759476.1420642.1365583233806.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Apr 11 09:46:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQCCp-0000KY-DK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 09:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710Ab3DKHp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 03:45:59 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:47666 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab3DKHp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 03:45:58 -0400
Received: by mail-ia0-f178.google.com with SMTP id f27so1156287iae.37
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hf/FiqndtdJk7oUl/PuyMLNMKLQ7wYXRKtO3HBxe6pE=;
        b=VmW+8YSDuoamDPcbNDSU9H8o6MS0sUxae5KDm+Vpw+XYd0MwDObkQ63DmGMz5CqeDA
         hhXfW7q6qjS3lkki1fjhyQyY1GYSQthhGSZPysU9x5OWTPo27clKHMiHxeoTb7+X003g
         /NSoSl0zjkiK9ZhV24BMt907GAEbnTQAi2un63vUAU5vsxTi3XtVqLkZzycTkeik7uxV
         60gIt+X2kAWKaNLvr65mR31tb+jSbXkfaSqqsXcevTiAAZaBe3n95fR/knsEXGCK4RMF
         2bjaAU58rWv5KYHLD2ch7mwgIcjeBPLe1R9ppTHexaHIHl5uuINx116eCD4FfJirqYQv
         TJ6Q==
X-Received: by 10.43.65.195 with SMTP id xn3mr3316914icb.5.1365666358375; Thu,
 11 Apr 2013 00:45:58 -0700 (PDT)
Received: by 10.64.61.70 with HTTP; Thu, 11 Apr 2013 00:45:38 -0700 (PDT)
In-Reply-To: <1124759476.1420642.1365583233806.JavaMail.root@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220831>

On Wed, Apr 10, 2013 at 4:40 PM, Jeremy Rosen <jeremy.rosen@openwide.fr> wrote:
> is there some way to know how far you are within a rebase when the rebase is interupted by a conflict other than the message given by git rebase when it was interrupted ?

How about

  $ cat .git/rebase-merge/done

sample output:

  p 3b465bd foo2 1
  e 03f8bea foo2 2
  e 0871817 foo2 1

last line is the current commit being edited/under conflict/etc.

--
Cheers,
Ray Chuan
