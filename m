From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 2 Sep 2007 11:59:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021157120.28586@racer.site>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org> <fbdt3q$lcf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 12:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRnBL-0002hn-SP
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 12:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbXIBK7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 06:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbXIBK7v
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 06:59:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:55690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755538AbXIBK7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 06:59:50 -0400
Received: (qmail invoked by alias); 02 Sep 2007 10:59:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 02 Sep 2007 12:59:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BEuIh084BUh6iz9dA5F32uvKvEputI9UsA7mrOq
	//qmR2yvmA95Ve
X-X-Sender: gene099@racer.site
In-Reply-To: <fbdt3q$lcf$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57315>

Hi,

On Sun, 2 Sep 2007, Arkadiusz Miskiewicz wrote:

> Junio C Hamano wrote:
> 
> > The latest feature release GIT 1.5.3 is available at the usual
> > places:
> 
> Hm,
> 
> [...]
>
> *** t0001-init.sh ***
> * FAIL 1: plain
> 
>                 (
>                         unset GIT_DIR GIT_WORK_TREE &&
>                         mkdir plain &&
>                         cd plain &&
>                         git init
>                 ) &&
>                 check_config plain/.git false unset

Please try the verbose mode: cd t/ && sh t0001-init.sh -i -v.  If that 
does not show you _what_ the problem is, try "sh -x [...]".

If you still cannot find what the problem is, please tell us what platform 
you're running on, and show us the output of the "-i -v" invocation.

Ciao,
Dscho
