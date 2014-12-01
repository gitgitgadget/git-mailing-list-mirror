From: ydirson@free.fr
Subject: HIstory simplification limited to requested refs ?
Date: Mon, 1 Dec 2014 15:36:02 +0100 (CET)
Message-ID: <1434502090.311776139.1417444562893.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <448912770.311767091.1417444369251.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: dirson@bertin.fr, ydirson@free.fr
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:36:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvS5E-0005do-8b
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 15:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbaLAOgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 09:36:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55366 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbaLAOgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 09:36:06 -0500
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9E999A635A;
	Mon,  1 Dec 2014 15:35:53 +0100 (CET)
In-Reply-To: <448912770.311767091.1417444369251.JavaMail.root@zimbra39-e7.priv.proxad.net>
X-Originating-IP: [62.23.137.162]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260483>

Hello,

I'm trying to get gitk to draw the relationship between a bunch of integration branches.
What I'm looking for is a graph that would show which of those branches is included by
others.  --simplify-by-decoration nearly does the job, but does not omit those heads
merged into the requested branches.  Did I miss a particular git-log flag that would
allow something like --simplify-by-commandline ?

Best regards,
--
Yann
