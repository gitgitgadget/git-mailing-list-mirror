From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: history missing
Date: Tue, 26 Oct 2010 13:04:58 -0700
Message-ID: <AANLkTi=wbC5F6RFeP2K5J3R2+eMrj0H0i9RnGfS9ALq7@mail.gmail.com>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vitaliy Semochkin <vitaliy.se@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 22:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAplu-00009M-W7
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 22:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab0JZUFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 16:05:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34943 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab0JZUFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 16:05:20 -0400
Received: by ywk9 with SMTP id 9so3218683ywk.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=vdj4iMTSkd5t/2A9BDWtVrQNObkvVk7Iw6GVnxF8IiE=;
        b=hS0EEue55RCRqSlCpe2TMm4rlPLyCKsqQUPDnqfEkiqhCoNJmo8xynwulgkOh5GFmT
         rPlqYPCnUDnZT41vaAedbku/gHcEIpw4UkuGjE0cgeCRsnRcAbVHCSQ/gTVps25rsYlo
         bYeXvbqbKc19x8Kh7be0+pZQy7CKhmxggZ5oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xXcOpQWRZKj0CzrOwbD+XBulE2CYNCqfn4Se/7y4Vfrqo0x3JLGyVwXoooabGlfb9i
         uhsW8rq5ZhEjmYfzGqFlgVdASnJUGhwF3P2C4wJjcFO02p90EhIGNUV2DlwjiIdu07da
         TUSP3gg84BF//1pUR9CwjouE4rvaG20Zlw/Jk=
Received: by 10.151.27.6 with SMTP id e6mr3606022ybj.91.1288123519911; Tue, 26
 Oct 2010 13:05:19 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Tue, 26 Oct 2010 13:04:58 -0700 (PDT)
In-Reply-To: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160006>

Heya,

On Tue, Oct 26, 2010 at 12:47, Vitaliy Semochkin <vitaliy.se@gmail.com> wrote:
> I cloned a remote repository
> to check recent changes in origin/master I do:
> git fetch origin master
> git log origin master

So, you can either of:

$ git pull origin master # fetches and merges
$ git log origin/master # looks at what upstream has but that you have
not merged yet
$ git rebase origin/master # rebase your changes on top of upstream
$ git merge origin/master # merge with upstream

-- 
Cheers,

Sverre Rabbelier
