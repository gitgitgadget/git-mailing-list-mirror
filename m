From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 16:36:33 -0700
Message-ID: <DD3976FB-09E7-4E78-BB4E-7E61AF827C95@cs.indiana.edu>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY87w-0002v9-8D
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbYHZXhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYHZXhh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:37:37 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:46941 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbYHZXhh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:37:37 -0400
X-Greylist: delayed 858 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Aug 2008 19:37:36 EDT
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.85) with ESMTP id m7QNad1D016695;
	Tue, 26 Aug 2008 19:36:39 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7QNaYoK001602
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 26 Aug 2008 19:36:38 -0400
In-Reply-To: <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93834>

On Aug 26, 2008, at 1:39 PM, Junio C Hamano wrote:

> But I can't.  People who complain _now_ just annoy me even more.  Why
> weren't you defending the backward compatibility with me, which you  
> seem
> to value it so much, perhaps even more than I did back then?  Why  
> are you
> wasting our time bringing it up again, instead of joining the  
> discussion
> when it _mattered_ back then?

I wasn't around back then.  I came in a year ago to write some git  
scripts (mostly for hooks).  I saw that lots of scripts (including  
gitweb and the sample hooks) used the git- form, and some didn't.  I  
found that I liked the git- form, since it permitted command and man  
page name completion, so I did that.

Today I literally wake up to find that I now gotta go fix all those  
scripts, upgrade git-web, and whatever other *scripts* used the now  
obsolete git- form.  Sorry, I skim the git list every week or three.

The doctor says I'll live, and be back to health in a few hours.  But  
there will be a doctor bill.  Can I send it to you?  8)

-- Perry Wagle (wagle@mac.com)
