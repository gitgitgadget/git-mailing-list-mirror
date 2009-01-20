From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 22:07:55 +0100
Message-ID: <49763D2B.1000607@morey-chaisemartin.com>
References: <20090120191952.GA25322@uts.thewillards.local> <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNr4-0001kw-Ps
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 22:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596AbZATVI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 16:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757217AbZATVI0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 16:08:26 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:57496 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756151AbZATVIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 16:08:25 -0500
Received: (qmail 25057 invoked by uid 503); 20 Jan 2009 21:08:14 -0000
Received: from gw2.ovh.net (HELO mail242.ha.ovh.net) (213.251.189.202)
  by 42.mail-out.ovh.net with SMTP; 20 Jan 2009 21:08:14 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 20 Jan 2009 21:07:58 -0000
Received: from agrenoble-152-1-95-122.w86-200.abo.wanadoo.fr (HELO ?192.168.10.200?) (devel@morey-chaisemartin.com@86.200.202.122)
  by ns0.ovh.net with SMTP; 20 Jan 2009 21:07:56 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com>
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 4407898136830660251
X-Ovh-Remote: 86.200.202.122 (agrenoble-152-1-95-122.w86-200.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106524>

Reece Dunn a =E9crit :
>
> If you are committing the files to a shared public repository (e.g. a
> central repository, or build server repository), a pussible approach
> is to create that as a "bare" repository (one with just the contents
> of the .git folder - i.e. it does not have any files checked out). Yo=
u
> can do this by running:
>     git clone --bare source/git/path/project project.git
> you can then clone from this:
>     git clone my/shared/project.git
> and push any changes to it as normal.
>
>  =20
Hi,

I did the rookie mistkae on the central server to create the main
reposity in non-bare mode. So i need to checkout the HEAD revision each
time I push.
Is there a cleaner way to convert a non-bare git repo into a bare repo
than cloning it?
My repo have a lot of remote branch registered, and cloning them to a
new bare repo mean I'll have to add all those remote branches again
(except if there is another trick here I don't know about).

Regards

Nicolas
