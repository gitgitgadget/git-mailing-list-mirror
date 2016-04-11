From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: (unknown)
Date: Mon, 11 Apr 2016 19:02:40 +0300
Message-ID: <20160411160240.GA7721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 11 18:02:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apeIZ-0005uG-9k
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 18:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcDKQCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 12:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60103 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbcDKQCn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 12:02:43 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B93037C101;
	Mon, 11 Apr 2016 16:02:42 +0000 (UTC)
Received: from redhat.com (vpn1-5-155.ams2.redhat.com [10.36.5.155])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3BG2eMZ017274;
	Mon, 11 Apr 2016 12:02:41 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291217>

Cc junio
Bcc: 
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Message-ID: <20160411184535-mutt-send-email-mst@redhat.com>
Reply-To: 
In-Reply-To: <alpine.DEB.2.20.1604111736060.2967@virtualbox>

On Mon, Apr 11, 2016 at 05:36:45PM +0200, Johannes Schindelin wrote:
> Hi Michael,
> 
> On Mon, 11 Apr 2016, Michael S. Tsirkin wrote:
> 
> > So far I only see examples of adding footers. If that's all we can think
> > up, why code in all this genericity?
> 
> Because as far as I can see, the only benefitor of your patches would be
> you.
> 
> Ciao,
> Johannes

This seems unlikely.  Just merging the patches won't benefit me directly
- I have maintained them in my tree for a couple of years now with very
little effort.  For sure, I could benefit if they get merged and then
someone improves them further - that was the point of posting them - but
then I'm not the only benefitor.

The workflow including getting acks for patches by email is not handled
well by upstream git right now.  It would surprise me if no one uses it
if it's upstream, as you seem to suggest.  But maybe most people moved
on and just do pull requests instead.

-- 
MST
