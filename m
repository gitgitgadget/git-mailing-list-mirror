From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Tue, 05 Feb 2008 17:01:52 +0200
Organization: Private
Message-ID: <zlufxx9b.fsf@blue.sea.net>
References: <pan.2008.02.04.18.25.26@progsoc.org>
	<20080205050741.GA4624@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 16:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPKw-0007t4-D2
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbYBEPCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYBEPCv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:02:51 -0500
Received: from main.gmane.org ([80.91.229.2]:41604 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbYBEPCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:02:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMPJt-0002Z6-Pe
	for git@vger.kernel.org; Tue, 05 Feb 2008 15:02:45 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 15:02:45 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 15:02:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:D8h5OpionrvDADfVDoHaT92arRc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72664>

* Tue 2008-02-05 Jeff King <peff@peff.net> gmane.comp.version-control.git
* Message-Id: 20080205050741.GA4624@coredump.intra.peff.net
> On Mon, Feb 04, 2008 at 06:25:25PM +0000, Anand Kumria wrote:
> That being said, there seems to be some difference between 1.5.3.8 and
> 1.5.4 that made us care more about SSL certs (though I note that the
> SSL_VERIFYPEER curl knob has been set since pre-1.0). Have you tried
> setting GIT_SSL_NO_VERIFY?

Confirmed. The "git push" returned failure, but when compiled with this
options, it works ok.

    $ uname -a
    SunOS 5.9 Generic_118558-35 sun4u sparc SUNW,Serverblade1

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
