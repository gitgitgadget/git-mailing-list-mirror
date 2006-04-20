From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 16:02:59 -0700
Message-ID: <7vr73rvoik.fsf@assigned-by-dhcp.cox.net>
References: <20060420133640.GA31198@spearce.org>
	<Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
	<20060420150315.GB31198@spearce.org>
	<Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
	<20060420164351.GB31738@spearce.org>
	<Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
	<20060420175554.GH31738@spearce.org>
	<Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
	<7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 01:03:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWiB6-0004A0-HH
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 01:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWDTXDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 19:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWDTXDD
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 19:03:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63213 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750861AbWDTXDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 19:03:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420230300.HPGW14494.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 19:03:00 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Thu, 20 Apr 2006 17:02:25 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19007>

Nicolas Pitre <nico@cam.org> writes:

>> I originally thought, with one single notable exception of
>> Makefile, having the identically named file in many different
>> directories is not common nor sane,
>
> I'd tend to disagree with that but...

I disagree with that myself now.  The kernel tree has many
files with the same basename (e.g. arch/*/kernel/irq.c).

It is a different issue if they are good delta base candidates
with each other, though.
