From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] http*: cleanup slot->local after fclose
Date: Sat, 30 May 2009 18:58:07 +0200
Message-ID: <20090530165807.GA10132@localhost>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost> <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com> <20090530093717.GA22129@localhost> <be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com> <20090530230153.527532b0.rctay89@gmail.com> <20090531000955.953725d9.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 18:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MARsx-0006gv-T2
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 18:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760147AbZE3Q6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 12:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760134AbZE3Q6L
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 12:58:11 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:51929 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759582AbZE3Q6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 12:58:11 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 May 2009 18:58:10 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MARsl-0002hr-9J; Sat, 30 May 2009 18:58:07 +0200
Content-Disposition: inline
In-Reply-To: <20090531000955.953725d9.rctay89@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 May 2009 16:58:12.0381 (UTC) FILETIME=[D1198CD0:01C9E147]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120360>

On Sun, May 31, 2009 at 12:09:55AM +0800, Tay Ray Chuan wrote:
> Set slot->local to NULL after doing a fclose on the FILE* pointer it
> points to.

Thanks. That fixes it.

Clemens
