From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 19:07:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>  <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com>  <20090813144327.GK1033@spearce.org> <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302>
  <20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com>  <20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbdm2-0000Gt-Cd
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZHMRH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZHMRH0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:07:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:35565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbZHMRH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:07:26 -0400
Received: (qmail invoked by alias); 13 Aug 2009 17:07:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 13 Aug 2009 19:07:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+64eMqBY+6yR3CBBlXwFr7CPAyWWGDDPO/iXUYgl
	cl++TRj+SQ/eye
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125839>

Hi,

On Thu, 13 Aug 2009, Sverre Rabbelier wrote:

> On Thu, Aug 13, 2009 at 08:24, Shawn O. Pearce<spearce@spearce.org> 
> wrote:
> > Why shouldn't I be able to (easily) override the marks location 
> > locally, without resorting to stream editing?
> 
> You convinced me, I'll store argv and argc in global_argv/global_argc
> and move the option parsing to parse_argv(), which is then called when
> the first non_option command is parsed.

... and will import the marks twice?

Ciao,
Dscho
