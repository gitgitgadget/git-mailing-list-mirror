From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: diff/Checking out by date specification
Date: Mon, 30 Jun 2008 12:24:03 +1000
Organization: REA Group
Message-ID: <486843C3.30402@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 04:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD9KR-0004U8-Sd
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 04:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbYF3CkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 22:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYF3CkQ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 22:40:16 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:47656 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754051AbYF3Cjk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 22:39:40 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jun 2008 22:39:40 EDT
Received: from [192.168.52.7] ([192.168.52.7]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 30 Jun 2008 12:24:00 +1000
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
X-OriginalArrivalTime: 30 Jun 2008 02:24:00.0731 (UTC) FILETIME=[5B826AB0:01C8DA58]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86864>

Hi,
`man git-rev-parse` seems to indicate that one can look at the state of 
the repository by date (absolute or relative), and use this for diff or 
checkout, etc.
It includes examples such as "{yesterday}" and "{1979-02-26 18:30:00}".

I'm struggling to get this to work in real life with cloned 
repositories, as I receive an error that the log only goes back  to 
whenever I cloned the repository.

Is there a way to make this operate upon the remote log?

Eg:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git diff "@{yesterday}"
warning: Log for '' only goes back to Mon, 30 Jun 2008 12:22:52 +1000.
fatal: bad object @{yesterday}


Cheers,
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
