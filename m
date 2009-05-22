From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 01:02:55 -0400
Message-ID: <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 07:08:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Mzn-0003TY-1m
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 07:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758178AbZEVFDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2009 01:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758171AbZEVFDQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 01:03:16 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:36958 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758119AbZEVFDO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 01:03:14 -0400
Received: by gxk10 with SMTP id 10so2823273gxk.13
        for <git@vger.kernel.org>; Thu, 21 May 2009 22:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=uQiX3CaLF7yoExjm4HXfW0R15XFYH4VLfcIoKgOMqvU=;
        b=RBjVhQrvLGs9+uZFzsw1mop41RBrhzgzSzlw9WbyZR9jQcYWXU033JLJn5lK9aI0ia
         ZD69mrbRhqQIpXUyZDHLwyuqtU/9Cr/QiNTtH6TQPbaWtRBn2gbbPkFxMxjMBwhfahp+
         P+gCzxjnCaIiuetS6YBKqNldB93YxSCBFiuqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JLFTiDlyHxrflTsRb/iIK3A2vki63D7FZ73+iGTvjYBkAFATJMpaGwTMgiAdiVPgug
         devuRyiqZ5dh7Z2Tu274xsnJicBkV/uM6z8NGkblyOVt9bTBmQTOPrS2oRDdcl054TXY
         WdE0MU6FXPufltzfMbocFiU0K4nbqtY6+EZQs=
Received: by 10.151.7.21 with SMTP id k21mr6815554ybi.119.1242968595309; Thu, 
	21 May 2009 22:03:15 -0700 (PDT)
In-Reply-To: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119711>

On Thu, May 21, 2009 at 11:46 PM, Tim Uckun <timuckun@gmail.com> wrote:
> A transcript...
>
> git init
> git add . > /dev/nul
> git commit -m 'initial import'

=2E..okay...

> *********Try to rename a directory =A0WTF?: Git thinks any directory =
with a
> .git folder is empty and refuses to rename the directory.

Well, why do other folders contain .git directories?  Are they
*separate* git repositories?  If so, git doesn't know what to do with
them and leaves them alone.  (Well, in fact it treats them as
submodules.)

All your other weird problems seem to come from this, as far as I can
tell.  If not, it would be helpful if you could give *complete*
reproduction steps for your problem.

Have fun,

Avery
