From: Jacob Helwig <jacob@technosorcery.net>
Subject: Re: [PATCH v2 1/2] Add top-level maintainers file with
 email/canonical repository information
Date: Mon, 31 Dec 2012 14:25:47 -0800
Message-ID: <CAJ8aY1ETvqgBOwM+r=5nh4RyRjmPp7ur_TRVg-hqaL9DVmWR4A@mail.gmail.com>
References: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com> <1356992375-11116-2-git-send-email-jason.k.holden.swdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, th.acker@arcor.de,
	paulus@samba.org, patthoyts@users.sourceforge.net,
	worldhello.net@gmail.com
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 23:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpnoT-0000Rj-Cj
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 23:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab2LaW0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 17:26:09 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63040 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab2LaW0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 17:26:08 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so12953865vcd.19
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 14:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=sCxCnsNO5r18pp9yMQgOmCnxKtuGsJYyO9tGG9bs+hk=;
        b=VR3Wq46pE8BmLk4y7Dm1Scep/r5xPPTobjeJQ8C8+DDkS+k2LKvb5UtuK3kxA53bZ6
         gt2JrZD8uITvPEmvr/QlDydb3Fr3OCYPUbD3Kir+SStJlhcwBf04nasc0UxGI59q0BQc
         TA4p1PRMmb/id+O3/kuwJ7x69FxSSnxQD+gRy3xOnE5kCgglOaMWE5PGM45zZYDtPcuL
         R9Qqm8sZ9vYKPcoWMXJoW1g2hWzLuqsbzE1guvlzxxS89jpSi29qKbIQKPQivJFMrJpF
         umA1rKmcwDjpfUelTMkcPRhSpX7GzhPQxRei2Cf5ElaK2Ec+h4q/jpC454BNJP+EvAan
         H3/w==
Received: by 10.220.239.143 with SMTP id kw15mr64446904vcb.62.1356992767739;
 Mon, 31 Dec 2012 14:26:07 -0800 (PST)
Received: by 10.220.229.129 with HTTP; Mon, 31 Dec 2012 14:25:47 -0800 (PST)
In-Reply-To: <1356992375-11116-2-git-send-email-jason.k.holden.swdev@gmail.com>
X-Gm-Message-State: ALoCoQkUaUT4IA+IzK+RQqXpBNKVlWs299BuP7G65Qrss8x+bB5/mGzxpGf41xOFhZUNKu6z6Z4P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212364>

One minor grammar nit below.

On Mon, Dec 31, 2012 at 2:19 PM, Jason Holden
<jason.k.holden.swdev@gmail.com> wrote:
> Certain parts of git have a semi-formalized workflow for
> incoming patches.  This file documents the maintainers, their area of
> specialization, their email address, and their canonical repository against
> which patches should be submitted.
>
> Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
> ---
>  MAINTAINERS | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 MAINTAINERS
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> new file mode 100644
> index 0000000..c3a96b4
> --- /dev/null
> +++ b/MAINTAINERS
> @@ -0,0 +1,21 @@
> +Core Git/Overall Maintainer:
> + Junio C Hamano <gitster@pobox.com>
> + git://git.kernel.org/pub/scm/git/git.git
> +
> +
> +Certain utilities packaged with git (git-gui, gitk, and git-po) are maintained
> +upstream of the core git repository.  Their contact information
> +and canonical repositories are below.  Patches to improve these utilities
> +should be made against the tree's referenced below

Should be "trees", not "tree's" (plural vs. possessive/contraction).

> +
> +gitk:
> + Paul Mackerras <paulus@samba.org>
> + git://ozlabs.org/~paulus/gitk
> +
> +git-gui:
> + Pat Thoyts <patthoyts@users.sourceforge.net>
> + git://repo.or.cz/git-gui
> +
> +git-po:
> + Jiang Xin <worldhello.net@gmail.com>
> + https://github.com/git-l10n/git-po/
> --
> 1.8.1.rc3.28.g0ab5d1f
>

-- 
Jacob Helwig
http://technosorcery.net/about/me
