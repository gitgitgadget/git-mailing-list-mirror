From: Pierre-Marc Fournier <pierre-marc.fournier@polymtl.ca>
Subject: git-am -p fails with new file
Date: Fri, 24 Jul 2009 14:09:30 -0400
Message-ID: <4A69F8DA.9060406@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 20:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPRw-0008Vl-8U
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbZGXSYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 14:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZGXSYs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:24:48 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:50041 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbZGXSYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 14:24:47 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2009 14:24:47 EDT
Received: from [132.207.228.212] (clnt01-228-212.vpn.polymtl.ca [132.207.228.212])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id n6OI9ZV8020734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 24 Jul 2009 14:09:35 -0400
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
X-Enigmail-Version: 0.95.0
X-Poly-FromMTA: (clnt01-228-212.vpn.polymtl.ca [132.207.228.212]) at Fri, 24 Jul 2009 18:09:35 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123940>

I have a patch generated with git format-patch. I am trying to apply it
in a repository that contains only a subdirectory of the original
repository.

Therefore, I need to use git-am -p, which fails with the following message.

fatal: git apply: bad git-diff - inconsistent new filename on line 33

Is there a code path missing in parse_git_header() to strip the
directories as requested by -p?

Please CC me. Thanks.

pmf
