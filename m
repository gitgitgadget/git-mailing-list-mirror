From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] send-email: add test for duplicate utf8 name
Date: Thu, 20 Jun 2013 15:45:02 +0300
Message-ID: <20130620124502.GA24172@redhat.com>
References: <1371731166-24015-1-git-send-email-mst@redhat.com>
 <1371731166-24015-2-git-send-email-mst@redhat.com>
 <87a9ml9cou.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 14:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpeE9-0007n1-8w
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 14:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab3FTMod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 08:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757716Ab3FTMoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 08:44:32 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5KCiHkS022232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 20 Jun 2013 08:44:17 -0400
Received: from redhat.com (vpn-200-33.tlv.redhat.com [10.35.200.33])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r5KCiEf9015498;
	Thu, 20 Jun 2013 08:44:15 -0400
Content-Disposition: inline
In-Reply-To: <87a9ml9cou.fsf@linux-k42r.v.cablecom.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228489>

On Thu, Jun 20, 2013 at 02:41:37PM +0200, Thomas Rast wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Verify that author name is not duplicated if it matches
> > sender, even if it is in utf8.
> 
> Small nit: if you make two patches out of it, add the tests first with
> test_expect_failure.  Then flip it to test_expect_success in the actual
> code change.  That makes it easy to verify that the test actually checks
> the right thing, and that it was your code change that fixed it.

I did this by reverting 1/2 and rerunning.

But applying in reverse order means bisect can give us
a setup where some tests fail, I thought it's a
good idea to avoid that.

> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
