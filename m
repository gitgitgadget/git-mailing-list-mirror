From: "Albert Krawczyk" <pro-logic@optusnet.com.au>
Subject: RE: Git SVN non-standard branch/tag/trunk layout
Date: Mon, 13 Dec 2010 11:55:30 +1100
Message-ID: <000401cb9a60$71bcd610$55368230$@optusnet.com.au>
References: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au> <m2fwu2ecy8.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Dec 13 01:55:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwhY-00016u-FM
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab0LMAzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 19:55:35 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:59523 "EHLO
	mail07.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474Ab0LMAze (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 19:55:34 -0500
Received: from AlbertDesktop (60-241-64-178.static.tpgi.com.au [60.241.64.178])
	(authenticated sender pro-logic)
	by mail07.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oBD0tUuc022963
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 13 Dec 2010 11:55:31 +1100
In-Reply-To: <m2fwu2ecy8.fsf@igel.home>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKXf1+Kehm9tMDR4WHIUg3/PY72PAGpipQmkfh1vDA=
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163503>

Andreas Schwab [mailto:schwab@linux-m68k.org]

> If they are multiple projects then you'll probably be better off 
> importing each project into its own git repository.
> 
> Andreas.

Yes, this is probably the 'better' way of dealing with it, and it works
fine. I was however wondering if there was a way to track the root of the
SVN directory with the structure I supplied earlier while maintaining a
'nice' structure in Git without having /trunk/, /branch/, /tag/
subdirectories appearing directly in the repository as standard folders. My
(extremely limited) understanding is that I would need to edit the config
file, specifically the fetch, branches and tags section of svn-remote. But I
am unsure of how this modified section would look like. 

Albert
