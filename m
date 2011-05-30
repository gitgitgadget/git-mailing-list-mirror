From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git: 'daemon' is not a git command. See 'git --help'.
Date: Mon, 30 May 2011 13:27:38 +0200
Message-ID: <BANLkTim17a53hP8N-nG-Gad1oB_-g7wSfw@mail.gmail.com>
References: <201105301258.08178.lucio@sulweb.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Lucio Crusca <lucio@sulweb.org>
X-From: git-owner@vger.kernel.org Mon May 30 13:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR0e0-0003w3-CU
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 13:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab1E3L2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 07:28:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52615 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab1E3L2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 07:28:18 -0400
Received: by pwi15 with SMTP id 15so1606303pwi.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=7EBXoKNo7Mzv52dev4dRHlYWeqkdAIzbAFT6iFIhdak=;
        b=tpS3ntuMDTM61rKibfAYyoHWUfkBu9K4BVynD7Nny9Khf2pmKHULwhSc8/iBz3WQ4d
         Q9znItcgh/rWEMzoP85qhjg/iiVNSZkB4/YAvWjd2AkMtNMhKW1meR9hfzJkSb1Oz/lg
         yb0lHdJJXpKSHxFnTDkJ3JUklYMqUHIe3O42s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=bazl5b1SNNf5AZtoV/aIsDbsXInI5yq3GyhAk2mWRC4zVQJHQz+Jji72YOp8UN+8mP
         CN9kRYkcfaH3HBN/y0tyG/nBNhUcNdliTUtJU7DSHFW3lu3/jYXL/BW7m9NNZO5WPTAR
         gpCaqRsDS+E/9NUj3POa75mWAgJlP76/jqq8g=
Received: by 10.68.71.135 with SMTP id v7mr2101024pbu.232.1306754898069; Mon,
 30 May 2011 04:28:18 -0700 (PDT)
Received: by 10.68.47.131 with HTTP; Mon, 30 May 2011 04:27:38 -0700 (PDT)
In-Reply-To: <201105301258.08178.lucio@sulweb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174740>

On Mon, May 30, 2011 at 12:58 PM, Lucio Crusca <lucio@sulweb.org> wrote:
> Hi *,
>
> I'm very new to git and I'm trying to share a git repo on a Centos 5.6 server.
> I've installaed git 1.7.4.1 with yum (I already had the epel repo setup).
> git init, add, commit work as expected, but when I
>
> # touch .git/git-daemon-export-ok
>
> and
>
> # git daemon
>
> I get:
>
> git: 'daemon' is not a git command. See 'git --help'.
>
> And no git-daemon file can be found in /usr (find /usr -name git-daemon). Google
> seems to be aware of this problem only about msysGit (windows).
>
> What am I doing wrong?

A quick google search tells me that git-daemon is a separate package
for Red Hat.
