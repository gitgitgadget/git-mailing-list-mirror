From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Mon, 1 Sep 2008 23:42:54 +0200
Message-ID: <20080901214254.GA8058@blimp.localhost>
References: <20080830173947.GF7185@schiele.dyndns.org> <20080830183413.GG7185@schiele.dyndns.org> <20080830183949.GA16415@coredump.intra.peff.net> <200808302237.17017.jnareb@gmail.com> <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Robert Schiele <rschiele@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 23:44:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaHBr-0004l6-6a
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYIAVm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYIAVm5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:42:57 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:20263 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYIAVm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:42:57 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf40HVSQ==
Received: from tigra.home (Fade9.f.strato-dslnet.de [195.4.173.233])
	by post.webmailer.de (fruni mo10) (RZmta 16.47)
	with ESMTP id 90673ek81HnFJE ; Mon, 1 Sep 2008 23:42:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 19D97277AE;
	Mon,  1 Sep 2008 23:42:54 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 1148236D1D; Mon,  1 Sep 2008 23:42:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94613>

Avery Pennarun, Sun, Aug 31, 2008 07:35:31 +0200:
> On Sat, Aug 30, 2008 at 4:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > Or you can use "open $fd, '-|'" to fork, an "manually" exec/system.
> 
> Shell quoting is a disaster (including security holes, where relevant)
> waiting to happen.  The above is the only sane way to do it, and it
> isn't very hard to implement. ...

except on Windows, where it is impossible to implement.
