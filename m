From: "D. A. van Delft" <davd@bart.nl>
Subject: spurious fail of git merge after rebasing
Date: Sat, 16 Apr 2011 00:45:12 +0200
Message-ID: <201104160045.12633.davd@bart.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAsKX-0001KC-G4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 01:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1DOXVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 19:21:32 -0400
Received: from claranetnl-outbound-smtp04.mail.eu.clara.net ([195.8.64.69]:35205
	"EHLO claranetnl-outbound-smtp04.mail.eu.clara.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926Ab1DOXVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 19:21:31 -0400
X-Greylist: delayed 2176 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Apr 2011 19:21:31 EDT
Received: from dsl-235-27541.iae.nl ([212.61.235.109]:10981 helo=tilia.localnet)
	by relay04.mail.eu.clara.net (smtp-vh.nl.clara.net [213.253.3.44]:2025)
	with esmtp id 1QArlJ-0001Rs-DF  for git@vger.kernel.org
	(return-path <davd@bart.nl>); Fri, 15 Apr 2011 22:45:13 +0000
User-Agent: KMail/1.13.5 (Linux/2.6.34.7-0.7-default; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171647>

Hi,

not sure if this is the right place, but I couldn't find a 
bugzilla or something for git.

Point is, I have found a scenario where sometimes git fails on 
a specific merge.
Each time I start with the same identical git repository 
(archived once and restored each time before a run) and run 
the same fixed series of rebases and merges on it. Once in a 
while it fails with a merge conflict, sometimes at first try, 
sometimes after 10+ times. I have a canned set of testcases 
which reproduces this behaviour. I have also narrowed it down 
somewhat on how to work around, or prevent it from occurring. 

However, given that it doesn't always fail or succeed, is 
unexpected.

regards,
Danny A. van Delft
