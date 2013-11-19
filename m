From: Thomas Koch <thomas@koch.ro>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Tue, 19 Nov 2013 13:36:30 +0100
Message-ID: <201311191336.31000.thomas@koch.ro>
References: <vpqiovpfxd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 19 13:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VikXv-0003Om-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 13:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab3KSMgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 07:36:37 -0500
Received: from mx51.mymxserver.com ([188.94.250.25]:45373 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab3KSMgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 07:36:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.mx51.mymxserver.com (Postfix) with ESMTP id A08D651EB5;
	Tue, 19 Nov 2013 13:36:32 +0100 (CET)
X-Virus-Scanned: by Mittwald Mailscanner
Received: from mx51.mymxserver.com ([127.0.0.1])
	by localhost (mx51.mymxserver.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t1H0KzYqVPRJ; Tue, 19 Nov 2013 13:36:32 +0100 (CET)
Received: from koch.localnet (178-83-150-212.dynamic.hispeed.ch [178.83.150.212])
	(Authenticated sender: koch@comsolit.ch)
	by mx51.mymxserver.com (Postfix) with ESMTP id 94EE851E60;
	Tue, 19 Nov 2013 13:36:31 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.10-0.bpo.3-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <vpqiovpfxd1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238025>

On Monday, November 18, 2013 06:11:54 PM Matthieu Moy wrote:
> Hi,
> 
> I'm normally an Emacs+command-line user, but I also use Eclipse or
> Netbeans on some projects. I tried using EGit and the Netbeans plugin
> for Git, but found the GUI both more comlex and less powerful than the
> command-line. I end-up using command-line git in a terminal, outside the
> IDE (and do a refresh in the IDE after commands that modify the
> worktree). Obviously, being a long-time command-line user, I'm rather
> heavily biaised ;-).
> 
> I was wondering whether others had similar (or not) experience. In
> particular, as a teacher, I'm wondering whether I should push my
> students towards the GUI in the IDE, or advise them to keep using the
> command-line (we teach them git with the command-line first anyway, but
> after a year of practice, we may want to show them the GUI equivalent).

I'm a software engineer now with an education as a high school teacher. From a 
theoretical point of view it's preferable to avoid any abstraction done by a 
GUI and use commandline Git. Only gitk is useful to have a visual _feedback_ 
of the actions done on the commandline.

But also from experience I can tell that without exception everybody whom I 
teached Git understood it only after being introduced to the basic concepts of 
Git and how to inspect and operate them on the commandline. Others told me 
from similar experiences.

Those concepts are:

- hashes
- content adressable storage
- blops being referenced by trees being referenced by commits

My collegues meanwhile dumped their graphical Git tool because they learned 
that they have better control over Git when using it from the commandline.

Regards, Thomas Koch
