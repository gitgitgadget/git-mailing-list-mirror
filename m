From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH 1/4] Implement normalize_absolute_path
Date: Tue, 20 May 2008 09:44:26 -0700
Message-ID: <4832FFEA.7020905@facebook.com>
References: <48327456.1060202@facebook.com> <alpine.DEB.1.00.0805201321300.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 20 18:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyUyy-0005rq-PP
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 18:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbYETQpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757783AbYETQpm
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 12:45:42 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:33665 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158AbYETQpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 12:45:41 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4KGjcY7016142;
	Tue, 20 May 2008 09:45:38 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 May 2008 09:42:34 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <alpine.DEB.1.00.0805201321300.30431@racer>
X-OriginalArrivalTime: 20 May 2008 16:42:34.0069 (UTC) FILETIME=[80EA4050:01C8BA98]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-20_06:2008-05-20,2008-05-20,2008-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805200122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82485>

> I wonder why my advice to look at setup.c (I think I did not mention the
> function name "sanitary_path_copy()" in particular, because I figured you
> would spot it right away) went unheeded.

I wonder why my comment in the patch went unheeded:
> The closest thing I could find to this in the existing code base was
> sanitary_path_copy, but it does not remove trailing slashes.

Honestly, I found it quite daunting to try to track down all of the
indirect callers of sanitary_path_copy and ensure that they would
continue to work if I changed the behavior of a function that does not
document what it is supposed to do.  Frankly, it would be easier for me
to just keep rebasing my patches and apply them to my local builds.

--David
