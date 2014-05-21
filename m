From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Wed, 21 May 2014 20:39:50 +0300
Message-ID: <20140521173950.GA24564@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
 <1400447743-18513-4-git-send-email-mst@redhat.com>
 <xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
 <20140520143850.GA13099@redhat.com>
 <xmqqvbt01o14.fsf@gitster.dls.corp.google.com>
 <20140521125246.GA21476@redhat.com>
 <xmqqioozqdgo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 19:41:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnAVj-0007Zx-DX
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbaEURk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbaEURk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:40:57 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4LHetI9004780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2014 13:40:55 -0400
Received: from redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4LHeqQq012870;
	Wed, 21 May 2014 13:40:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioozqdgo.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249816>

On Wed, May 21, 2014 at 09:54:47AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Tue, May 20, 2014 at 08:13:27AM -0700, Junio C Hamano wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > Just to clarify I can post v2 of 4/4 without reposting 1-3 since they
> >> > are queued?
> >> 
> >> If you need to update anything queued only on 'pu' but not yet in
> >> 'next', it is customary to resend the whole for everybody to see
> >> (what is already in 'next' should only be built upon incrementally
> >> and not updated with replacement patches), while noting which ones
> >> are the same as before.  Christian Couder has been doing it nicely
> >> in his recent rerolls (if the series were not in 'next', that is).
> >> 
> >> Thanks.
> >
> > Actually I don't see anything like it in pu.
> 
> The way I usually work is to apply a non-fix (i.e. enhancement)
> series on a topic branch forked from 'master' (or the last tagged
> version contained in its tip) and see if it makes sense, and then
> try-merge the result to 'next' to see if it is free of potential
> funny interactions with other topics that are already in flight.
> After that happens, the topic branch is merged to somewhere in 'pu'.
> 
> It is possible that I did not have time to go through all the steps
> above (after all, I had to make another -rc release and there was an
> unexpected last-minute change of plans in the morning that blew a
> few hours of work).  Or there may have been some merge conflicts
> that I didn't feel like resolving for various reasons (e.g. if I
> knew the series would be rerolled anyway, it can wait; if the other
> topic that interacts with your series has been cooking sufficiently
> long in 'next' and if it is very close to the final release of this
> cycle, it may be easier to wait for the other topic to graduate to
> 'master', which would happen soon after this cycle finishes, and ask
> you to rebase your series).
> 
> I don't remember which ;-)
> 

Oh sorry, didn't mean to try to pressure you. I was just surprised
not to see it there. I know this applies cleanly to next so I'll just
wait for 2.0 to be out.

-- 
MST
