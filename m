From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 08:00:17 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>, <20080826162513.GR10544@machine.or.cz>, <20080826164526.GM26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 08:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYEOT-0007Ip-10
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 08:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbYH0GTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 02:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbYH0GTK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 02:19:10 -0400
Received: from rrzd4.rz.uni-regensburg.de ([194.94.155.49]:23728 "EHLO
	rrzd4.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752011AbYH0GTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 02:19:09 -0400
X-Greylist: delayed 1106 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2008 02:19:09 EDT
Received: from rrzd4.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id CEFA13003;
	Wed, 27 Aug 2008 08:00:40 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	by rrzd4.rz.uni-regensburg.de (Postfix) with ESMTP id 849EF1047;
	Wed, 27 Aug 2008 08:00:39 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id m7R60VxM019235;
	Wed, 27 Aug 2008 08:00:31 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    27 Aug 08 08:00:32 +0200
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 27 Aug 08 08:00:24 +0200
In-reply-to: <20080826164526.GM26610@one.firstfloor.org>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.27/Sophos-P=4.29.0+V=4.29+U=2.07.201+R=05 May 2008+T=405404@20080827.055307Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93859>

On 26 Aug 2008 at 18:45, Andi Kleen wrote:

> git<space><tab><tab>.... what? 140-something commands? etc.etc.
> 

Hi!

Just let me throw in one thought:

Whether files in /usr/bin, or command completions: Long linear lists are a thing 
humans don't like. For the directory issue, one could (assuming a two-level 
hierarchy) take the square root of the number of binaries and create that many 
directories to put the files in (in theory). Likewise for git<TAB><TAB> one could 
deduce the list by making two levels out of one (i.e. sub-sommands).

In HP-UX many commands (or "subsystems") use /opt/<subsys>/{bin,sbin} to place 
their binaries. PATH usually does not contain all of them. That's against Linux 
philosophy I think, and I really don't like huge PATHs, but it may be one solution 
to reduce the size of linear lists. It won't help against the git<TAB><TAB> issue 
directly, however.

Regards,
Ulrich
