From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Tue, 23 May 2006 03:13:33 -0400
Message-ID: <20060523071333.GA18249@coredump.intra.peff.net>
References: <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com> <20060523065232.GA6180@coredump.intra.peff.net> <20060523070007.GC6180@coredump.intra.peff.net> <7v4pzh6wtr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 09:14:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiR5N-00020H-F9
	for gcvg-git@gmane.org; Tue, 23 May 2006 09:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWEWHNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWEWHNg
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 03:13:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:26609 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932089AbWEWHNf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 03:13:35 -0400
Received: (qmail 13670 invoked from network); 23 May 2006 07:13:33 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 07:13:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 03:13:33 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4pzh6wtr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20570>

[cc'd to list to get reactions on open2]

On Tue, May 23, 2006 at 12:10:08AM -0700, Junio C Hamano wrote:

> > +	return $s =~ /^[a-zA-Z0-9]{40}$/;
> [0-9a-f] (We always do lowercase).

Er, yes, that was a complete think-o on my part.

> Hmm.  I personally do not have problems with open2, but folks on
> some other platforms might.  I'll see how the list audience
> sounds.

FWIW, it was already being used in git-cvsimport.

-Peff
