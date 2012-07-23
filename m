From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 23:27:04 +0200
Message-ID: <CAHGBnuNvzoSkrujoxLt-M5VS2Pm=e6CL_P39pyRAv-NEi1y6QA@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFAE1.3070304@gmail.com>
	<7vr4s2mnir.fsf@alter.siamese.dyndns.org>
	<7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
	<500D9E5A.2000204@gmail.com>
	<500D9EDB.90603@gmail.com>
	<7vhasyl0gc.fsf@alter.siamese.dyndns.org>
	<CAHGBnuMCsxmVN8fCSgazqKUwtJzJJxtrVxjKwCEEhZJ_U0cW9w@mail.gmail.com>
	<CAJDDKr4TyDp5vxqqHGkBBSiMJXJHW528+nqrag9Rgz+vksqjhg@mail.gmail.com>
	<7vmx2qji03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQ9o-0006pm-QV
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab2GWV1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:27:07 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65193 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab2GWV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:27:05 -0400
Received: by vcbfk26 with SMTP id fk26so5235206vcb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H4Jfpt3UXzFpnZSZ5+GME6n+Fs6iiwFkStfPehDLw/g=;
        b=Hy/yomWYxIzx2UmN0w6SaKE+9nB7XsK0HfjJL5MpMA6AUszrfZaYz7odg6v9oWGTjx
         8GTfzlpeJsgAVFreBDRhcvhHfyyBQBAKUUeNgbKttYITguVqh0vrSYAYbuWiMAl1KzUX
         40XXWxZQFzB4xhIOsqWwvk8P19rdmhNntOWnby3AlpBC/6vwnhvrHS9z7CH5VvmIQkvt
         sWSmB4h7xV7n9tTfsPKz6Lrc807IB0Ass9wScNUlLP8CjKeVQuP0Vlme2wgBdOW3mU0p
         epmuJH529LWs1s/KaXH+TmcWxilNgO04C7u/EoMpCzEpIVmzzA6Z9Vwm4ET03z91J23r
         PxXw==
Received: by 10.220.215.66 with SMTP id hd2mr13836593vcb.55.1343078824691;
 Mon, 23 Jul 2012 14:27:04 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Mon, 23 Jul 2012 14:27:04 -0700 (PDT)
In-Reply-To: <7vmx2qji03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201988>

On Mon, Jul 23, 2012 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:

> There are only five or six classes of environment that matter in the
> real world for the purpose of giving "well known" examples: Windows,
> MacOS X, Gnome, KDE and Linux terminal.  By picking a representative
> one from each and listing them, the end result would have at least
> one that people from various platforms have _heard of_ and can guess
> what they do.  The "most common" is secondary, and "well known" is

I completely agree with this. So we should take the chance and add a
Windows representative to the list of difftools, no?

> Unlike POSIXy folks, where IRIX or Solaris users are likely to have
> heard of Gnome tools even if they do not use the environment on
> their platforms, Windows users tend to be isolated bunch, so it
> would not hurt to include at least one well-known Windows-only tool
> in the list.

Heh. I believe POSIX folks are no less isolated. (How many
Windows-only tools would you recognize by name?) They're just isolated
in a bigger world ;-)

> Here is a v2, with documentation updates.

This drops the explicit mention of --tool-help as an option in the
documentation compared to my patch. Do you want to keep --tool-help
being mentioned inline as part of the --tool option documentation
only?

-- 
Sebastian Schuberth
