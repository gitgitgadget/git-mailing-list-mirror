From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty working
 tree
Date: Fri, 16 Oct 2009 20:31:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910162028190.21739@xanadu.home>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
 <20091016173902.GT10505@spearce.org> <7veip3t6rm.fsf@alter.siamese.dyndns.org>
 <dffdbd190910161452o4ac0b426i7c48649eafa0d53@mail.gmail.com>
 <7vvdifq6vw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jean Privat <jean@pryen.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 02:31:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyxCh-0003sl-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 02:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbZJQAbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 20:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZJQAbR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 20:31:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44448 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbZJQAbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 20:31:16 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRM00EWHUS8JW90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Oct 2009 20:31:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vvdifq6vw.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130540>

On Fri, 16 Oct 2009, Junio C Hamano wrote:

> But the thing is, "git describe" without arguments already works on HEAD
> and describes it, and people depend on the behaviour.
> 
> I originally thought this _might_ break and hoped it won't be a big issue,
> but now I've seen that even the kernel would break (it runs the command
> without saying "HEAD"), I do not want to risk breaking other projects I
> may not even heard of.  Some people might have copied our GIT-VERSION-GEN
> (that says "HEAD"), but I would not bet against that many many more people
> would have copied the use of "git describe" from the kernel build tree
> than from us.

OpenOCD is another project that just started using Git and copied 
describe usage from Linux.


Nicolas
