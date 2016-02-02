From: Andrew Martin <amartin@xes-inc.com>
Subject: git object-count differs between clones
Date: Tue, 2 Feb 2016 09:52:51 -0600 (CST)
Message-ID: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com>
References: <57434188.709288.1454428054374.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 16:53:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQdGF-000095-OE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 16:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482AbcBBPwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 10:52:55 -0500
Received: from xes-mad.com ([216.165.139.218]:8959 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933268AbcBBPwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 10:52:53 -0500
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id u12Fqqgv004282
	for <git@vger.kernel.org>; Tue, 2 Feb 2016 09:52:52 -0600
In-Reply-To: <57434188.709288.1454428054374.JavaMail.zimbra@xes-inc.com>
X-Originating-IP: [10.52.16.96]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - GC47 (Linux)/8.0.6_GA_5922)
Thread-Topic: git object-count differs between clones
Thread-Index: PHUbt70eYGdJkyzVUIjpW3Yq1pd8Qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285268>

Hello,

I am using git 2.7.0 on Ubuntu 14.04. I recently tried pushing a large (90,000+
commits) repository to a gogs server (https://gogs.io/) and then cloning the
repository back to my machine. After running "git count-objects -v", I see a
discrepancy in the number of objects:

Original Repository:
count: 0
size: 0
in-pack: 1258300
packs: 1
size-pack: 593889
prune-packable: 0
garbage: 0
size-garbage: 0


Clone from gogs:
count: 0
size: 0
in-pack: 1258270
packs: 1
size-pack: 593884
prune-packable: 0
garbage: 0
size-garbage: 0


I ran "git fsck" on both, which reported no problems. Moreover, I ran "git gc"
and made sure there were no objects pending garbage collection, but still I
cannot account for this difference. Can someone explain why these numbers
differ, and if this is a problem or not?

Thanks,

Andrew
