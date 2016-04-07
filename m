From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 7 Apr 2016 20:52:53 +0300
Message-ID: <20160407205144-mutt-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
 <1460042563-32741-2-git-send-email-mst@redhat.com>
 <xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
 <20160407202631-mutt-send-email-mst@redhat.com>
 <xmqq60vt1g4l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:53:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoE73-0003mw-OY
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081AbcDGRw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:52:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757019AbcDGRw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:52:57 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93212C0D7F00;
	Thu,  7 Apr 2016 17:52:56 +0000 (UTC)
Received: from redhat.com (vpn1-6-229.ams2.redhat.com [10.36.6.229])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37HqrRo003598;
	Thu, 7 Apr 2016 13:52:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60vt1g4l.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290940>

On Thu, Apr 07, 2016 at 10:30:02AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Apr 07, 2016 at 09:55:29AM -0700, Junio C Hamano wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > Allow -t as a short-cut for --trailer.
> >> >
> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> > ---
> >> 
> >> As I do not think interpret-trailers is meant to be end-user facing,
> >> I am not sure I should be interested in this step.
> >> 
> >> I am in principle OK with the later step that teaches a single
> >> letter option to end-user facing "git am" that would be turned into
> >> "--trailer" when it calls out to "interpret-trailers" (I haven't
> >> checked if 't' is a sensible choice for that single letter option,
> >> though).
> >
> > Does OPT_PASSTHRU_ARGV handle this transformation for me?
> 
> As I wrote in my response to Matthieu, PASSTHRU_ARGV is one thing I
> specifically do not want to see used in this codepath.

It sounds like a general kind of thing, does it not?
Aren't there other cases where a short option needs to be
converted to a long one?

-- 
MST
