From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] Make t8001-annotate and t8002-blame more portable
Date: Mon, 19 Jun 2006 00:06:54 +0200
Message-ID: <20060618220654.G4a2f724@leonov.stosberg.net>
References: <20060618203321.G2e8b0080@leonov.stosberg.net> <7v3be218ri.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 00:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs5QK-000444-2V
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 00:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWFRWHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFRWHF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 18:07:05 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:54449 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932097AbWFRWHD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 18:07:03 -0400
Received: from leonov.stosberg.net (p213.54.84.10.tisdip.tiscali.de [213.54.84.10])
	by ncs.stosberg.net (Postfix) with ESMTP id CF875AEBA005;
	Mon, 19 Jun 2006 00:06:48 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 21388FD3AC; Mon, 19 Jun 2006 00:06:54 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3be218ri.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22105>

Junio C Hamano wrote:

> > +    'perl -pi -e "s/^1A.*\n$//; s/^3A/99/" file &&
> >      GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
> 
> The first line in the original is removed while the perl version
> seems to just makes it empty -- ah, you remove the trailing LF
> as well there.  I've never seen this done like this, but OK.
> 
> It would have been more obvious if it were written like this:
> 
> 	$_ = "" if ($. == 1);
> 
> but probably it is just me.

I have no strong preference.  Sometimes I find all those magic perl
variables like $. $| $, $" and so on hard to distinguish without
looking in the manual...

Regards,
Dennis 
