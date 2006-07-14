From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Error writing loose object on Cygwin
Date: Thu, 13 Jul 2006 23:34:35 -0400
Message-ID: <20060714033435.GA1508@spearce.org>
References: <20060712035746.GA7863@spearce.org> <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net> <20060713055127.GA15960@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 05:34:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ERw-0006Oz-3o
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 05:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWGNDek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 23:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWGNDek
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 23:34:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:62897 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161226AbWGNDek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 23:34:40 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G1ERe-0005mD-DN; Thu, 13 Jul 2006 23:34:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 33C6B20E462; Thu, 13 Jul 2006 23:34:36 -0400 (EDT)
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060713055127.GA15960@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23869>

Christopher Faylor <me@cgf.cx> wrote:
> On Tue, Jul 11, 2006 at 09:15:38PM -0700, Junio C Hamano wrote:
> >Shawn Pearce <spearce@spearce.org> writes:
> >
> >> Has anyone else seen this type of behavior before?  Any suggestions
> >> on debugging this issue?
> >
> >I would suggest raising this (politely) to Cygwin people.
> 
> I lost the thread here but wasn't this referring to a samba mount?  If so,
> it would be samba that's returning the wrong "errno".

I thought about that but Windows 2000 talking to the same samba
server issues back the correct errno.  Running the exact same Cygwin
and GIT binaries (we've at least standardized on that).  So it
seems weird that a samba server is issuing the correct error code
to a Windows 2000 client but the wrong one to a Windows XP client.
(In both cases the clients are accessing directories on the same
filesystem on the UNIX server.)

-- 
Shawn.
