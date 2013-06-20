From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/2] send-email: add test for duplicate utf8 name
Date: Thu, 20 Jun 2013 14:41:37 +0200
Message-ID: <87a9ml9cou.fsf@linux-k42r.v.cablecom.net>
References: <1371731166-24015-1-git-send-email-mst@redhat.com>
	<1371731166-24015-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 14:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpeBb-0003L9-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 14:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715Ab3FTMll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 08:41:41 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:43381 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757692Ab3FTMlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 08:41:39 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 14:41:29 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 14:41:37 +0200
In-Reply-To: <1371731166-24015-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 20 Jun 2013 15:27:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228488>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Verify that author name is not duplicated if it matches
> sender, even if it is in utf8.

Small nit: if you make two patches out of it, add the tests first with
test_expect_failure.  Then flip it to test_expect_success in the actual
code change.  That makes it easy to verify that the test actually checks
the right thing, and that it was your code change that fixed it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
