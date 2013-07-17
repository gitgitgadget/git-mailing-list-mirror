From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Git counterpart to SVN bugtraq properties?
Date: Wed, 17 Jul 2013 15:03:14 +0200
Message-ID: <51E69612.6020201@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 15:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzRUj-0002Pg-1A
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 15:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab3GQNKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 09:10:07 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:52843 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab3GQNKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 09:10:06 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2013 09:10:06 EDT
Received: from [91.113.179.170] (helo=[192.168.92.3])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1UzRO0-0004VH-4o
	for git@vger.kernel.org; Wed, 17 Jul 2013 15:03:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-Enigmail-Version: 1.5.1
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230621>

I'm looking for a specification or guidelines on how a Git client should
integrate with bug tracking systems. For SVN, one can use
bugtraq-properties [1] to specify e.g. the issue tracker URL or how to
parse the bug ID from a commit message. AFAIU, there is nothing
comparable for Git [2]? If that's actually the case, is someone
interested in working out a similar specification for Git?

[1]
http://code.google.com/p/tortoisesvn/source/browse/tags/version_1.2.0/doc/issuetrackers.txt

[2] http://stackoverflow.com/questions/17545548

-Marc
