From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 13:29:44 +0200
Message-ID: <4A44B128.6040800@viscovery.net>
References: <C66A69E6.205F2%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 13:30:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK9d7-0005Qq-1m
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 13:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbZFZL3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 07:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbZFZL3w
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 07:29:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53611 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbZFZL3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 07:29:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MK9cm-0003tm-FG; Fri, 26 Jun 2009 13:29:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 30B224E4; Fri, 26 Jun 2009 13:29:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <C66A69E6.205F2%jefferis@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122293>

Gregory Jefferis schrieb:
> http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/contrib/diff-scripts/
> 
> diff-doc.js
> merge-doc.js
> 
> Perhaps tortoisegit already exposes this.  Those scripts include fallbacks
> for openoffice so I suppose one could use that on linux.

Thanks a lot for the pointer.

The interesting one is merge-doc.js. Unfortunately, it still only just
compares "their" and "our" versions, and the user must go through all
marked changes and reject everything that would undo "our" changes and
accept all "their" changes. That's exactly what I already do. :-(

That said, the scripts are written *much* nicer than what I have written
myself.

-- Hannes
