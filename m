From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Build oddities
Date: Sun, 5 Feb 2012 13:46:52 +0700
Message-ID: <CACsJy8CCCMXUSKMu3+cpngxGPi+ci=C0ra_3aUpz9PCT=NyPVw@mail.gmail.com>
References: <loom.20120205T072940-523@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael <kensington@astralcloak.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 07:47:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtvsp-0000Rw-VZ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 07:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab2BEGrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 01:47:24 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:61451 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab2BEGrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 01:47:23 -0500
Received: by werb13 with SMTP id b13so3593184wer.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 22:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w6VA1UCwmfpI9/k0CF9vrbZ74XIQGNp13IR0tVUoIc8=;
        b=T4DUu1tLWDREDidyDjXDUB4yYwLM1rDs8NoOWN5flUf9tliTU29tGQByvl+lPnf2ju
         HZyjRhj3af/BOBQvL91P/hqAkbNN/d9z2bvoqA7h+QgwNnbNwnreHhxgd9uHM86BXseb
         DqPPINW08Cy80KRKj7sMseZ7lNYrA25mSBrxA=
Received: by 10.216.132.214 with SMTP id o64mr1548257wei.26.1328424442297;
 Sat, 04 Feb 2012 22:47:22 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Sat, 4 Feb 2012 22:46:52 -0800 (PST)
In-Reply-To: <loom.20120205T072940-523@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189932>

On Sun, Feb 5, 2012 at 1:34 PM, Michael <kensington@astralcloak.net> wrote:
> Hi there,
>
> I ran into a build oddity with git today - the environment variable $X is
> appended to most binaries. At the time, I had X=last, so I ended up with
> gitlast, git-peek-remotelast etc.

$X is to append .exe for Windows build so you would get git.exe,
git-peek-remote.exe... We should set X to empty from the beginning.
Patches are welcome.
-- 
Duy
