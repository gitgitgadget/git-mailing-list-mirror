From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 5/9] patch-id: document new behaviour
Date: Fri, 25 Apr 2014 00:26:39 +0300
Message-ID: <20140424212639.GA9129@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-5-git-send-email-mst@redhat.com>
 <20140424173325.GK15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 23:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdR9r-00045Y-PH
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbaDXV0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 17:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbaDXV0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 17:26:06 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OLPt0V028902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 24 Apr 2014 17:25:55 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s3OLPrI2022805;
	Thu, 24 Apr 2014 17:25:54 -0400
Content-Disposition: inline
In-Reply-To: <20140424173325.GK15516@google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247008>

On Thu, Apr 24, 2014 at 10:33:25AM -0700, Jonathan Nieder wrote:
> Michael S. Tsirkin wrote:
> 
> >  Documentation/git-patch-id.txt | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> Ah, there's the documentation.  Please squash this with the patch that
> introduces the new behavior so they can be reviewed together more
> easily (both now and later when people do archeology).
> 
> [...]
> > +--stable::
> > +	Use a symmetrical sum of hashes as the patch ID.
> > +	With this option, reordering file diffs that make up a patch or
> > +	splitting a diff up to multiple diffs that touch the same path
> > +	does not affect the ID.
> > +	This is the default if patchid.stable is set to true.
> 
> This doesn't explain to me why I would want to use --stable versus
> --unstable.  Maybe an EXAMPLES section would help?
> 
> The only reason I can think of to use --unstable is for compatibility
> with historical patch-ids.  Is there any other reason?
> 
> At this point in the series there is no patchid.stable configuration.
> 
> > +--unstable::
> > +	Use a non-symmetrical sum of hashes, such that reordering
> 
> What is a non-symmetrical sum?

Non-symmetrical combination function is better?

> Thanks,
> Jonathan
