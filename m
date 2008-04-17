From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: Maintaining commit.template config through clones
Date: Thu, 17 Apr 2008 18:47:32 +1000
Organization: REA Group
Message-ID: <48070EA4.2050503@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 10:50:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmPnS-0000Dj-5c
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 10:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbYDQIr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 04:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbYDQIr6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 04:47:58 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:25985 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828AbYDQIr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 04:47:57 -0400
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 17 Apr 2008 18:47:32 +1000
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
X-OriginalArrivalTime: 17 Apr 2008 08:47:32.0495 (UTC) FILETIME=[AD0571F0:01C8A067]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79776>

Hi,
I'm attempting to implement Git at our company, and we currently use a 
commit template for CVS. I can convert this to a Git-formatted template, 
and set it for use with git-config commit.template ....

However, once the repository is cloned, this configuration option 
vanishes from .git/config

Is there a way to make configuration options sticky?

thanks,
Toby

-- 
Toby Corkindale
Software developer
w: www.rea-group.com
REA Group refers to realestate.com.au Ltd (ASX:REA)

Warning - This e-mail transmission may contain confidential information.
If you have received this transmission in error, please notify us
immediately on (61 3) 9897 1121 or by reply email to the sender. You
must destroy the e-mail immediately and not use, copy, distribute or
disclose the contents.
