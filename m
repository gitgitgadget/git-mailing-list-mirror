From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 02:26:29 +0000 (UTC)
Organization: disorganised!
Message-ID: <gi1qsl$22p$1@ger.gmane.org>
References: <200812090956.48613.thomas@koch.ro>
 <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
 <87hc58hwmi.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 03:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBgle-0007Dy-6k
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 03:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbYLNCaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 21:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYLNCaG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 21:30:06 -0500
Received: from main.gmane.org ([80.91.229.2]:51128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbYLNCaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 21:30:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LBgk6-00051y-D2
	for git@vger.kernel.org; Sun, 14 Dec 2008 02:30:02 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 02:30:02 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 02:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103045>

On 2008-12-13, Nix <nix@esperi.org.uk> wrote:
> telnet. I do not jest, this is our sysadmins' stated reasons for not
> opening the git port and for tweaking their (mandatory) HTTP proxy to
> block HTTP traffic from git.

Wow -- my sympathies!

But on occasion, when real or imaginary issues prevented me
from making a live connection, I have used "git bundle" to
do the job.  Not as satisfactory as a real connection, but
when you have a proper, non-fast-forwarding, repo as the
"mother ship", git bundle with some custom procmail scripts
on both sides can work OK enough.

To do that with a public repo you'd have to mirror that on a
home machine and let your restricted environment work
against that.

> Do not underestimate the stupidity and hideboundedness of undertrained
> system administrators, for it is vast.

These same administrators also underestimate (i) the number
of well connected home machines and (ii) the idea that on
his own machine, everyone is root.

Most of these blocks are "default allow", and your home IP
is not on that list and they don't have the smarts to figure
out that you're getting around their blocks :-) Add dynamic
IP and a dyndns hostname (and dyndns has a hundred or so 2nd
level domains to choose your 3rd level hostname from!) and
clueless admins don't stand a chance.

[sorry this is so badly off-topic...]
