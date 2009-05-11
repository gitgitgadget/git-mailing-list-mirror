From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Add core.autocrlf=true on cygwin by default during
 tests
Date: Mon, 11 May 2009 22:54:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905112253580.27348@pacific.mpi-cbg.de>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Mon May 11 22:55:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3cWb-0008KY-0r
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 22:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbZEKUyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 16:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbZEKUyw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 16:54:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:58319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751914AbZEKUyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 16:54:52 -0400
Received: (qmail invoked by alias); 11 May 2009 20:54:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 11 May 2009 22:54:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uuD9nFA8uWFMkVqAlRXF9FDe8UHUzx4x6lSkKFP
	N9hvJ2/erRIAph
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118845>

Hi,

On Mon, 11 May 2009, Don Slutz wrote:

> This is a patch set to do the work from mail message:
> 
> http://kerneltrap.org/mailarchive/git/2007/8/7/254415
> 
> It is split into 6 parts.  This is because the tests do not work on
> Linux if autocrlf=true.
> 
> 1) The change to autocrlf=true by default for cygwin

>From the fallout of our unilateral decision in msysGit to set 
autoCRLF=true all the time, I would advise against this change.

Ciao,
Dscho
