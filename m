From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Wed, 21 May 2014 15:52:46 +0300
Message-ID: <20140521125246.GA21476@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
 <1400447743-18513-4-git-send-email-mst@redhat.com>
 <xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
 <20140520143850.GA13099@redhat.com>
 <xmqqvbt01o14.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 14:53:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn61u-00070H-96
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 14:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbaEUMxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 08:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbaEUMxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 08:53:53 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4LCrpSi002935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2014 08:53:51 -0400
Received: from redhat.com (ovpn-116-106.ams2.redhat.com [10.36.116.106])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4LCrnsU024173;
	Wed, 21 May 2014 08:53:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbt01o14.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249792>

On Tue, May 20, 2014 at 08:13:27AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Just to clarify I can post v2 of 4/4 without reposting 1-3 since they
> > are queued?
> 
> If you need to update anything queued only on 'pu' but not yet in
> 'next', it is customary to resend the whole for everybody to see
> (what is already in 'next' should only be built upon incrementally
> and not updated with replacement patches), while noting which ones
> are the same as before.  Christian Couder has been doing it nicely
> in his recent rerolls (if the series were not in 'next', that is).
> 
> Thanks.

Actually I don't see anything like it in pu.
What I would like is for 1-3 to be in pu,
4/4 was for illustrative purposes it's not yet
ready for that, and 1-3 are useful by themselves.
I could then iterate on 4/4 without reposting 1-3.
