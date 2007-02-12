From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: add negative -p to git-am, Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 12:51:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121250270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vvei89b9k.fsf@assigned-by-dhcp.cox.net> <20070212055903.GD28231@mellanox.co.il>
 <20070212062529.GE28231@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:52:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZj9-00051K-3E
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbXBLLwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbXBLLwA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:52:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:36539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964884AbXBLLv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:51:59 -0500
Received: (qmail invoked by alias); 12 Feb 2007 11:51:58 -0000
X-Provags-ID: V01U2FsdGVkX18JYjdU1TAJcu8+elLVqz/HHuRfVsk3GgeWnD7Kx9
	6APg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070212062529.GE28231@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39396>

Hi,

On Mon, 12 Feb 2007, Michael S. Tsirkin wrote:

> Make git-am support "negative strip-level" patches by running it in a 
> subdirectory.

I'd rather hide this behind a command line switch to git-am, since it _is_ 
a feature that you do not have to cd to the repo root when git-am'ing 
correct patches.

Ciao,
Dscho
