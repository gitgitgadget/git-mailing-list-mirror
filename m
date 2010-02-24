From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Wed, 24 Feb 2010 10:09:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002241004010.1946@xanadu.home>
References: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nelson Elhage <nelhage@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 16:14:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkIvg-0005Bl-GK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 16:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab0BXPNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 10:13:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39022 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab0BXPNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 10:13:30 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KYC002C3Q4H1760@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Feb 2010 10:09:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v635nsa37.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140945>

On Tue, 23 Feb 2010, Junio C Hamano wrote:

> * ne/pack-local-doc (2010-02-18) 1 commit
>  - Documentation: pack-objects: Clarify --local's semantics.
> 
> Comments from pack experts?

The patch is fine in the sense that what it modifies was indeed wrong.

However the "even if it appears in the standard input" formulation 
should also be fixed as the object list may be specified with a rev spec 
on the command line, and not necessarily only via standard input.


Nicolas
