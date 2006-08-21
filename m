From: "Troy Telford" <ttelford@linuxnetworx.com>
Subject: Re: git clone dies (large git repository)
Date: Mon, 21 Aug 2006 17:30:41 -0600
Organization: Linux Networx
Message-ID: <op.tenp9fv1ies9li@rygel.lnxi.com>
References: <op.teh30gmyies9li@rygel.lnxi.com> <7vfyfs313t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 01:30:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFJEH-0008Ir-6c
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 01:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWHUXaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 19:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWHUXaq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 19:30:46 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:12747 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751323AbWHUXap
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 19:30:45 -0400
Received: from rygel.lnxi.com ([::ffff:192.168.40.106])
	by zoot.lnxi.com with ESMTP (TLS encrypted); Mon, 21 Aug 2006 17:30:42 -0600
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfyfs313t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Opera Mail/9.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25827>

On Sat, 19 Aug 2006 14:46:30 -0600, Junio C Hamano <junkio@cox.net> wrote:

> What is interesting is that .pack format does not have (as far
> as I know) inherent size limitation.  However, .idx file has
> hardcoded 32-bit offsets into .pack -- hence, in practice, you
> cannot use a .pack that is over 4GB locally.

Confessing my (complete, total, frightening) ignorance about git:  Is it  
even possible to take a large pack file and split it into smaller packs?

I'm thinking of it as an option for git-repack-- that the user can set the  
maximum size of any individual pack, and after that limit is reached, a  
new pack file is started.  (ie. --max-size 2GB) and will end up with two  
packs, each 2GB in size.

That being said -- I've been able to work around it (although I haven't  
tried your suggestion yet); it's not a 'critical' problem.  I'm now just  
curious if my fantasy (above) makes sense.
-- 
Troy Telford
