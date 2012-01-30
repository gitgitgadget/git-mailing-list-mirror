From: Michael Cook <mcook@bbn.com>
Subject: How often does git calculate SHAs?
Date: Mon, 30 Jan 2012 09:25:40 -0500
Message-ID: <4F26A864.1080702@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 15:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrse3-00012O-0R
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 15:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab2A3OzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 09:55:25 -0500
Received: from smtp.bbn.com ([128.33.1.81]:58323 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab2A3OzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 09:55:23 -0500
X-Greylist: delayed 1782 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jan 2012 09:55:23 EST
Received: from smp.bbn.com ([192.1.122.26]:63864)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <mcook@bbn.com>)
	id 1RrsAu-000EUS-Qd
	for git@vger.kernel.org; Mon, 30 Jan 2012 09:25:40 -0500
Received: from dhcp89-069-185.bbn.com ([128.89.69.185]:4171)
	by smp.bbn.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76 (FreeBSD))
	(envelope-from <mcook@bbn.com>)
	id 1RrsAu-000Nhm-MX
	for git@vger.kernel.org; Mon, 30 Jan 2012 09:25:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Authenticated-User: mcook
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189365>

How often does git actually calculate a file's SHA?

`strace git status` shows that git stat'ed many files, but opened only a 
few. So I assume git has some heuristicsbased on the stat infofor when 
to recalculate the SHAs.

Any pointers to how I could have figured this out myself from looking at 
the source code would be appreciated. Google wasn't helpful.

Michael

-- 
Michael Cook, Raytheon BBN Technologies, www.bbn.com
