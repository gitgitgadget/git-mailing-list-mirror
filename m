From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recur: if there is no common ancestor, fake empty
 one
Date: Wed, 9 Aug 2006 19:44:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091943570.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608091842210.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 19:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAs6s-0004gk-Cq
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 19:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWHIRol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 13:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWHIRol
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 13:44:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:33419 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751268AbWHIRok (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 13:44:40 -0400
Received: (qmail invoked by alias); 09 Aug 2006 17:44:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 09 Aug 2006 19:44:38 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0608091842210.1800@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25130>

Hi,

On Wed, 9 Aug 2006, Johannes Schindelin wrote:

> +		*write_sha1_file_prepare(NULL, 0, tree_type, &tree->object.sha1,

... make this "tree->object.sha1" _without_ a "&", of course.

Ciao,
Dscho
