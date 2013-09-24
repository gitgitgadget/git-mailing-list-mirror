From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] doc: don't claim that cherry-pick calls patch-id
Date: Wed, 25 Sep 2013 01:52:03 +0300
Message-ID: <20130924225203.GA2521@redhat.com>
References: <1380060333-2226-1-git-send-email-mst@redhat.com>
 <20130924221409.GT9464@google.com>
 <20130924222822.GA2308@redhat.com>
 <20130924224431.GU9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 00:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VObQV-00026S-J4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab3IXWtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab3IXWtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:49:47 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8OMnjTj025610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Sep 2013 18:49:46 -0400
Received: from redhat.com (vpn1-6-23.ams2.redhat.com [10.36.6.23])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8OMniXU021197;
	Tue, 24 Sep 2013 18:49:44 -0400
Content-Disposition: inline
In-Reply-To: <20130924224431.GU9464@google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235326>

On Tue, Sep 24, 2013 at 03:44:31PM -0700, Jonathan Nieder wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Sep 24, 2013 at 03:14:09PM -0700, Jonathan Nieder wrote:
> >> Michael S. Tsirkin wrote:
> 
> >>> -The commits are compared with their 'patch id', obtained from
> >>> -the 'git patch-id' program.
> >>> +The diffs are compared with their diff id (sha1) calculated after removing
> >>> +any whitespace and line numbers (similar but not necessarily identical
> >>> +to 'patch id', obtained from the 'git patch-id' program).
> >>
> >> The hash used internally is just an implementation detail, so maybe this
> >> sentence could just be dropped?
> >
> > I think the fact whitespace is ignored is relevant to users, no?
> > We probably should drop talking about hash here.
> 
> Ah, good point.  So, something like the following, then?
> 
> 	Whitespace and line numbers are ignored when comparing the diffs,
> 	similarly to linkgit:git-patch-id[1].
> 
> Maybe some other wording would make it clearer that we are not using
> "git diff -w" output.

See v2 that I sent, maybe that's clear enough.
