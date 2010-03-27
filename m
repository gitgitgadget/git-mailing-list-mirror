From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: commit --strict feature request
Date: Sat, 27 Mar 2010 19:50:52 +0800
Message-ID: <be6fef0d1003270450s32ab997cmfe6f6b7e6e4a16a8@mail.gmail.com>
References: <4BA8FEA4.60504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tim Mazid <timmazid@hotmail.com>, git@vger.kernel.org
To: Dario Bertini <berdario@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 12:51:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvUXd-0007N1-DX
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 12:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab0C0Luy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 07:50:54 -0400
Received: from mail-iw0-f196.google.com ([209.85.223.196]:59950 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab0C0Lux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 07:50:53 -0400
Received: by iwn34 with SMTP id 34so8881320iwn.15
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=SvSS74ppsBTkVoTv/7O8SptLZ64IdnBm8Q2P6tmUspE=;
        b=fBysrHJSmeLRt05j5epACmxxcL1Y3dpl+//KTnT/pnVHUrNQqOKmx65sdo2NRrp79W
         4/axCXYH2k3GKXlEGfInOHzrWWcyD2KWHQSxUgSopKVGjYXuyPAEgEbTeTOrAUXb6n+4
         LbeBXND7v6SknXDDAyG00NN8VVgEfvtqlihJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DkTqsNiy7tZxYptf6CLthWmw9t3tQ01ioEmw1YpO7B9jJLIrqx22HgDCaXG4YU1FkK
         r7YzVf4cdG6bJfCnyui7UJvNmWyzqJoxn6aFLbn4/sZMJKvzYaFXCHkacnI7qVTZuKdo
         EwMoX9Djj0hTDmd+ToMZv1GlyhA+quljtDJZU=
Received: by 10.231.37.5 with HTTP; Sat, 27 Mar 2010 04:50:52 -0700 (PDT)
In-Reply-To: <4BA8FEA4.60504@gmail.com>
Received: by 10.231.173.129 with SMTP id p1mr1137025ibz.85.1269690652973; Sat, 
	27 Mar 2010 04:50:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143327>

Hi

On Wed, Mar 24, 2010 at 1:47 AM, Dario Bertini <berdario@gmail.com> wrote:
> Hi, i usually use bzr, and today i was searching for a commit --strict
> equivalent in git... i asked around and it seems there isn't one, so i'm
> writing this.
>
> basically, by doing commit --strict it refuses to commit if there are
> untracked (and thus not ignored) files in the tree, this helps against
> forgetting to add new files (actually i find it so useful that i've even
> changed commit to be an alias to commit --strict in my bzr aliases )

check out the pre-commit hook:

  http://www.kernel.org/pub/software/scm/git/docs/githooks.html#_pre_commit

You could make it scan the directory, then veto the execution of
git-commit if any untracked files are found.

-- 
Cheers,
Ray Chuan
