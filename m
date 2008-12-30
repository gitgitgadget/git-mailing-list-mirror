From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-shortlog.c: use string_list_append() instead of
 duplicating its code
Date: Tue, 30 Dec 2008 13:20:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812301319140.30769@pacific.mpi-cbg.de>
References: <1230136476-11081-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1790776328-1230639619=:30769"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Tue Dec 30 13:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdaf-0008Bz-Ll
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYL3MTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYL3MTe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:19:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:52123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbYL3MTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:19:34 -0500
Received: (qmail invoked by alias); 30 Dec 2008 12:19:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 30 Dec 2008 13:19:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SpD1zWflSXODDnN8J+kxtJIYUFNG5SgtANRyTqf
	aINFeYe2NUU/xg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1230136476-11081-1-git-send-email-dato@net.com.org.es>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104177>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1790776328-1230639619=:30769
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 24 Dec 2008, Adeodato Simó wrote:

> Also, when clearing the "onelines" string lists, do not free the "util"
> member: with string_list_append() is not initialized to any value (and
> was being initialized to NULL previously anyway).
> 
> NB: The duplicated code in builtin-shortlog.c predated the appearance of
> string_list_append().
> 
> Signed-off-by: Adeodato Simó <dato@net.com.org.es>

FWIW I like the patch, but would like it even more if the strdup() removal 
was squashed in (with an explanation in the commit message).

Ciao,
Dscho
--8323328-1790776328-1230639619=:30769--
