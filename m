From: "Albert Krawczyk" <pro-logic@optusnet.com.au>
Subject: RE: Git SVN non-standard branch/tag/trunk layout
Date: Tue, 14 Dec 2010 08:08:28 +1100
Message-ID: <002301cb9b09$e4eb2de0$aec189a0$@optusnet.com.au>
References: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au> <13731475.185564.1292250200171.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Stephen Bash'" <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 22:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSFdS-0004Lr-Ts
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 22:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756304Ab0LMVIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 16:08:37 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:60250 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752069Ab0LMVIh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 16:08:37 -0500
Received: from AlbertDesktop (60-241-64-178.static.tpgi.com.au [60.241.64.178])
	(authenticated sender pro-logic)
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id oBDL8SJ8023000
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 14 Dec 2010 08:08:31 +1100
In-Reply-To: <13731475.185564.1292250200171.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKMM7pWWu4o5JBAspvsynrxRjYvjZIdq1dQ
Content-Language: en-au
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163594>

>Project 2 is an interesting one because it looks like the trunk is at the same level as branches/tags.  If that's the case, the 'branches' line above will work (it will treat >the trunk like any other branch -- a very Git-like approach).  Also note that those projects that didn't have a 'trunk' directory in SVN I added a 'trunk' on the Git side to >keep things consistent -- this is completely optional.
>
>Once you get comfortable with the rules governing the config lines, you can pretty much untangle any SVN layout.
>
>HTH,
>Stephen

Hi Stephen,

Thanks a lot! I thought this is what I had to do, and had through trial and (a lot of) error got to be very close. As far as I can see the only 'downside' of this approach is that you can't have the 'root' of the SVN repo checked out, you can only have the root of each project checked out, as they are all on their own ref. 

Thanks again for clarifying that,
Albert 
