From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Error.pm leaking
Date: Tue, 27 Feb 2007 14:32:54 -0800
Message-ID: <86zm6znsdl.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 23:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAsV-0007eJ-Fz
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbXB0Wc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXB0Wc4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:32:56 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:42657 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbXB0Wcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:32:55 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E5C421DEE9E; Tue, 27 Feb 2007 14:32:54 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.16; tzolkin = 12 Cib; haab = 9 Kayab
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40827>


There was a thread a while back about why I said not to use Error.pm, because
it could leak, and I failed to provide proof.  Found it, finally!

<http://perl.apache.org/docs/tutorials/apps/scale_etoys/etoys.html>

Nested try blocks, it seems.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
