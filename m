From: Edgar Toernig <froese@gmx.de>
Subject: Re: gitk lower pane (commit and files view) scrollbar extends past
 gitk window
Date: Thu, 22 Jun 2006 02:35:46 +0200
Message-ID: <20060622023546.28cb4291.froese@gmx.de>
References: <e7ber7$qh9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 02:35:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtDAp-0007Mv-1u
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 02:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWFVAfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 20:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWFVAfw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 20:35:52 -0400
Received: from mail.gmx.de ([213.165.64.21]:39573 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932147AbWFVAfv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 20:35:51 -0400
Received: (qmail invoked by alias); 22 Jun 2006 00:35:50 -0000
Received: from p5090017D.dip0.t-ipconnect.de (EHLO dialup) [80.144.1.125]
  by mail.gmx.net (mp017) with SMTP; 22 Jun 2006 02:35:50 +0200
X-Authenticated: #271361
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e7ber7$qh9$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22291>

Jakub Narebski wrote:
>
> In gitk from the current 'next' branch, post git version 1.4.0 
> (blob ba4644f) scrollbar for lower pane, i.e. for commitdiff and files
> (Comments) views extends past the bottom of the gitk window. Therefore 
> I cannnot see lower part of commit diff if it is larger than window height.

Yes, and the search field at the bottom is invisible too.  Removing
line 431:

        .ctop conf -width $geometry(width) -height $geometry(height)

seems to fix it and the window still gets the right size.

Ciao, ET.
