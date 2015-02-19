From: ydirson@free.fr
Subject: Strange reachability inconsistency (apparently, at least...)
Date: Thu, 19 Feb 2015 16:03:37 +0100 (CET)
Message-ID: <324985759.551780546.1424358217833.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <144640746.551672305.1424355582540.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: dirson@bertin.fr, poulot@bertin.fr, ydirson@free.fr
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 16:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOSdm-000805-O1
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 16:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbbBSPDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 10:03:42 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:58658 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbbBSPDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 10:03:42 -0500
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 52F6A4B01FF;
	Thu, 19 Feb 2015 16:03:37 +0100 (CET)
In-Reply-To: <144640746.551672305.1424355582540.JavaMail.root@zimbra39-e7.priv.proxad.net>
X-Originating-IP: [62.23.137.162]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264101>

I have a (fsck-clean) git tree in which for 2 commits A and B:

* "git merge-base --is-ancestor A B" returns 0
* "git log B..A" returns a non-empty set of commits

I get this behaviour with 2.3.0 as well as with 2.1.3 and 1.7.12.

Is that a real bug or am I just misinterpreting something ?
