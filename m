From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: How to hide a git repository?
Date: Mon, 24 Nov 2008 17:40:22 -0800 (PST)
Message-ID: <940723.36955.qm@web37906.mail.mud.yahoo.com>
References: <20081125003758.GA6115@zakalwe.fi>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Tue Nov 25 02:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4mvs-0000ih-It
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 02:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbYKYBkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 20:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbYKYBkY
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 20:40:24 -0500
Received: from web37906.mail.mud.yahoo.com ([209.191.91.168]:43457 "HELO
	web37906.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752955AbYKYBkY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 20:40:24 -0500
Received: (qmail 41167 invoked by uid 60001); 25 Nov 2008 01:40:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=G0s1fXsbiBpul1ib+sOvuntOrz4bcKkZmk85TQSJcM8ZZS/IYWQdrSqGKt/vf/vnq6DRUwcY+mAyMeLcinS/MnPqEv+onhZijNAq+gCx5XIYCjHhk4BRbptOkmZfhpNoRZrs8mVkeppnA7SMF0XCKWYu08eOCiD9k5Hfp25R8pI=;
X-YMail-OSG: x_DsSaIVM1lTHsM_NaTw3CimMKGNQCx1.mI36iQKtzuibAPsKJFE_0lyu2i8NgBObsfh86u1nNQzk8lLiCfCUetnAPNHUdl.dpNf0f6msiWEcxsxRj1AdBBVWJg5wpKY0kPlCZyN4FCyfBTPhEQLImqdGdLTcylnTVt.aLcDVgxWc1s-
Received: from [76.195.33.70] by web37906.mail.mud.yahoo.com via HTTP; Mon, 24 Nov 2008 17:40:22 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081125003758.GA6115@zakalwe.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101642>

How to tell "git daemon" only to publish /pub/git/pub/linux/kernel ?


--- On Mon, 11/24/08, Heikki Orsila <shdl@zakalwe.fi> wrote:

> From: Heikki Orsila <shdl@zakalwe.fi>
> Subject: Re: How to hide a git repository?
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: git@vger.kernel.org
> Date: Monday, November 24, 2008, 4:37 PM
> On Mon, Nov 24, 2008 at 04:32:58PM -0800, Gary Yang wrote:
> > 
> > We have two repositories, one is
> /pub/git/dev/linux/kernel, another 
> > is /pub/git/pub/linux/kernel. The
> /pub/git/pub/linux/kernel is open to 
> > public for people to download released code.
> /pub/git/dev/linux/kernel 
> > is used for our development. We would like to hide 
> > /pub/git/dev/linux/kernel from public. How to do it?
> 
> Tell "git daemon" only to publish
> /pub/git/pub/linux/kernel.
> 
> -- 
> Heikki Orsila
> heikki.orsila@iki.fi
> http://www.iki.fi/shd
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
