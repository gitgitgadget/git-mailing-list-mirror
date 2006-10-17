From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:44:11 -0400
Message-ID: <45355CBB.80108@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<45349162.90001@op5.se>	<453536AE.6060601@utoronto.ca>	<200610172301.27101.jnareb@gmail.com>	<45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZxfa-0006K1-Jh
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWJQWoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWJQWoU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:44:20 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:43716 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1750823AbWJQWoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:44:19 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZxfR-00053e-00; Tue, 17 Oct 2006 18:44:14 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29127>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sean wrote:
> On Tue, 17 Oct 2006 17:27:44 -0400
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> 
>> Bzr has plugin autoloading, Protocol plugins, Repository format plugins,
>> and more.  Because Python supports monkey-patching, a plugin can change
>> absolutely anything.
> 
> But really why does any of that matter?  This is the open source world.
> We don't need plugins to extend features, we just add the feature to
> the source.

That can lead to feature bloat.  Some plugins are not useful to
everyone, e.g. Mercurial repository support.  Some plugins introduce
additional dependencies that we don't want to have in the core (e.g. the
rsync, baz-import and graph-ancestry commands).

Plugins also don't have a Bazaar's rigid release cycle, testing
requirements and coding conventions, so they are a convenient way to try
out an idea, before committing to the effort of getting it merged into
the core.

> The example I asked about earlier is a case in point. 
> Apparently in bzr "bisect" was implemented as a plugin, yet in Git it
> was implemented as a command without any issue at all, no plugins
> needed, and its compiled and runs at machine speed.

The bisect plugin is just as performant as any other bzr command.  (The
whole VCS is in Python.)  Most people don't use it, so we don't ship it
as part of the base install, but anyone who wants it can have it.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNVy70F+nu1YWqI0RAnlxAJ9+ZXryG/KJxi6hjpz+U/gU3y06MQCdH2Ez
cFlnxwWksB+q2b1dXI3cfwo=
=HAy6
-----END PGP SIGNATURE-----
