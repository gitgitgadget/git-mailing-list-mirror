From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH v3 11/12] Basic build infrastructure for Python scripts
Date: Sat, 7 Nov 2009 00:23:06 +0100
Message-ID: <16cee31f0911061523v5b9754ebg9c846c0e96ac808@mail.gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-10-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-11-git-send-email-srabbelier@gmail.com>
	 <1257547966-14603-12-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Y9E-0002Y2-3t
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045AbZKFXXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760002AbZKFXXD
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:23:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:33604 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759898AbZKFXXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 18:23:02 -0500
Received: by fg-out-1718.google.com with SMTP id e12so492084fga.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QRtzNkDoYUejko31jvfvNYwgm6tPH6QHl36al+5Zj3M=;
        b=ax9RG3urlNINasGSXc4z5UaR0kUlGpwcduzrf4TaG/pPVHCAMQHhH9aNdDnJ0ouhht
         9j64lxowIEURpx83c0FewTyEhb7GXKPYUjrDtDdGG3g+c1ggz83la2nb6zrhaHuug4SZ
         ay0Nrdk0dkxLURLsP7nHBaLlObSaU7i6obiAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=G0mgILYEhcjrvjOTlkN5kq6pSSbC4WY94HBVGEneRHTopQR9zSyiB5StEdJuc0ImrD
         1bjATqZRajiicPkw2TKaJA2vu6drNzWfwA6gSIfCjb/JkMuKBT1BlsjSq0+ad8MxBg0c
         HVAAcnqPlcu72R88A+KAQGndlSW84dspFZjYk=
Received: by 10.239.139.4 with SMTP id r4mr531337hbr.199.1257549786679; Fri, 
	06 Nov 2009 15:23:06 -0800 (PST)
In-Reply-To: <1257547966-14603-12-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132343>

Hi,

2009/11/6 Sverre Rabbelier <srabbelier@gmail.com>:
> This patch adds basic boilerplate support (based on corresponding Perl
> sections) for enabling the building and installation Python scripts.
>
> There are currently no Python scripts being built, and when Python
> scripts are added in future patches, their building and installation
> can be disabled by defining NO_PYTHON.
>
> Signed-off-by: Johan Herland <johan@herland.net>

Does it mean, that it will be possible to write git-<cmd> scripts in
python or, in example, port bash and / or perl scripts to python?

I'm asking because bash+perl is a huge stopper for Windows platform,
which requires basic unix environment to work, while python support
for Windows is excellent and most of Windows developers already use
python.

--
Andrzej
