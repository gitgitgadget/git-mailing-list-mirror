From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Wed, 25 Sep 2013 00:57:21 +0300
Message-ID: <20130924215721.GA2072@redhat.com>
References: <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
 <20130924055419.GA11208@redhat.com>
 <20130924193610.GO9464@google.com>
 <20130924201515.GB23319@redhat.com>
 <20130924213116.GQ9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 23:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOaZh-0006t1-DB
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 23:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab3IXVzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 17:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11008 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab3IXVzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 17:55:10 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8OLt4Ss020149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 17:55:04 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r8OLt2LZ005543;
	Tue, 24 Sep 2013 17:55:03 -0400
Content-Disposition: inline
In-Reply-To: <20130924213116.GQ9464@google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235319>

On Tue, Sep 24, 2013 at 02:31:16PM -0700, Jonathan Nieder wrote:
> Michael S. Tsirkin wrote:
> >>> On Mon, Sep 23, 2013 at 02:37:29PM -0700, Jonathan Nieder wrote:
> 
> >>>>                       Then start over with sorted hunks (for example
> >>>>     building a table of offsets within the patch for each hunk to
> >>>>     support this).
> [...]
> > Well, then the result is not compatible with what
> > original patch-id would produce.
> 
> Nope, I meant sorting to produce what the original patch-id would
> produce for a diff with the default sorting order.  The result is a
> patch-id that can be compared with patch-ids from earlier versions of
> git as long as -O<orderfile> was not used (which was already not
> compatible with reliable use of patch-id).
> 
> [...]
> > Just making sure: is it correct that there's no requirement to use same
> > algorithm between patch-ids.c and builtin/patch-id.c ?
> 
> I think so, as long as Documentation/git-cherry.txt is updated to stop
> pretending 'git cherry' calls 'git patch-id' and the two get comments
> about it, though it seems simpler to keep them roughly the same.
> (They already differ in handling of binary files.)

How do they differ btw?

> Thanks,
> Jonathan
