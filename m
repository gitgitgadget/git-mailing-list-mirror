From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Thu, 1 Mar 2007 23:46:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es66vt$jej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMu2i-00046e-4v
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbXCAWq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbXCAWq3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:46:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:60489 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161078AbXCAWq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:46:28 -0500
Received: (qmail invoked by alias); 01 Mar 2007 22:46:27 -0000
X-Provags-ID: V01U2FsdGVkX18/wvdAvmg/UngepNjm1i17+p078fqiBHG1BkYeGA
	0by0lFUxGqyVah
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <es66vt$jej$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41141>

Hi,

On Thu, 1 Mar 2007, Paolo Bonzini wrote:

> As per the subject.  The existing --rename-section option is 
> undocumented, while --remove-section is added by this patch based on the 
> code I had written for the "git branch" patch.

Am I right assuming that you copied rename_section(), and modified it to 
be remove_section()?

How about modifying rename_section() so that if new_name == NULL, it 
removes the section?

But I like the way you extracted section_name_match(). Makes the code much 
more readable.

Ciao,
Dscho
