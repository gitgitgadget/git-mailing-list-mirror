From: David Barr <davidbarr@google.com>
Subject: Re: [RFC] "Remote helper for Subversion" project
Date: Sat, 3 Mar 2012 23:41:31 +1100
Message-ID: <CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com>
References: <1330777646-28381-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 13:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3oHJ-0001I4-UV
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 13:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2CCMld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 07:41:33 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45568 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab2CCMlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2012 07:41:32 -0500
Received: by yhmm54 with SMTP id m54so1170114yhm.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 04:41:31 -0800 (PST)
Received-SPF: pass (google.com: domain of davidbarr@google.com designates 10.236.173.195 as permitted sender) client-ip=10.236.173.195;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davidbarr@google.com designates 10.236.173.195 as permitted sender) smtp.mail=davidbarr@google.com; dkim=pass header.i=davidbarr@google.com
Received: from mr.google.com ([10.236.173.195])
        by 10.236.173.195 with SMTP id v43mr19091977yhl.40.1330778491689 (num_hops = 1);
        Sat, 03 Mar 2012 04:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=rfLvi4BvlaiOScEf2bkbeNiXkHH2izPsk89PJCKtfbo=;
        b=Wo0evu438CtulScobjvSWqfr+vhvIAMGfM3d0c/E9ZWyXzhHNL0oZGeAleuaW0Rob2
         xqGe1KiGZd9fhB9WFJ12i6QyDw9avXCcIbk9keyv4zm1Im/3r5UGgVq0+mmYB78YID4g
         +n+uH3m4KovpFqGxuxbHU7Q8yycKo1WRFbLzY2/GwP8wc93Ex8OMiSNGEyYtj158iOoW
         hi7kobnJhSCTOoLoVdYQ2ujhYZO6Y0Gz/DUCcNRZkx830T4mjLD+eU6ww3ZQYs3h0UHS
         dLychUAoJvsorsCZAe9zCJaSEE0ozjM4tCk/BxvqOySBAWkrqed7y0KpEUc7f9xzkNZq
         IU3Q==
Received: by 10.236.173.195 with SMTP id v43mr15128007yhl.40.1330778491635;
        Sat, 03 Mar 2012 04:41:31 -0800 (PST)
Received: by 10.236.173.195 with SMTP id v43mr15127983yhl.40.1330778491497;
 Sat, 03 Mar 2012 04:41:31 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Sat, 3 Mar 2012 04:41:31 -0800 (PST)
In-Reply-To: <1330777646-28381-1-git-send-email-davidbarr@google.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkvAd1xosUb+9OE+dAFpmfvO3BwaF2cAhy8zXO/nX9HqadtYLASmoeSxndxJbMaxAF/A4QvnMbTNqdSSf7lioNYBGANfQx8eZM0yxoQ8ZDDRdlQEFmC7ku/UvzXe8GshQwaI248eD+7hlzcRqnZ7cdr6Dg0JQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192107>

On Sat, Mar 3, 2012 at 11:27 PM, David Barr <davidbarr@google.com> wrot=
e:
> ---
> =A0SoC-2012-Ideas.md | =A0 26 ++++++++++++++++++++++++++
> =A01 files changed, 26 insertions(+), 0 deletions(-)
>
> =A0This is simply the direct translation of last year's project idea.
> =A0This project make significant incremental progess each year.
> =A0I'm seeking feedback from all involved on setting the direction.
>
> =A0--
> =A0David Barr
>
> diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
> index 5e83342..4c2ab05 100644
> --- a/SoC-2012-Ideas.md
> +++ b/SoC-2012-Ideas.md
> @@ -182,3 +182,29 @@ this project.
>
> =A0Proposed by: Thomas Rast
> =A0Possible mentor(s): Thomas Rast
> +
> +Remote helper for Subversion
> +------------------------------------
> +
> +Write a remote helper for Subversion. While a lot of the underlying
> +infrastructure work was completed last year, the remote helper itsel=
f
> +is essentially incomplete. Major work includes:
> +
> +* Understanding revision mapping and building a revision-commit mapp=
er.
> +
> +* Working through transport and fast-import related plumbing, changi=
ng
> + =A0whatever is necessary.
> +
> +* Getting an Git-to-SVN converter merged.
> +
> +* Building the remote helper itself.
> +
> +Goal: Build a full-featured bi-directional `git-remote-svn` and get =
it
> + =A0 =A0 =A0merged into upstream Git.
> +Language: C
> +See: [A note on SVN history][SVN history], [svnrdump][].
> +Proposed by: David Barr
> +Possible mentors: Jonathan Nieder, Sverre Rabbelier, David Barr
> +
> +[SVN history]: http://article.gmane.org/gmane.comp.version-control.g=
it/150007
> +[svnrdump]: http://svn.apache.org/repos/asf/subversion/trunk/subvers=
ion/svnrdump
> --
> 1.7.9
>

+cc: Ramkumar Ramachandra, Sam Vilain, Stephen Bash
I wasn't even close to "all involved.

--
David Barr
