From: Thomas Singer <thomas.singer@syntevo.com>
Subject: git stash save <message>
Date: Fri, 05 Mar 2010 13:16:54 +0100
Message-ID: <4B90F636.2030300@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 13:23:42 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnWZC-0005FH-5c
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 13:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab0CEMXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 07:23:40 -0500
Received: from syntevo.com ([85.214.39.145]:41243 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100Ab0CEMXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 07:23:38 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2010 07:23:37 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 9261B608084
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141578>

Where can I find information about what content in <message> is (not)
allowed? We've got a bug-report where a SmartGit user has simply entered a
minus and Git refused to work. Of course, entering just a minus is quite
useless, but we have to be able to reliable detect allowed and disallowed
messages. Should every message with a leading minus be rejected? Maybe the
best would be to add a new command line option, e.g. --message before the
<message>, so one can provide anything as message?

--
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
