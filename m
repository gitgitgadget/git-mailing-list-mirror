From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Thu, 5 Jun 2008 14:35:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051433590.21190@racer>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl> <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Feg-0007bu-OP
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbYFENge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYFENge
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:36:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:34195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754006AbYFENgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:36:33 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:36:31 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp008) with SMTP; 05 Jun 2008 15:36:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4dnlfirD4PjUS5spctW2g5RllZkl87yAvz50g68
	gm145/HE4jVlby
X-X-Sender: gene099@racer
In-Reply-To: <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83930>

Hi,

On Thu, 5 Jun 2008, Pieter de Bie wrote:

> This adds the --import-marks and --export-marks to fast-export. These 
> import and export the marks used to for all revisions exported in a 
> similar fashion to what fast-import does. The format is the same as 
> fast-import, so you can create a bidirectional importer / exporter by 
> using the same marks file on both sides.

Nicely done.  As I said, I would like the pointer magic to be wrapped in a 
function so that this programmer does not get confused by it again, but 
it's not that important.  IOW only do it if you agree strongly.

Other than that, ACK.

Ciao,
Dscho
