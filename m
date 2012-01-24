From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Most reliable method to detect a merge commit in pre-commit hook
Date: Tue, 24 Jan 2012 15:16:40 +0100
Message-ID: <jfmegi$scg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 15:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RphBP-0002PS-TW
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 15:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab2AXORH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 09:17:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:51779 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055Ab2AXORF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 09:17:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RphBH-0002LO-BD
	for git@vger.kernel.org; Tue, 24 Jan 2012 15:17:03 +0100
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 15:17:03 +0100
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 15:17:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189047>

Hi,

I'd like our pre-commit hook to skip some checks if the commit that's 
about to be made is a merge commit. What's the most reliable way to 
detect a merge commit from within a pre-commit hook script? Currently, 
the only way I see is to check whether .git/MERGE_MSG exists, but I'd 
feel safer to check whether the commit is going to have more than one 
parent or so. Is that possible / a better detection?

-- 
Sebastian Schuberth
