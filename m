From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 02:37:03 -0500
Message-ID: <5375c01f77285_7e7b772f8f0@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 09:48:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlCsE-0006PM-NX
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 09:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbaEPHsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 03:48:06 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34460 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaEPHsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 03:48:05 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so2514526obc.25
        for <git@vger.kernel.org>; Fri, 16 May 2014 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=MKxLnumNjqwuhkrhi3MMgHeeD9Go88o9bZpPdovKPz0=;
        b=uYol7ARSCXH35913mPEJupKwXaBZhDrpPxKy+n6dO1Z43KPinAy460rYBeOM4AzKLU
         W7v5Nm7J9ikiI6UuUCIRJnh8igEXYpIpGXp6xYKWaTY+0bkhRJC9Pv1K0kgXmHq7R/Mc
         N9Bui6mpYap7GraNtTdPNANtHO1VsjFr+gDrCOmijhEVK2wrxw8XBRVXD3/f/B9dJ3Rg
         W4a0hUIz2g+jSrW+9wdcXb3moWP/bQ+9YmiVwlJ0A5ClZhhapZHOmc1sOeLOWsX9MbDd
         ThCxSovo84bAyS7xXk/1eqPCaYAQfOZW22yluiRtbyiosp5DKwy0jEG/lgqSXkV2I0kX
         eQgw==
X-Received: by 10.60.179.80 with SMTP id de16mr15005903oec.69.1400226484657;
        Fri, 16 May 2014 00:48:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id to6sm13579544obb.6.2014.05.16.00.48.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 00:48:04 -0700 (PDT)
In-Reply-To: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249272>

Junio C Hamano wrote:
> Two announcements for their version 0.2 on the list archive are not
> quite enough to advertise them to their users.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I am inclined to queue this for 2.0, and we would also need an
>    update to the release notes as well.
> 
>    I am undecided about the revert I sent earlier in $gmane/248937;
>    with or without it, that is just a contrib/ thing that is not
>    well maintained inside our tree anyway.
> 
>  contrib/remote-helpers/README | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 contrib/remote-helpers/README

NAK.

> diff --git a/contrib/remote-helpers/README b/contrib/remote-helpers/README
> new file mode 100644
> index 0000000..72a2df4
> --- /dev/null
> +++ b/contrib/remote-helpers/README
> @@ -0,0 +1,11 @@
> +The remote-helper bridges to access data stored in Hg and bzr will be

They are called Mercurial and Bazaar.

> +maintained outside the git.git tree in the repositories of its
> +primary author at:
> +
> +    https://github.com/felipec/git-remote-hg
> +    https://github.com/felipec/git-remote-bzr

If this is formatted in asciidoc the links won't appear as links. Do it
as I did:

 * https://github.com/felipec/git-remote-hg
 * https://github.com/felipec/git-remote-bzr

> +As a convenience, copies of the last-bundled version of these two
> +remote-helper bridges are kept here, but they may left stale.  Users
> +are encouraged to visit the above authoritative repositories for the
> +latest versions to get involved in its further developments.

 1) Most users will *never* see this README
 2) Most packagers will never see this README
 3) The people that do read this README will wonder *why* they are now
    maintained separately.

Thanks for wasting all my hard work and sabotaging these projects.

Just as a heads-up. I *will* complain about this publicly and my blog is
visited by thousands of people.

I am requesting one last time:

 1) Add warnings *directly* into the tools themselves ASAP
 
    You didn't have any problems adding warnings for pre-v2.0 behavior
    that changed, nor did you have a problem adding the warning about
    the new zsh completion that moved out of the bash one. Why would you
    have a problem with this one?

 2) Replace the tools with stubs that point to the right locations at
    the earliest convenience

I already sent patches for both, and they were ignored.

A failure to do both will result in a lack of visibility of the new
projects, and a decrease in the quality the users of git.git contrib
area's remote-helpers receive. I will consider that a deliberate attempt
to make the new projects experience unnecessary hardship.

-- 
Felipe Contreras
