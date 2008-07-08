From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH] bash: offer only paths after '--'
Date: Tue, 8 Jul 2008 17:46:08 +0000 (UTC)
Message-ID: <loom.20080708T174319-960@post.gmane.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com> <20080708044922.GD2542@spearce.org> <7vprppvt7a.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness> <20080708165614.GB8224@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 19:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGHHd-0006fj-N4
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYGHRqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 13:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYGHRqY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:46:24 -0400
Received: from main.gmane.org ([80.91.229.2]:60028 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbYGHRqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 13:46:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGHGc-0002EK-7N
	for git@vger.kernel.org; Tue, 08 Jul 2008 17:46:18 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 17:46:18 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 17:46:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87779>

SZEDER G=C3=A1bor <szeder <at> ira.uka.de> writes:

>=20
> Many git commands use '--' to separate subcommands, options, and refs
> from paths.  However, the programmable completion for several of thes=
e
> commands does not respect the '--', and offer subcommands, options, o=
r
> refs after a '--', although only paths are permitted.  e.g. 'git bise=
ct

I like this change, but how about also offering a plain '--' as one
of the completion choices as a way of reminding newbies that the
command in question is one of the ones that takes filenames after
all options?
