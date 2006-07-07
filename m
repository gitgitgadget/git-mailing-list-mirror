From: Michal Ludvig <michal@logix.cz>
Subject: fatal: ambiguous argument '': unknown revision or path not in the
 working tree.
Date: Fri, 07 Jul 2006 23:52:34 +1200
Message-ID: <44AE4B02.2050408@logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 07 13:53:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyosz-00046q-U7
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWGGLw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWGGLwZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:52:25 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:31667 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S932136AbWGGLwY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 07:52:24 -0400
Received: from [192.168.159.6] (unknown [192.168.159.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by maxipes.logix.cz (Postfix) with ESMTP id 52543BCC26
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 13:52:20 +0200 (CEST)
User-Agent: Thunderbird 1.5 (X11/20060317)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23433>

Hi all,

I'm getting this error from most cogito commands in my repository
(created with cg-init):

===
$ cg status
Heads:
   >master      66ef937771695c865e38ff7227c077d9260759ce

? patches/series
fatal: ambiguous argument '': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
===

I already have some commits and history in there that I'd prefer not to
loose. When I clone this repository the error disappears but I'd prefer
to fix it in place.

Any ideas?

Using cogito-0.17 and git-1.4.0

Thanks

Michal
