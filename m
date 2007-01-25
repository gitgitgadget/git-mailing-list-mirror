From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: two-way sync; from firewalled host
Date: Thu, 25 Jan 2007 13:31:25 +0200
Message-ID: <f36b08ee0701250331u10c6a608qcbbb3001a0481e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 12:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA2pG-0004hv-Jm
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 12:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXAYLb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 06:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbXAYLb1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 06:31:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:22807 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbXAYLb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 06:31:26 -0500
Received: by wr-out-0506.google.com with SMTP id i22so373429wra
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 03:31:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FK+ls4ZmzZdadPX3SEqE2nqmT7lUzNcqMTRGmIDSNEzdtwUbtCYbHHaCuxEF8sSEJsT5PlzoN4MtquikDrqVwfjhGC23CCDke83CMkw6+n/w450lGqXyIW2AiVjz+yTDbTe91EOKkjshorE48+B3hVFTLsPJzkSOpSI7Pz/Yjrg=
Received: by 10.90.79.6 with SMTP id c6mr2072717agb.1169724685748;
        Thu, 25 Jan 2007 03:31:25 -0800 (PST)
Received: by 10.90.25.9 with HTTP; Thu, 25 Jan 2007 03:31:25 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37718>

I have two hosts, host C which is firewalled (no sshd),
and host S which has sshd and is not firewalled. Both have
clone of the same repo, modified locally and differently on both hosts.

I need to two-way sync them by running commands on C (the firewalled one).

I need a script that does it, the "git-sync" script, running on C.
              git-sync  user@host:path  [local-dir]   # synchronize
local repo with
                                                                   #
remote repo via ssh
If there are no conflicts, I need to bring both repos to same state (even if
their history will be different). If there are conflicts, I need to
synchronize everything
that is not in conflict, and report the list of conflicted files, and leave
the remote version as  './file.SUFFIX'  on host C, where script was invoked.

Thanks
Yakov
