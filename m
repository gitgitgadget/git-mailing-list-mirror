From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add new zsh completion
Date: Mon, 30 Jan 2012 13:32:24 +0200
Message-ID: <CAMP44s2B_WLmGryUv9Fitak67nWhp8Gpw3Ac-dApKB4KjYv1fQ@mail.gmail.com>
References: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com>
	<vpqwr89d1p7.fsf@bauges.imag.fr>
	<4F267AC9.1080407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpTJ-0002FM-WF
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab2A3Lc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:32:26 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39548 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751862Ab2A3LcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 06:32:25 -0500
Received: by lagu2 with SMTP id u2so2124891lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IrkW/g5M4iPkSmU2Vp57FIrtPxYdQKZ98Jupvzg/KxQ=;
        b=hseOZz+7EJZXZwFdZA/2UZ6jBkH1pZSRDBbEWjX8DdqBvZ9Zq0xcbznEERQ4ZaSrtY
         8HiS05R8tUU9aC0LFbjs+f5AKzxTJ/NXKwR1/UlWHlsfXzL+BhSp9Up7jkbqEoety4b/
         cuCWkySRO1egy0n9qyLaFa0Nxhbx6Gf4kYPcs=
Received: by 10.152.132.104 with SMTP id ot8mr8916124lab.17.1327923144113;
 Mon, 30 Jan 2012 03:32:24 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 03:32:24 -0800 (PST)
In-Reply-To: <4F267AC9.1080407@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189347>

On Mon, Jan 30, 2012 at 1:11 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 1/30/2012 9:39, schrieb Matthieu Moy:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +ZSH_VERSION='' . /usr/share/git/completion/git-completion.bash
>>
>> Probably stating the obvious, but this path shouldn't be hardcoded.
>>
>> Something along the lines of
>>
>> ZSH_VERSION='' . $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>>
>> should do it (mostly untested, and written by a non-ZSH expert).
>
> Moreover, if zsh is POSIX compliant, the value of ZSH_VERSION will be an
> empty string after this statement. That may or (more likely) may not be
> what you want.

It's not, only inside that script. Same in bash.

And that's exactly what I want... I wan the git-completion.bash to
avoid any zsh hacks and workarounds.

Cheers.

-- 
Felipe Contreras
