From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 16:54:20 +0100
Message-ID: <200802091654.20473.kendy@suse.cz>
References: <200802081828.43849.kendy@suse.cz> <foihu9$110$1@ger.gmane.org> <alpine.LSU.1.00.0802082151570.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 16:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNs2a-0004RJ-K0
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 16:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbYBIPyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 10:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYBIPyW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 10:54:22 -0500
Received: from styx.suse.cz ([82.119.242.94]:38671 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752213AbYBIPyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 10:54:21 -0500
Received: from ben.suse.cz (ben.suse.cz [10.20.1.143])
	by mail.suse.cz (Postfix) with ESMTP id D59BE6280B1;
	Sat,  9 Feb 2008 16:54:20 +0100 (CET)
User-Agent: KMail/1.9.1
In-Reply-To: <alpine.LSU.1.00.0802082151570.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73237>

Hi Johannes,

One more 'thank you' for the review - now publically :-)

On Friday 08 February 2008 22:52, Johannes Schindelin wrote:

> > > <bikeshedding>maybe remote-alternates (note the dash instead
> > > of the underscore)</bikeshedding>
> >
> > Why not in info/alternates?
>
> Again, to make the distinction clear.

Yes; still even though the 'alteranates' and 'remote alternates' have some of 
the ideas common, the implementation differs (and has to differ) - so I think 
you are right even in the --lazy option for clone instead of reusing -s.

For the rest - I'll post the updated patch ASAP.

Regards,
Jan
