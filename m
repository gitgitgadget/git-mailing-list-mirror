From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 17:37:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311734140.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <7vpqrc4t1s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2NI-00054o-4R
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab1AaWh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:37:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53366 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab1AaWhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:37:25 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW0011HS5O2M10@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 17:37:00 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vpqrc4t1s.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165768>

On Mon, 31 Jan 2011, Junio C Hamano wrote:

> If we make the top-level directory lean enough, we probably can tab
> complete after typing just "cd t" to go to testsuite/ or tests/ or
> whatever you come up with, so "more typing" is not a huge issue to me
> personally.
> 
> I however think the directory name "t/" is not our invention but what we
> took from somebody else (perhaps Perl?), and I suspect some people expect
> to find tests under there since we have had them there for a long time.

If those people are not able to figure out that "testsuite" means where 
tests are, especially within a lean top directory, then we might 
question the reliability of the tests they might contribute.


Nicolas
