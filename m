From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH v2] git-commit --patch
Date: Sun, 6 Feb 2011 13:06:31 -0800
Message-ID: <AANLkTimCS0Tj7KosZ7RJK8Q9ucxw-0qr-aV-KrbqHMHU@mail.gmail.com>
References: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: conrad.irwin@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 22:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBog-0005rD-OM
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 22:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab1BFVGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 16:06:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35967 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab1BFVGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 16:06:32 -0500
Received: by gyb11 with SMTP id 11so1506266gyb.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XPY6BhxASayO8Vi+EOuZh+6biBPRwGSZ0VXEybm9Y0M=;
        b=DcVfbSeCp2WDAOV4d8UtBtJ6ZJWuRH/QUggU2ew0vtpXySB2Ho3bhBQh+Y7NRC/s2b
         kGoCkJxnqs9JewPTMeMUOGw0B+NwEb6/VpyQN3qG0fFPKr5pzauQrijiy/VgoqEJyQnO
         OtgV63jxxFZlqSHbG7+3s/kZxOW1sW6LS9GbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eVDJiuh7PAcAre5lU6/N2R4rYPuI2TVGXv9AFZrXJ3U7XmXEfSzbi/9Af9uh2PsQc7
         v8LK/qOfunYthAP8WWMEZ1HMigX7jtzoUEOGGh8t0gpnLYKu+kxX4K+hUK7CYi/SRXrd
         Qqbg7AdL8DC7fz3/SdjlX1r17qElsaFpDi0v4=
Received: by 10.236.108.7 with SMTP id p7mr29360562yhg.33.1297026391855; Sun,
 06 Feb 2011 13:06:31 -0800 (PST)
Received: by 10.236.109.147 with HTTP; Sun, 6 Feb 2011 13:06:31 -0800 (PST)
In-Reply-To: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166204>

Is there a recommended way of stirring up attention for patchsets like
this, or did I just miss the replies?

Conrad

On 2 February 2011 21:25, Conrad Irwin <conrad.irwin@gmail.com> wrote:
> This patch-set adds support for git-commit --patch, and tidies up som=
e of the
> rough edges of git commit --interactive.
>
> The motivation is to support my current workflow, which goes somethin=
g like:
>
> 1. Hack out the basic structure of the feature that I'm working on, u=
ntil I have
> =A0 something that looks like it will work.
> 2. Split this into several commits with a more logical flow (i.e. som=
e that add
> =A0 support for the techniques I want to use for the actual feature, =
then the
> =A0 feature itself).
> 3. Start fleshing out the implementation, and bug-fixing, with lots o=
f
> =A0 git-commit --fixup so that the changes end up in the right commit=
=2E
> 4. At the end of the day, a big rebase -i to make the history readabl=
e.
>
> This is just about doable with git-add -p, or git-commit --interactiv=
e, but
> it's very inefficient. I take the presence of git commit --fixup to i=
mply that
> other people are doing similar, if less extreme things, so assume tha=
t they
> would like a git-commit -p too.
>
> Conrad
>
>
