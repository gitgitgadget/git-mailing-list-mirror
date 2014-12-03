From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 3 Dec 2014 02:34:19 +0000
Message-ID: <20141203023419.GA10519@dcvr.yhbt.net>
References: <20140324213814.GA1267@achilles.my.domain>
 <20141202193243.GA2999@charon.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvzlp-000507-15
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 03:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbaLCCeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 21:34:21 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38840 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbaLCCeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 21:34:20 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E041F5D9;
	Wed,  3 Dec 2014 02:34:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141202193243.GA2999@charon.olymp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260616>

Luis Henriques <henrix@camandro.org> wrote:
> On Mon, Mar 24, 2014 at 09:38:27PM +0000, Luis Henriques wrote:
> > Add --[no-]xmailer that allows a user to disable adding the 'X-Mailer:'
> > header to the email being sent.
> >
> 
> Ping
> 
> It's been a while since I sent this patch.  Is there any interest in
> having this switch in git-send-email?

I wasn't paying attention when the original was sent, but this
looks good to me.

Acked-by: Eric Wong <normalperson@yhbt.net>

> I honestly don't like disclosing too much information about my system,
> in this case which MUA I'm using and its version.

Right on.  I would even favor this being the default.

Auto-generated Message-Id headers also shows the use of git-send-email;
perhaps there can be a way to configure that, too.  However,
git-send-email respects manually-added Message-Id headers in the
original patch, so it's less of a problem, I suppose.
