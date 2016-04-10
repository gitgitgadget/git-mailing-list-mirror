From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Sun, 10 Apr 2016 20:43:01 +0300
Message-ID: <20160410203556-mutt-send-email-mst@redhat.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
 <vpqlh4qbrnt.fsf@anie.imag.fr>
 <20160406201509-mutt-send-email-mst@redhat.com>
 <xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
 <20160406212940-mutt-send-email-mst@redhat.com>
 <CAP8UFD0Pw+yhO1jZTAbMkZ5d-usu3rx5N0Se=PNL=N7DD-BPcA@mail.gmail.com>
 <20160410182750-mutt-send-email-mst@redhat.com>
 <CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 19:43:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apJOB-0006tR-9E
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 19:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbcDJRnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 13:43:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57597 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816AbcDJRnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 13:43:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5B827DCE3;
	Sun, 10 Apr 2016 17:43:03 +0000 (UTC)
Received: from redhat.com (vpn1-5-25.ams2.redhat.com [10.36.5.25])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3AHh11a000876;
	Sun, 10 Apr 2016 13:43:02 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291182>

On Sun, Apr 10, 2016 at 06:57:53PM +0200, Christian Couder wrote:
> What I meant is that we could create new options called maybe
> trailer.autocommands and trailer.<token>.autocommands that default to
> 'true' and if 'false' the command would not be run automatically and
> the corresponding trailer would not be added.

I don't think it has to do with commands.
For example, if we add "value" it should behave the same.

So I think a better name is "ifnotlisted", with values "add"
and "donothing".

Thoughts?

-- 
MST
