From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Publishing on a simple HTTP server
Date: Tue, 13 Feb 2007 00:11:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <14870.1171311025@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:12:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkLC-0008FP-2X
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbXBLXLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbXBLXLn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:11:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:53256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030469AbXBLXLY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:11:24 -0500
Received: (qmail invoked by alias); 12 Feb 2007 23:11:22 -0000
X-Provags-ID: V01U2FsdGVkX1+1b0cnQda1pzu2wZhEsRqp8NAOy209sZvIw0VzAm
	MlYg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <14870.1171311025@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39452>

Hi,

On Mon, 12 Feb 2007, Xavier Maillard wrote:

> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

How did you upload?

Basically, the best way really is to follow 
Documentation/howto/setup-git-server-over-http.txt. Having said that, you 
can run git-update-server-info locally, and copy .git/info/refs to the 
webserver.

HOWEVER, most likely you have to adjust the permissions on the webserver 
afterwards. As I said, the easiest way is to follow the docs (which boils 
down to do even the initial push using git).

Hth,
Dscho
