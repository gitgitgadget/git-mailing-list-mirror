From: Lachlan Patrick <loki@research.canon.com.au>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 16:02:47 +1000
Message-ID: <453DAC87.8050203@research.canon.com.au>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>	<200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 08:03:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcFNO-0004D6-HD
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWJXGCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 02:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbWJXGCv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:02:51 -0400
Received: from a.ns.cisra.com.au ([203.12.173.51]:49150 "EHLO
	ebenezer.cisra.com.au") by vger.kernel.org with ESMTP
	id S1752078AbWJXGCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 02:02:51 -0400
Received: from jaroslav.research.canon.com.au (edge-aide.cisra.com.au [203.12.173.254])
	by ebenezer.cisra.com.au (Postfix) with ESMTP id 82B16222418;
	Tue, 24 Oct 2006 06:02:48 +0000 (UTC)
Received: from [10.2.8.174] (HASPRE.research.canon.com.au [10.2.8.174])
	by jaroslav.research.canon.com.au (Postfix) with ESMTP id 728FF5C03E;
	Tue, 24 Oct 2006 06:02:48 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
To: bazaar-ng@lists.canonical.com, git@vger.kernel.org
In-Reply-To: <vpq4ptz2uh8.fsf@ecrins.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29929>

Matthieu Moy wrote:
> Sean <seanlkml@sympatico.ca> writes:
>> We don't need plugins to extend features, we just add the feature to
>> the source.  The example I asked about earlier is a case in point. 
>> Apparently in bzr "bisect" was implemented as a plugin, yet in Git it
>> was implemented as a command without any issue at all,
> 
> I'd compare bzr's plugins to Firefox extensions.

So, bzr's plug-in architecture provides a 'protocol' for communicating
with bzr? Or is it functionally the same as a Python module which is
loaded after being named on the bzr command-line (or placed in a special
folder) then executed along with all the other plug-ins? I'm trying to
understand if writing a plug-in is any simpler than understanding the
bzr source code.

Can I ask the git folks what Sean meant in the above about a 'command'.
Are you talking about shell scripts? Is 'git' the only program you need?

AFAIK, 'bzr' is the sole program in Bazaar, and everything is done with
command line options to bzr. Is that true of git? To what extent is git
tied to a [programmable] shell? I've heard someone say there's no
Windows version of git for some reason, can someone elaborate?

Ta,
Loki
