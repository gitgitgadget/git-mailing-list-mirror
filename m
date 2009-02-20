From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Fri, 20 Feb 2009 18:26:54 -0300
Organization: DATACOM
Message-ID: <499F201E.2050106@datacom.ind.br>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu> <20090220062543.GA27837@coredump.intra.peff.net> <499E8432.9010806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 20 22:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lacv9-0000L7-FO
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 22:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbZBTV1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 16:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZBTV1D
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 16:27:03 -0500
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:51955 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086AbZBTV1B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 16:27:01 -0500
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 709892ACD1; Fri, 20 Feb 2009 18:26:55 -0300 (BRT)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 20E842ACCF;
	Fri, 20 Feb 2009 18:26:55 -0300 (BRT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <499E8432.9010806@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110891>

Michael Haggerty wrote:
> BTW, I don't want to trash "git cvsimport".  I'm not brave enough even
> to try to implement incremental conversions in cvs2git.  So the fact

Michael,

If I run cvs2git several times against a live cvs repo (using the same configuration), wouldn't it perform an incremental import?
Is there anything that would make it produce different commits for the history?

I've just made a simple test here performing 2 imports (the 2nd with a dozen of new commits not in the 1st) and it seemed to work fine.

I know that it will take the same time/memory as the first import, but is there something that can break the repository or produce wrong data?

Thanks,

 - Samuel
