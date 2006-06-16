From: bert hubert <bert.hubert@netherlabs.nl>
Subject: Re: 2.6.17-rc6-mm2
Date: Sat, 17 Jun 2006 00:44:06 +0200
Message-ID: <20060616224406.GA10451@outpost.ds9a.nl>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org> <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com> <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Goo GGooo <googgooo@gmail.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 00:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrN3B-0004pT-0p
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWFPWoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWFPWoV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:44:21 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:57744 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751536AbWFPWoV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 18:44:21 -0400
Received: by outpost.ds9a.nl (Postfix, from userid 1000)
	id 8CE863F86; Sat, 17 Jun 2006 00:44:06 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Linus Torvalds <torvalds@osdl.org>, Goo GGooo <googgooo@gmail.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21983>

On Thu, Jun 15, 2006 at 11:39:35PM -0700, Linus Torvalds wrote:

> Except they only work over ssh, where we have a separate channel (for 
> stderr), and with the native git protocol all that nice status work just 
> gets flushed to /dev/null :(

It won't help passing firewalls one bit, but you might consider using SCTP
with multiple datastreams for this - theoretically :-)

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
