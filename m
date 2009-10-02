From: gsky <gsky51@gmail.com>
Subject: HTTP NTLM Authentication
Date: Fri, 2 Oct 2009 10:28:51 -0700 (PDT)
Message-ID: <25718488.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtlwA-0005p4-B6
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 19:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739AbZJBR2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 13:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757731AbZJBR2s
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 13:28:48 -0400
Received: from kuber.nabble.com ([216.139.236.158]:52445 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653AbZJBR2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 13:28:47 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Mtlw3-0004nW-UX
	for git@vger.kernel.org; Fri, 02 Oct 2009 10:28:51 -0700
X-Nabble-From: gsky51@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129451>


Is is possible for me to pass arguments to the curl calls that git uses to
access a repository hosted over HTTP?

I am having a problem accessing the repository as it is authenticated using
NTLM, I can curl the repository using

curl --ntlm http://username:pass@machine.domain/git

How can I do the same for the git clone of the repository?  Is it possible
easily, or do I have to modify the source and recompile?

gsky
-- 
View this message in context: http://www.nabble.com/HTTP-NTLM-Authentication-tp25718488p25718488.html
Sent from the git mailing list archive at Nabble.com.
