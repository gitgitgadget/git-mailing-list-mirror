From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] Add git-bundle - pack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 14:44:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702161443370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7238711.2657861171629916957.JavaMail.root@vms064.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 14:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI3Oi-0002nr-11
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 14:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXBPNo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 08:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXBPNo5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 08:44:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:57455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964920AbXBPNo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 08:44:56 -0500
Received: (qmail invoked by alias); 16 Feb 2007 13:44:53 -0000
X-Provags-ID: V01U2FsdGVkX1/IisVf+MjIAnfqF3qtGDOdzGFOIFUHTbgv+dbQZw
	jfTg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7238711.2657861171629916957.JavaMail.root@vms064.mailsrvcs.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39913>

Hi,

On Fri, 16 Feb 2007, Mark Levedahl wrote:

> ... I *tried* that, and it fails under Cygwin. Apparently cygwin's bash 
> (or something) mangles data in the pipe (99% certain it will turn out to 
> be a latent crlf issue)...

Have you tried

	export CYGWIN=binmode

before that? (If it works, you have to make sure that other settings as 
"ntsec" are retained in that environment variable, but not "nobinmode").

Hth,
Dscho
