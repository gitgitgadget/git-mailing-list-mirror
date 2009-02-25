From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bug in Git-Gui - Creates corrupt patch
Date: Wed, 25 Feb 2009 16:46:17 +0100
Message-ID: <49A567C9.5050203@viscovery.net>
References: <20090225090322.301cdb77@family.dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: 4jxDQ6FQee2H@dyweni.com
X-From: git-owner@vger.kernel.org Wed Feb 25 16:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcLzG-0001sy-77
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 16:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340AbZBYPqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 10:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbZBYPqY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 10:46:24 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33048 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbZBYPqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 10:46:23 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LcLxh-0004G0-VA; Wed, 25 Feb 2009 16:46:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9E6C7A865; Wed, 25 Feb 2009 16:46:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090225090322.301cdb77@family.dyweni.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111464>

4jxDQ6FQee2H@dyweni.com schrieb:
> 3. Using git-gui, try to stage *only* the last line marked for removal
> (should be '-	}').
> 
> I get 'fatal: corrupt patch at line 22'.

"Stage/Unstage line" does not work for files that have

\ No newline at end of file

-- Hannes
