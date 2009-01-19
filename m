From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] shortlog: add option to group together different
 names/emails of an author
Date: Mon, 19 Jan 2009 14:49:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191445340.3586@pacific.mpi-cbg.de>
References: <1231600589-11811-1-git-send-email-dato@net.com.org.es> <20090119134346.GA27509@chistera.yi.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-419010029-1232372980=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Mon Jan 19 14:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOuWs-0006Pg-Eo
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 14:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZASNti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 08:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZASNti
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 08:49:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:33964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750854AbZASNth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 08:49:37 -0500
Received: (qmail invoked by alias); 19 Jan 2009 13:49:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 19 Jan 2009 14:49:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4cHdv2qi4kA88fH7o+GBMpsAiqh6jUMwY4+gX//
	lQMMeuwJ2VGJ5x
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090119134346.GA27509@chistera.yi.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106359>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-419010029-1232372980=:3586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 19 Jan 2009, Adeodato Simó wrote:

> Ping? I realize this may be seen as a big patch dropped out of the blue,
> but I would very much like to hear some comments on at least the feature
> itself, which should not take more than reading the commit message.

This is such a huge change, for something that not many people want.  
Actually, you seem to be the first.

And you could just as well write a script that takes the output of

	$ git log --pretty=format:%an\ %ae --all | sort | uniq

and constructs a valid .mailmap.  That would also have the advantage that 
you do not need to perform the analysis each time you call Git.

All these reasons make me believe that your patch should not be applied.

Sorry,
Dscho

--8323328-419010029-1232372980=:3586--
