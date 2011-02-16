From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Prevent deleting .gitignore file
Date: Wed, 16 Feb 2011 12:53:45 +0100
Message-ID: <AANLkTi=wgsaXVXARLjpyF_13m0FHFC-gubxY0r7oV__U@mail.gmail.com>
References: <1297848579774-6030991.post@n2.nabble.com>
	<20110216103113.GA20959@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: baluchen <murugan.bala@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 12:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpfxB-0002I1-VT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 12:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957Ab1BPLxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 06:53:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35651 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758809Ab1BPLxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 06:53:47 -0500
Received: by wyb28 with SMTP id 28so1233266wyb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=L3BFQF0rvz/TSCx0jlNwtTSEeuq914CqYxZhJGBm8P0=;
        b=SMfzZBe0HRfzWDBdhElk8UtE3xJrOZZFTCcajYhwUo2acTjkAI++0et5RhdI2yxgVe
         QVNNWOYhfoEneLmvjEsF5lfPutZbYDRreCMbyKLYZ5EcjW7Fnbu6JZmykQv3bMuo4IsB
         WCeO06ujxVgPawlt0I5HWzHQc612CiVjhWUMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IRrplRAn9/ceOMYpM6b8M4fcO/hDQC2x4Klhc+cCUlbBBdPT2dAl2yXX100OV2gFdD
         oN2ttvbf9CM2l6qaUdL6qJ1fSJpskd1ULviGT7qvZKRcX5qpbEuv+CZqCPboU4U+smNI
         yI5LPphi+DALpoOpu/K64D1D8QbYI3vbXOzu0=
Received: by 10.227.155.198 with SMTP id t6mr394480wbw.194.1297857226570; Wed,
 16 Feb 2011 03:53:46 -0800 (PST)
Received: by 10.227.129.18 with HTTP; Wed, 16 Feb 2011 03:53:45 -0800 (PST)
In-Reply-To: <20110216103113.GA20959@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166961>

On Wed, Feb 16, 2011 at 11:32, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Hi,
>
> baluchen writes:
>> Is there anyway to prevent/modify .gitignore file?
>
> Just track it in Git? Everytime you try to stage changes and commit,
> Git will alert you when .gitignore has changed.

And writing a pre-commit-hook, which checks for changes to .gitignore.

Bert

>
> -- Ram
