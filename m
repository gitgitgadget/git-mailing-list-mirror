From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: post-receive-hook emailer
Date: Tue, 22 Jul 2008 02:34:35 -0700
Message-ID: <00AEED4D-BD34-4584-B303-32C5F587EF0F@develooper.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 11:42:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLENt-0007ID-V2
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbYGVJlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbYGVJlS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:41:18 -0400
Received: from x8.develooper.com ([216.52.237.208]:37615 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbYGVJlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:41:17 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jul 2008 05:41:17 EDT
Received: (qmail 30047 invoked from network); 22 Jul 2008 09:34:36 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 22 Jul 2008 09:34:36 -0000
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89479>

Hi everyone,

Anyone know what is used to send the http://marc.info/?l=git-commits-head 
  mails?

The post-receive contrib hook in the repository isn't working for us -  
we want diffs and such in our mails.   I started working on patching  
the script in contrib; but it's not really clear to me if the current  
state of that script is as it should be and I just have a different  
use case.

Anyway - anyone have a mailer that sends diffs and such?  :-)   Or  
should I just write a wrapper around format-patch and send-email?    
(To handle branches well it gets slightly complicated, quick - or  
maybe I just haven't understood how the post-receive hook works).


  - ask

-- 
http://develooper.com/ - http://askask.com/
