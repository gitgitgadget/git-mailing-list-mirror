From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 20:57:47 +0100
Message-ID: <CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, andrew.ardill@gmail.com
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:57:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbbtq-0002Ky-SB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab3J3T5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:57:50 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:57443 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3J3T5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:57:49 -0400
Received: by mail-we0-f180.google.com with SMTP id q59so1806620wes.11
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3/JzN9+CmVS6qwCyp9UPjGGC84KYKNQYNK8VsLdICm0=;
        b=Y8UQTh7+1+KDllAGoaKoJELwDkOECghWqr6bRxGmgPQ7KAaYmmmkSdb6lJKJBVjEWF
         HSSvIZ2V65OmasnAi4JZLCQ+pNx7aUvFv5iLxgq7gqMGPWFlVEcLdxUxNsGUDHHWc+vz
         izAcEPrLLsH31QUifcmtXxWC/ylYjo74YZ1gwGgisxC1akN48MVAN0rAU6mKA9JA3yq2
         lIFOEs6kp4W006mqKj5BSCXpuFGr2pvcaIH/Z5X9DZ9L5u2ORwvqz6dPcF/gUdyfsO6T
         8nroCdpA5nw8vy7EaEcnU83GEBmWDWXQwE236i91leByiccJK5X98Q57mNlLYsH+lJB/
         Csag==
X-Received: by 10.180.72.135 with SMTP id d7mr339468wiv.65.1383163067744; Wed,
 30 Oct 2013 12:57:47 -0700 (PDT)
Received: by 10.194.165.163 with HTTP; Wed, 30 Oct 2013 12:57:47 -0700 (PDT)
In-Reply-To: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237064>

lg=!git log --pretty=format:'%h %ad %ae %s' --date=short | sed 's/@\\S*//g'

should work.

On Wed, Oct 30, 2013 at 8:34 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> I need some advice about creating the git command alias:
>
> I have this as the command:
>
> git log --pretty=format:"%h %ad %ae %s" --date=short | sed 's/@\S*//g'
>
>
> The purpose is to cut off the email domain and keep only username.
>
> I'm trying to create this as the alias:
>
>
> lg = !sh -c 'git log --pretty=format:"%h %ad %ae %s" --date=short |
> sed 's/@\S*//g'' -
>
> but it complains about the \S and i'm failing to come up with the
> escape sequence to make it work right.
>
> I know i can work around that by creating shell alias, but it is not
> what i would like to have.
>
> Any ideas?
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
