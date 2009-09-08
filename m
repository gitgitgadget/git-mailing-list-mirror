From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 8 Sep 2009 07:44:51 +0200
Message-ID: <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 07:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MktVp-0002Wj-22
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 07:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbZIHFov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 01:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZIHFou
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 01:44:50 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59620 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZIHFou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 01:44:50 -0400
Received: by bwz19 with SMTP id 19so1947558bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 22:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pzl4iDEzN+CP1SDj6F/PzSwmkiGmNCKCcwxz3P30UsA=;
        b=ZO+Bk6RbFGp0m97Ys2aXwRH/Z2NyQ7QGZco6CXKA9ruehmBw2BwwFlVR9rROjjojix
         cIPUtoDEpqklKkscHILkspWUPd0T9vssGNorutLJ9t6RJ940xTug/tIlOhmIt/EBrorx
         Nqj4TgeCG838rhWz+Plny0Hur79p5rfsHJ6B4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e0mTzhYaxTa74Z0WYADuaM0ecJK/YdyLaHvwD91xNAa+kuKNfNqXGOAAImCa+J/vPC
         lh0RrMZeg+r44krpWiiABmYz8ou8OdKz1IjALbrQyaNCuA9UeYqPnbSqgvKDoJwaOpP7
         TRcaVBEfLBxdwV9l5FvNH2NhA8XLj0GCzPRPA=
Received: by 10.204.13.79 with SMTP id b15mr12399275bka.112.1252388691662; 
	Mon, 07 Sep 2009 22:44:51 -0700 (PDT)
In-Reply-To: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127969>

On Tue, Sep 8, 2009 at 07:11, Thiago Farina<tfransosi@gmail.com> wrote:
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
> =C2=A0INSTALL | =C2=A0 =C2=A09 +++++++++
> =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index ae7f750..67abfc7 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -1,6 +1,15 @@
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Git installati=
on
>
> +To install git follow these 4 steps inside your git directory:
> +$ autoconf =C2=A0 =C2=A0 =C2=A0# Generates the configure file from c=
onfigure.ac
> +$ ./configure =C2=A0 # Configures everything needed to build git
> +$ make all =C2=A0 =C2=A0 =C2=A0# Compiles git based in the Makefile
> +$ make install =C2=A0# Installs git in your own ~/bin directory
> +
> +If you don't have autoconf installed, you can do this by:
> +$ sudo apt-get install autoconf

=2E.. if you're on a Debian-derived system. The other half of the
world, which is RedHat-derived, uses RPM. And there are
other package management tools. Maybe that was a reason
why the instructions weren't included before.
