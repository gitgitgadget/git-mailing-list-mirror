From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git objects directory
Date: Mon, 31 Oct 2005 17:08:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0510311707001.5839@wbgn013.biozentrum.uni-wuerzburg.de>
References: <dk5dgq$isv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 17:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWcCx-0004eY-2y
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 17:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVJaQIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJaQIX
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 11:08:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39912 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932385AbVJaQIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 11:08:22 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5162613EBA5; Mon, 31 Oct 2005 17:08:19 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3393AB4F24; Mon, 31 Oct 2005 17:08:19 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1839DB4F22; Mon, 31 Oct 2005 17:08:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BAF2313EBC2; Mon, 31 Oct 2005 17:08:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Lexington Luthor <Lexington.Luthor@gmail.com>
In-Reply-To: <dk5dgq$isv$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10862>

Hi,

On Mon, 31 Oct 2005, Lexington Luthor wrote:

> Can someone please explain why git puts its objects in 256 
> sub-directories of objects instead of directly in the objects directory 
> itself?

Some filesystems have problems with huge directories. And originally the 
plan was to have all objects as files (now the older ones live in packs).

Hth,
Dscho
