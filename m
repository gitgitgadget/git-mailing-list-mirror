From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-tag.c: allow arguments in $EDITOR
Date: Thu, 20 Dec 2007 12:58:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071219232326.GA4135@bit.office.eurotux.com>
 <20071220095706.GA9685@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 12:59:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5K3j-0005GO-Kz
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 12:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbXLTL7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 06:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXLTL7D
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 06:59:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:44272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752082AbXLTL7B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 06:59:01 -0500
Received: (qmail invoked by alias); 20 Dec 2007 11:58:59 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp054) with SMTP; 20 Dec 2007 12:58:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KsZcr/koKNdjku71WPcFfkaJ2wevYlBWCiX2UIs
	gGjJZVdX/p47Bd
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071220095706.GA9685@bit.office.eurotux.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68994>

Hi,

On Thu, 20 Dec 2007, Luciano Rocha wrote:

> The previous sh version of git-commit evaluated the value of the defined 
> editor, thus allowing arguments.
> 
> Make the builtin version work the same, by adding an explicit check for 
> arguments in the editor command, and extract them to an additional 
> argument.

Anything wrong with that patch?

http://article.gmane.org/gmane.comp.version-control.git/68444

Ciao,
Dscho
