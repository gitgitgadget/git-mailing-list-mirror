From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: fast-forwarding tags
Date: Wed, 25 Sep 2013 14:36:51 +0300
Message-ID: <20130925113651.GA19023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 13:34:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOnMc-0006Rp-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 13:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab3IYLee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 07:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256Ab3IYLee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 07:34:34 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8PBYYAD000443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 07:34:34 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8PBYWUQ017806
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 07:34:33 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235341>

Hi!
Linus favors one-time use signed tags, e.g. for_linus.
Unfortunately if I push to such a tag without -f,
I get an error ("already exists").
Would it make sense for there to be an option that makes it behave like
a head, and allow fast-forward?

-- 
MST
