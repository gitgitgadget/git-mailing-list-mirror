From: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
Subject: Re: releasing your work
Date: Thu, 16 Apr 2009 08:46:02 +0200
Message-ID: <20090416064602.GA3668@lars.home.noschinski.de>
References: <49E6B9E3.30707@wallcann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lucas Sandery <lucas@wallcann.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 08:54:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuLTY-00011X-8S
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 08:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbZDPGv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 02:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZDPGv6
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 02:51:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:49316 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbZDPGv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 02:51:57 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2009 02:51:57 EDT
Received: from [87.78.95.207] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-2@usenet.noschinski.de>)
	id 1LuLMJ-00047B-Gh; Thu, 16 Apr 2009 08:46:03 +0200
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-2@usenet.noschinski.de>)
	id 1LuLMI-0000yj-N4; Thu, 16 Apr 2009 08:46:02 +0200
Content-Disposition: inline
In-Reply-To: <49E6B9E3.30707@wallcann.com>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116673>

* Lucas Sandery <lucas@wallcann.com> [09-04-16 06:53]:
> How do I make a "release" a copy (not a clone) of the repository that contains 
> only tracked files without .gitignore files? I am using git archive but the 
> resulting zip file still contains .gitignore files.

Have a look at the git-archive man page. You can exclude such files by
adding the export-ignore attribute to gitattributes.
