From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Mon, 07 Dec 2009 10:44:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912071043200.31174@xanadu.home>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
 <20091207210608.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 16:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHflX-0003hG-LZ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 16:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935281AbZLGPof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 10:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935258AbZLGPof
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 10:44:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58136 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934347AbZLGPof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 10:44:35 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUA00G16H2HL770@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 07 Dec 2009 10:44:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091207210608.6117@nanako3.lavabit.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134761>

On Mon, 7 Dec 2009, Nanako Shiraishi wrote:

> Quoting Junio C Hamano <gitster@pobox.com>
> 
> > I queued to ease the discussion in 'pu'.  I had to fix-up some conflicts
> > while doing so.  Please sanity check the result.
> 
> I see that you changed many "char* variable" to "char *variable", but
> what is the reason for these changes?

The * is an attribute of the variable and not of the type.  This makes 
for clearer code.


Nicolas
