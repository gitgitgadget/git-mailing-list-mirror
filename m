From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/1] git-multimail: a replacement for post-receive-email
Date: Sun, 21 Apr 2013 22:02:45 +0200
Message-ID: <517445E5.3080304@alum.mit.edu>
References: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu> <20130421105612.GA28959@elie.Belkin> <7vhaizu3j5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	=?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmas?= =?ISO-8859-1?Q?on?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 22:03:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU0TS-0001lL-68
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab3DUUCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 16:02:54 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:65327 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754315Ab3DUUCx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Apr 2013 16:02:53 -0400
X-AuditID: 1207440f-b7f0e6d000000957-3b-517445ec2553
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EE.BB.02391.CE544715; Sun, 21 Apr 2013 16:02:52 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD49D6.dip0.t-ipconnect.de [79.221.73.214])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3LK2jpP012994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Apr 2013 16:02:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vhaizu3j5.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsUixO6iqPvGtSTQoOOzisXaZ3eYLK6dXMxi
	sbe7k9Wi60o3k0VD7xVmi7c3lzBaXPq8ntWi8UmRxfuz/5kdOD3O7V3I4rFz1l12j4lfjrN6
	XLyk7PF5k5zHgcuP2QLYorhtkhJLyoIz0/P07RK4MzY1sBWs4qpYtvg6SwNjN0cXIyeHhICJ
	xOnNXSwQtpjEhXvr2boYuTiEBC4zSkxZ8ZQJwjnPJLHz5jZWkCpeAW2JTxvXMIHYLAKqEss3
	/GAHsdkEdCUW9TSDxUUFwiRWrV/GDFEvKHFy5hOwDSICahIT2w6xgAxlFljJLLHh7GywocIC
	/hKrT19kgdg2mVFi5c8/YFM5Bcwk/jzpZgOxmQV0JN71PWCGsOUltr+dwzyBUWAWkiWzkJTN
	QlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIXPDvYOxaL3OIUYCD
	UYmHt+BHUaAQa2JZcWXuIUZJDiYlUd7vTiWBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4fdiA
	crwpiZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCV4jYPwLCRalpqdWpGXm
	lCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNb4YGK8gKR6gvZ4g7bzFBYm5QFGI1lOMuhwrrzx5
	zSjEkpeflyolzpsGUiQAUpRRmge3ApYEXzGKA30szBsIUsUDTKBwk14BLWECWvKZuxBkSUki
	QkqqgVFdlXlxw1W9o7vn3jtj51Wwo//QcR5Xe7bCioXpO1nfHAo8/1x5/uzt4s+/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221967>

On 04/21/2013 08:44 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> My personal preference is that patches come on the git list, are
>> reviewed here, and then go to your fork of the Git project that Junio
>> can periodically pull from at your request (like git-svn).  But of
>> course this is up to you, too.
> 
> And also me ;-)
> 
> Yes, I very much prefer the way how git-svn is managed.

Let me see if I understand what that means:

* I maintain my own Git clone

* Patches to git-multimail would go to the Git mailing list like patches
to other patches to the Git project, but I would be the one to git-am
them, monitor discussion, help with review, etc.  I would presumably
apply the patches near your master (or near maint when necessary).

* When I think a batch of patches is ready, I merge them to my master
and publish my master somewhere.  (Or is it better I publish the feature
branch and leave it to you to merge directly to your master?)  Then I
send a merge request to you and the Git mailing list with the URL and
SHA-1 of the branch that I would like you to merge.

That seems very workable.

What is your preference regarding the history to date?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
