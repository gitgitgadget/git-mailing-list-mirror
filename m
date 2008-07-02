From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/12] verify_path(): do not allow absolute paths
Date: Wed, 2 Jul 2008 17:15:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021713290.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de>
 <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de> <7vvdzobq0k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: prohaska@zib.de, Johannes Sixt <johannes.sixt@telecom.at>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE52E-0002Y8-C9
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 18:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbYGBQRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 12:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbYGBQRY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 12:17:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:59980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754413AbYGBQRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 12:17:23 -0400
Received: (qmail invoked by alias); 02 Jul 2008 16:17:21 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp019) with SMTP; 02 Jul 2008 18:17:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UVuRc5OFUdsQejjAdwKuZltIOAzth7S6O4UWyVl
	cn5PZWPHJy2ohF
X-X-Sender: gene099@racer
In-Reply-To: <7vvdzobq0k.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87154>

Hi,

On Wed, 2 Jul 2008, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> 
> No commit log message?  Justification?

Justification: adding absolute paths was not caught properly on Windows, 
and this was the easiest patch.

However, IIRC, in the meantime we are nice to the user, and allow absolute 
paths (which we turn into a relative path, or error out if it is not under 
the current working directory).

Steffen, can you revert the patch and verify that my memory does not fail 
me?

Ciao,
Dscho
