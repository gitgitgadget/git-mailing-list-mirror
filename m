From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: update memory allocation for http headers
Date: Sun, 18 Jan 2009 15:20:02 +0100
Organization: glandium.org
Message-ID: <20090118142002.GA18159@glandium.org>
References: <be6fef0d0901180516q19327c18oa1d7ccc36ce3a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYWt-0006JE-Hc
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760260AbZAROUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759932AbZAROUL
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:20:11 -0500
Received: from vuizook.err.no ([85.19.221.46]:41741 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757018AbZAROUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:20:10 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOYVP-0001fL-GA; Sun, 18 Jan 2009 15:20:06 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOYVO-0000iA-4h; Sun, 18 Jan 2009 15:20:02 +0100
Content-Disposition: inline
In-Reply-To: <be6fef0d0901180516q19327c18oa1d7ccc36ce3a87@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106191>

On Sun, Jan 18, 2009 at 09:16:04PM +0800, Ray Chuan wrote:
> In 753bc91 (Remove the requirement opaquelocktoken uri scheme), the
> header strings were with the removal "opaquelocktoken:" (16
> characters).
> 
> Unfortunately, this was without the corresponding change in memory
> allocation. In this patch we update these allocations.
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---

It would be better to just turn the whole thing to use strbuf, and/or
extend the patch set I sent earlier today to handle webdav.

Mike
