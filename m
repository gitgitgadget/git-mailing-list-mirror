From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Thu, 18 Feb 2010 19:37:00 +0100
Message-ID: <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiBFg-0003vm-OV
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab0BRShW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:37:22 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:55275 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab0BRShU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:37:20 -0500
Received: by pxi29 with SMTP id 29so3601233pxi.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=VdeAumElvFQhrzrs3/lg5wqp16VlfwVJqnzVr5BGUNc=;
        b=ECDx1vrABFZuX7qfhhRv79MOvmlt43j9RoyT9XY5s8fmXd+wwflptEJ3pPxfAcv2sS
         pXCAitb2dnjXjRR/23uU6ecAkmmeQ7tIb5goMVKlb1zS6cTUCzGkVkOUItznu7ZjDxuL
         QFY9+uAqy/7gnTpWAvke38O0/KiCdIFFMda50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FE2crlar0VcUgHckvsqbag6IrjxsX891b7g+WQF7ERYyzOhnSb86kWRmzdCv+FHn8a
         0cUKG0WxeOV6LGx8z2AODp/F+so/AG/YCb74A3anJR/W+xnebD4C/+Y0oKcY7MB4q5Pa
         mPjBMpr3ZM/pqA6hHXHGA70IbfcA5Chif974Y=
Received: by 10.142.6.11 with SMTP id 11mr6639499wff.88.1266518240108; Thu, 18 
	Feb 2010 10:37:20 -0800 (PST)
In-Reply-To: <4B7D8358.1080108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140358>

Heya,

On Thu, Feb 18, 2010 at 19:13, Gabriel Filion <lelutin@gmail.com> wrote:
> Is there any interest from people of this mailing list to see this
> script make it to a usable state?

While I have no interest in bzr, I do have interest in making git
interop with more (d)vcs-es. In that light it'd be awesome if instead
you created a remote helper instead of 'git-bzr'. By implementing a
remote helper people can just clone a bzr url, and work with it in the
exact same way that they would interact with a regular git repository.
If you're interested have a look at
Documentation/git-remote-helpers.txt, and read the mailing list
archives on the subject.

> If so, having some code review would be more than good. What do you
> recommend on doing: using this mailing list or putting one up that would
> be specific to the project?

Definitely use the git list if you intend do have it included in
git.git, which I think would be a good thing :).

-- 
Cheers,

Sverre Rabbelier
