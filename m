From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Aliasing with parameters doesn't seem to work properly in git 
	1.7.0.5
Date: Thu, 3 Jun 2010 17:04:03 +0200
Message-ID: <AANLkTilcESWIptCX3ZIVTrdI9JcC4XrHp9KTjR-jqzj7@mail.gmail.com>
References: <AANLkTilEZknW7m0n3y8SX5oAaZiUTorgqfX3jTB8mnDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:04:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBxu-0006XW-45
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab0FCPEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 11:04:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55766 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab0FCPEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 11:04:07 -0400
Received: by fxm8 with SMTP id 8so167675fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:04:04 -0700 (PDT)
Received: by 10.102.12.10 with SMTP id 10mr3412353mul.96.1275577444020; Thu, 
	03 Jun 2010 08:04:04 -0700 (PDT)
Received: by 10.103.178.17 with HTTP; Thu, 3 Jun 2010 08:04:03 -0700 (PDT)
In-Reply-To: <AANLkTilEZknW7m0n3y8SX5oAaZiUTorgqfX3jTB8mnDC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148331>

On Thu, Jun 3, 2010 at 4:52 PM, Eugene Sajine <euguess@gmail.com> wrote:
[...]

 so instead of command like this:
>
> $git clone git://server/folder/repo.git
>
> i can have something like this:
>
> $git cln folder/repo.git
>
> or even
> $git cln folder/repo

Then, you can the url.<url>.insteadof mechanism:

[url "<actual url base>"]
      insteadOf = <other url base>

       For example, with this:

[url "git://git.host.xz/"]
      insteadOf = work:

you can clone it with: git clone work:project.

See git-clone and/or git-config man page for more information.

HTH,
Santi
