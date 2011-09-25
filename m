From: Avi Kivity <avi@redhat.com>
Subject: Symbolic refs and the git protocol?
Date: Sun, 25 Sep 2011 16:17:31 +0300
Message-ID: <4E7F29EB.8000800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 15:17:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7oaR-00008f-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 15:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab1IYNRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 09:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527Ab1IYNRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 09:17:34 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8PDHXPB004882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 25 Sep 2011 09:17:33 -0400
Received: from balrog.usersys.redhat.com (dhcp-1-24.tlv.redhat.com [10.35.1.24])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p8PDHW8M013550;
	Sun, 25 Sep 2011 09:17:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182067>

With the old kernel.org setup, practically the only think I needed to do 
on the server itself is the 'git symbolic-ref' command (used to point 
refs/heads/linux-next at the correct stream).

Now it looks like kernel.org will no longer offer shell access.  Is it 
possible to support symbolic-ref via 'git push'?

-- 
error compiling committee.c: too many arguments to function
