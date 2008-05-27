From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] clone: make sure we support the transport type
Date: Tue, 27 May 2008 18:30:27 +0200
Organization: glandium.org
Message-ID: <20080527163027.GB11865@glandium.org>
References: <200805271124.50172.trast@student.ethz.ch> <20080527142842.GA7651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 27 18:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K126E-0002sT-8F
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 18:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbYE0Qbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbYE0Qbj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 12:31:39 -0400
Received: from vuizook.err.no ([194.24.252.247]:50068 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004AbYE0Qbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 12:31:38 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K124k-0004Bz-26; Tue, 27 May 2008 18:31:08 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K124B-0003DX-Nx; Tue, 27 May 2008 18:30:27 +0200
Content-Disposition: inline
In-Reply-To: <20080527142842.GA7651@sigill.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83030>

On Tue, May 27, 2008 at 10:28:43AM -0400, Jeff King wrote:
> If we use an unsupported transport (e.g., http when curl
> support is not compiled in), transport_get reports an error
> to the user, but we still get a transport object. We need to
> manually check and abort the clone process at that point, or
> we end up with a segfault.

Shouldn't transport_get return NULL in such a situation, instead ?

Mike
