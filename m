From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
 branch
Date: Fri, 20 Mar 2009 20:28:28 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0903202022560.12211@reaper.quantumfyre.co.uk>
References: <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org>
 <20090320004450.GY23521@spearce.org> <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <7vwsakgjie.fsf@gitster.siamese.dyndns.org>
 <20090320193650.GA26934@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LklN6-0000hI-KF
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbZCTU3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 16:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZCTU3r
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:29:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33104 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbZCTU3q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 16:29:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5F5CB280FDF
	for <git@vger.kernel.org>; Fri, 20 Mar 2009 20:29:43 +0000 (GMT)
Received: (qmail 19123 invoked by uid 103); 20 Mar 2009 20:28:28 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9142. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025534 secs); 20 Mar 2009 20:28:28 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 20 Mar 2009 20:28:28 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20090320193650.GA26934@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114002>

On Fri, 20 Mar 2009, Jeff King wrote:

> On Fri, Mar 20, 2009 at 11:02:33AM -0700, Junio C Hamano wrote:
>
>> A na?ve question.
>>
>> Has nobody suggested to use a really illegal characters such as ':'
>> instead?  After all, we are not talking something that you can use in
>> refspecs but another way to spell branch names.
>
> But if this goes into dwim_ref, then won't it be usable for refspecs? Or
> even if it isn't, then imagine the user who doesn't know this and types
>
>  git push :foo
>
> unwittingly deleting the remote "foo".
>
> Yes, that is unlikely (since why would they push the tracking branch of
> foo?), but I don't think it makes sense to argue that it doesn't have
> confusing (and potentially dangerous) consequenses.
>
>> Alternatively, '~master' may have a nice connotation that means "where
>> master calls its home".
>
> I think that is quite clever and doesn't have any meaning for a revision
> specifier already. I like it.

I considered suggesting this earlier, but didn't as the behaviour is not 
consistent.  If you have a user named master then you have to type 
'~master' (including quotes), if you don't you can type ~master, and you 
always have to type '~' instead of ~.  I didn't particularly fancy typing 
all those quotes, and certainly not explaining the behaviour to people not 
overly familiar with unix shell behaviour.

-- 
Julian

  ---
It's very inconvenient to be mortal -- you never know when everything may
suddenly stop happening.
