From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: [OT] Re: Feature request - Subtree checkouts
Date: Thu, 12 Apr 2007 10:55:19 +0100
Message-ID: <20070412095519.GB26763@vual.tchpc.tcd.ie>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net> <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org> <sfid-H20070410-225421-+102.57-1@vual.tchpc.tcd.ie> <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 12:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbwTQ-0000xF-SQ
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 12:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992442AbXDLKYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 06:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992440AbXDLKYO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 06:24:14 -0400
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:54493 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992442AbXDLKYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 06:24:12 -0400
X-Greylist: delayed 1730 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2007 06:24:12 EDT
Received: from localhost (localhost [127.0.0.1])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id F334A2B950;
	Thu, 12 Apr 2007 10:55:20 +0100 (IST)
Received: from tabaet.tchpc.tcd.ie ([127.0.0.1])
	by localhost (tabaet.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20092-10; Thu, 12 Apr 2007 10:55:20 +0100 (IST)
Received: from vual.tchpc.tcd.ie (vual.ipv6.tchpc.tcd.ie [IPv6:2001:770:10:500:2b0:d0ff:fefe:d7d2])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id 181282B948;
	Thu, 12 Apr 2007 10:55:20 +0100 (IST)
Received: from localhost (unknown [127.0.0.1])
	by vual.tchpc.tcd.ie (Postfix) with ESMTP id F1D6B19124;
	Thu, 12 Apr 2007 10:55:19 +0100 (IST)
Received: from vual.tchpc.tcd.ie ([127.0.0.1])
 by localhost (vual.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27870-07; Thu, 12 Apr 2007 10:55:19 +0100 (IST)
Received: by vual.tchpc.tcd.ie (Postfix, from userid 8176)
	id DD5181912A; Thu, 12 Apr 2007 10:55:19 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
User-Agent: Mutt/1.4.1i
X-Useless-Header: I am the Master Blaster!, the faster blaster master blaster faster blaster
X-Operating-System: Linux vual.tchpc.tcd.ie 2.4.26
X-Wii-Number: 6053 9064 7271 7948
X-Wii-Nick: zaku
X-Virus-Scanned: by amavisd-new at tchpc.tcd.ie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44335>

On Tue, Apr 10, 2007 at 02:33:54PM -0700, alan wrote:
> >
> >For example, I will personally never see email that comes directly to my
> >email address though an open mail relay *or* from something that appears
> >to be just a random botnet PC (I forget the exact rule, since I'm hapily
> >ignorant of MIS, but I think it boils down to requiring a good reverse DNS
> >lookup).
> 
> Depending on your definition of "good".
> 
> I run my mail server off my DSL line.  I prefer having control over my 
> mail server instead of being chained to what my ISP provides.  (The 
> problems of having been a sysadmin for way too many years.) I don't have 
> control over the reverse ip address, but I do over my DNS resolution. 
> (Well, most of it. A couple domains are sitting on really old dns servers 
> from years past.)
> 
> >That's getting much more common. Most spam is done through botnets, and
> >they still try to do the direct-to-port-25 thing, exactly because if you
> >go through a *real* SMTP host, your ISP will generally shut you down
> >pretty quickly if you're spamming.
> 
> Which makes Greylisting a useful tool.  However, some people define a 
> "real SMTP host" as being the one your ISP provides and no other.  No 
> matter how good your OS or how stringent your rulesets for sending mail 
> are.
> 

greylisting unfortunately requires "some maintenance" to keep it
going well, and it also breaks some mail appliances and probably some
MTA's that are completely compliant in retrying to send mails. 

another tactic which is probably just as good if not better than
greylisting is "nolisting", that is to have your primary mx point to a
non-existant machine with a real ip-address and dns entries (or even
a machine with a firewall that runs iptables that blackholes or does
funky stuff to anything coming in on port 25 and then just drops the
connections). 

if the remote end is a compliant MTA it will failover to the secondary
mx which is a real machine that receives mail. but it probably suffers
from the same problem of mail appliances not being completely compliant
to the specs on how MTA's should work.

nolisting offers almost as good effects as greylisting without the
hassle of maintaining a list.


Jimmy.

-- 
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | http://www.tchpc.tcd.ie/~jtang
