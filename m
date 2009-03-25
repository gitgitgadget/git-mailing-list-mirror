From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
  right after init
Date: Wed, 25 Mar 2009 13:38:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903251338130.26370@intel-tinevez-2-302>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <adf1fd3d0903250456l3c14a863pd6ee00c0025100c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-467259834-1237984711=:26370"
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 13:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmSPH-00021f-PZ
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 13:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbZCYMih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 08:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754674AbZCYMih
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 08:38:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:47672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754482AbZCYMig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 08:38:36 -0400
Received: (qmail invoked by alias); 25 Mar 2009 12:38:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp042) with SMTP; 25 Mar 2009 13:38:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VybZQ/HrVOUWa0RFvltg7b3dNwrwtkcM4bTwlS5
	gO6glIIUTPflx0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <adf1fd3d0903250456l3c14a863pd6ee00c0025100c4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114598>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-467259834-1237984711=:26370
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 25 Mar 2009, Santi Béjar wrote:

> 2009/3/25 Nguyễn Thái Ngọc Duy <pclouds@gmail.com>:
> > +-m <message>::
> > +--import <message>::
> > +
> > +Commit everything to the newly initialized repository. This is equivalent to:
> > +
> > +----------------
> > +$ git init
> > +$ git add .
> > +$ git commit -q -m <message>
> > +----------------
> > +
> > +If no message is given, "Initial commit" will be used.
> 
> Why a default message and not running the editor?

Because I would say "Initial commit" anyway.

Ciao,
Dscho

--8323329-467259834-1237984711=:26370--
