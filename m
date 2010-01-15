From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 18:12:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001151811270.3106@intel-tinevez-2-302>
References: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi> <vpqy6jzuwpv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:15:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVpjI-00070A-Tl
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 18:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab0AORMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 12:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757852Ab0AORMp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 12:12:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:49980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754797Ab0AORMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 12:12:44 -0500
Received: (qmail invoked by alias); 15 Jan 2010 17:12:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 15 Jan 2010 18:12:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o8A4H8RDoPDXBz6TH2TEL+Np4TAk3YH2zC1jroA
	Lc9Rc1gTWuxE/o
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <vpqy6jzuwpv.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137084>

Hi,

On Fri, 15 Jan 2010, Matthieu Moy wrote:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > +		OPT_BIT('u', "set-upstream", &flags, "Set upstream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),
> 
> I'd be in favor of --track for the option name. Not that it's the best
> name ever, but this is really doing the same job as branch --track and
> checkout --track, so it should have the same name.
> 
> Or the --track option of branch and checkout should be renamed as
> --set-upstream, but that seems a lot of trouble for little benefit.

Junio already complained that it is a bad name, basically because it is 
ambiguous.  If you are really pushing for --track, you will have to think 
of a compelling reasoning.

Ciao,
Dscho

P.S.: FWIW I think --set-upstream is really a good name.
