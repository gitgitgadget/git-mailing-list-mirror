From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 14:28:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710311416450.3342@woody.linux-foundation.org>
References: <20071030160232.GB2640@hermes.priv>
 <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
 <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
 <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org>
 <85lk9jzsxb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org>
 <20071031204729.GB13300@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710311350100.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:28:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InL71-0005s1-ES
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbXJaV2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbXJaV2P
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:28:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39865 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478AbXJaV2O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 17:28:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VLS5rf031458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 14:28:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VLS5sf029428;
	Wed, 31 Oct 2007 14:28:05 -0700
In-Reply-To: <alpine.LFD.0.999.0710311350100.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.433 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62878>



On Wed, 31 Oct 2007, Linus Torvalds wrote:
> 
> If you don't like the fact that git doesn't quote, just don't use the 
> magic characters. It's that easy. And if somebody quotes the '/', just 
> tell him off for being an ass.

Side note - none of the repos I use are likely to actually have any 
quoting as an issue, so in that sense I don't actually care. I'd never 
notice if git did any quoting or not.

What I care about - and where I entered the discussion - is that the real 
impetus for this *stupid* quoting is not the actual need for quoting in 
itself (which doesn't seem to exist), but because people want to extend 
the repository naming to contain other things too, in particular the 
broken cogito single-branch naming thing.

So I could care less about some detail that I'll never even notice, if it 
wasn't for the fact that there's all this other baggage that goes with 
this whole thing. So the quoting itself is more of a symptom of the real 
problem.

Guess what? I didn't make the config file follow any Windows INI standards 
either. I'm just waiting for the first person to point out that you cannot 
parse a .gitconfig file with standard INI parsers.

			Linus
