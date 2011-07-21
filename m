From: Eric Blake <eblake@redhat.com>
Subject: stupid git alias trick
Date: Thu, 21 Jul 2011 17:06:29 -0600
Organization: Red Hat
Message-ID: <4E28B0F5.2090705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 01:06:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk2KA-0001Za-Ph
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 01:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab1GUXGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 19:06:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab1GUXGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 19:06:30 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6LN6Upm025566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 21 Jul 2011 19:06:30 -0400
Received: from [10.3.113.79] (ovpn-113-79.phx2.redhat.com [10.3.113.79])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p6LN6TWD000675;
	Thu, 21 Jul 2011 19:06:29 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110621 Fedora/3.1.11-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.11
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177630>

Thought I'd share this one, in case anyone else finds it useful.

Every so often, I find myself typing "git ", then pausing while thinking 
of which command I meant to run (commit, rebase, push?), then realizing 
that I actually need to make more edits in my editor first.  On 
completion of that task, I come back to terminal and type "git 
blah<ENTER>" out of habit, not realizing that I'm not starting from an 
empty prompt.  Of course, "git git blah" is not a valid command, but if 
you have help.autocorrect configured, this ends up auto-correcting to 
"git init blah" instead, and while that often ends up failing due to 
unexpected arguments for 'git init', I've actually had scenarios where 
it succeeds at doing something, but certainly not the "blah" I had in mind.

But thanks to aliases, this is no longer a problem:

git config --global alias.git '!git'

and now, typing "git git blah" results in the execution of the git 
alias, which in turn runs "git blah" like I intended.  Yay for:

git git git git git git git git git git status

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
