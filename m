From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 10:50:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info> <xmqqtx0n710m.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
 <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 10:51:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3M7I-0007KE-GA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 10:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaLWJu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 04:50:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:52849 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbaLWJuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 04:50:55 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lz3rc-1XqJII3ioy-0148kM;
 Tue, 23 Dec 2014 10:50:50 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:qXcsjEr1LeOLtZgLpl+i/1GOx870n3MPqKTJ1reey3DQfkPUsVP
 cgHnpLGjBVb+T8XbL2KArcjzk396sghsEWxpNgrhQnqEYPl44paulBh+tzXfOyyPCAIC3Ts
 iAq3CXrEcms4WEJzNalJuSDuApsG5n18OaztsUMrTL91fKbiQCXUoP5rTze4JsCLFHbZZnA
 btLHK1li0rDbWo+Zb97Eg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261722>

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 22 Dec 2014, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > Of course you can say that! ;-) The problem these ugly messages try to
> >> > solve is to give the user a hint which setting to change if they want to
> >> > override the default behavior, though...
> >> 
> >> Ahh, OK, then dashed form would not work as a configuration variable
> >> names, so missingTaggerEntry would be the only usable option.
> >
> > Except that cunning me has made it so that both missing-tagger-entry *and*
> > missingTaggerEntry work...
> 
> Then the missing-tagger-entry side needs to be dropped.  The naming
> does not conform to the way how we name our officially supported
> configuration variables.

But it does conform with the way we do our command-line parameters, and it
would actually cause *more* work (and more complicated code) to have two
separate parsers, or even to force the parser to accept only one way to
specify settings...

Should I really introduce more complexity just to disallow non-camelCased
config variables?

Ciao,
Dscho
