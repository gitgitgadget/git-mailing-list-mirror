From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 25 Feb 2008 08:35:43 -0500
Message-ID: <30e4a070802250535g72b59106yb1e4478eb9b9f47a@mail.gmail.com>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org>
	 <200802071056.19370.robin.rosenberg.lists@dewire.com>
	 <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	 <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	 <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
	 <20080225080739.GA13610@piper.oerlikon.madduck.net>
	 <18370.45020.940192.10482@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "martin f krafft" <madduck@madduck.net>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 14:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTdVJ-0002tU-Bj
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 14:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYBYNfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 08:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYBYNfr
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 08:35:47 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:12548 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbYBYNfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 08:35:46 -0500
Received: by gv-out-0910.google.com with SMTP id s4so529877gve.37
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 05:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4kBjbkfTUmnurEAlY1d6Tt/WhoONqe7Ug2CgpSbJWso=;
        b=U6wLZblOiseSbjQlcgsMi5CjBEVpQKzKW9iltHHpRHnHJzhC9cfgEJHXu0E03c4gnQTkM/rlQ+f41KmMghfzIsgNN2MAma1SZQFhH0kXLcsz8kUsVwDQyPzrtDuvT6mAuaWBK2shUHeMjalbOaOTgpY4710J8o8Z1efgBvQz9Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YficaN1+0h9OtZ1OKWgtRG5MofBKrnuja6PsigHeAY+AL2hYnOzupFbfmq0GUTLEscDIkSY5W2TTnJWgjAG81T8eVO+v44YS4DTNQnmhPIWiY1HzrA7OG2PZEUk71V+q8o3ixv0++/p8ZR2wANcFR1fK8lP+9fGDvtxwMOy+jTs=
Received: by 10.142.230.11 with SMTP id c11mr2227744wfh.86.1203946543540;
        Mon, 25 Feb 2008 05:35:43 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Mon, 25 Feb 2008 05:35:43 -0800 (PST)
In-Reply-To: <18370.45020.940192.10482@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75028>

On Mon, Feb 25, 2008 at 7:09 AM, Paul Mackerras <paulus@samba.org> wrote:
> martin f krafft writes:
>
>  > May I suggest that such a patch actually disables writing of the
>  > config file, so that we won't get conflicts every time you sync
>  > config files via home-in-git?
>
>  Then various other bits of config won't be persistent, such as font
>  settings.  So I don't think that's a good idea.
>
>  It would be possible to make the config file be per-repository rather
>  than global, I guess, if that is something people want.  I personally
>  would find it annoying to have to change the font separately in each
>  repository, but tastes differ, I guess.
>
>  Paul.
>
Two things we could do:

1) Add a "save config now" button and a "save config on exit"
checkbox/option to the options dialog.
2) Perform a screen geometry check at load time to see if the corners
of the main window would be visible before applying the main window
geometry.

Mark
