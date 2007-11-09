From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git push failing, unpacker error
Date: Fri, 9 Nov 2007 09:43:49 -0500
Message-ID: <9e4733910711090643t493b0e6fl2a18390a2f9ab842@mail.gmail.com>
References: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
	 <9e4733910711090637tcf7e837na863a4276578bf3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqV5x-0005Ni-S7
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760679AbXKIOnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758271AbXKIOnv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:43:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:46084 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760147AbXKIOnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:43:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so627931wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yJ3YGo2UKiX98NYnrZpdZNEV7h96EjPpC9bFQWr4pbw=;
        b=rNj/zEvRFrJTlCCsBZfeGUXdhn89yWb14LArltcd0r7dxgp3/9xDcaYgW1G72y6bm1gFjJYp5g9jzKqQgDi2j47T8adW6vOVvA9ZlrAaKyLUdXZgYN5gVFI8uuKBrboaAj5woHyHyTT21h+hZEy1cMruOTnqHbekMKlQk9oVH88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2z6JtWKmLUSDr0yW+MpPvHDHTs/plis7gdf6xvsdqBVaapm4NEqUIldPW8V0Y0XsH/MPdrpLiFIX0bV+Pn8fzhv770+f3n/GPxOvpwEOedPjmeg2eAYCSU9mgsfOVMWqLmrTRXTYcBg72voevNFFto3zUEA9G268fmMQyQVpKM=
Received: by 10.115.59.4 with SMTP id m4mr435141wak.1194619430001;
        Fri, 09 Nov 2007 06:43:50 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 06:43:49 -0800 (PST)
In-Reply-To: <9e4733910711090637tcf7e837na863a4276578bf3f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64193>

On 11/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> I updated both sides to current git and it still fails. How do I debug this?
> What's causing this, "error: pack-objects died with strange error"?

My remote host is running 2.4.32, is git ok on that kernel?

>
>
> jonsmirl@terra:~/mpc5200b$ git push dreamhost
> To ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git
>  * [new branch]      m24 -> linus/m24
>  * [new branch]      m25 -> linus/m25
>  * [new branch]      m26 -> linus/m26
>  * [new branch]      m28 -> linus/m28
>  * [new branch]      m29 -> linus/m29
> Counting objects: 81156, done.
> Compressing objects: 100% (15280/15280), done.
> error: pack-objects died with strange errorMiB | 412 KiB/s
> unpack index-pack abnormal exit
> ng refs/remotes/linus/m24 n/a (unpacker error)
> ng refs/remotes/linus/m25 n/a (unpacker error)
> ng refs/remotes/linus/m26 n/a (unpacker error)
> ng refs/remotes/linus/m28 n/a (unpacker error)
> ng refs/remotes/linus/m29 n/a (unpacker error)
> error: failed to push to 'ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git'
> jonsmirl@terra:~/mpc5200b$
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
