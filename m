From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Mon, 12 Dec 2011 09:00:37 +1100
Message-ID: <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
 <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
 <201112102030.15504.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Sidney_San_Mart=C3=ADn?= <s@sidneysm.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 23:01:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZrSF-0006GR-G8
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 23:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab1LKWBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 17:01:00 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37552 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752439Ab1LKWBA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 17:01:00 -0500
Received: by lagp5 with SMTP id p5so1705682lag.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v4UlovK2geeT18hhI7v415oYFpzPtuDa9garEe1dEI4=;
        b=FWB8R3SzvQnQtB7U92Vf8sACp2LL8DKDBmkADQZB60CTs+l0NzDT1RxfBjiYHy3bS1
         5k4GNvL661FZRPJS1Jr1eyE/fRPHAX5DcNzLTojJWbL/dBKZ3pR8vXpgAWGdg6b5Ff0C
         1PpRyLshjMRNPZjBncbgrJdChqMCN0JpxcYLI=
Received: by 10.152.134.10 with SMTP id pg10mr10488191lab.3.1323640858301;
 Sun, 11 Dec 2011 14:00:58 -0800 (PST)
Received: by 10.152.22.38 with HTTP; Sun, 11 Dec 2011 14:00:37 -0800 (PST)
In-Reply-To: <201112102030.15504.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186818>

Hi,

On Sunday, December 11, 2011, Jakub Narebski <jnareb@gmail.com> wrote:
...

> Additional and the more serious problem with wrapping on output is
> related to backward compatibility.  If you have commit message that is
> wrapped e.g. to 80 characters, and you wrap on output to 72 characters,
> you would get ugly and nigh unreadable ragged output

For what it's worth, I do a lot of reading emails on my phone, which
force wraps line-length to the width of the display (not a set number
of characters).
This is always less than 80.

Emails on this list are almost exclusively sent pre-wrapped to 80
character line lengths.
The result is exactly the kind of ragged output you used in your
example. Changing this behaviour may break backwards compatibility,
but it is already broken for 'future' compatibility.

Regards,

Andrew Ardill
