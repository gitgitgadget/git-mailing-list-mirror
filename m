From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Properly force listingblocks to be monospaced in
	manpages
Date: Sun, 19 Aug 2007 23:14:38 +0200
Organization: glandium.org
Message-ID: <20070819211438.GA3326@glandium.org>
References: <20070819210317.GA3202@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMs75-0002sd-3n
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 23:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbXHSVPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 17:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbXHSVPH
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 17:15:07 -0400
Received: from vawad.err.no ([85.19.200.177]:51849 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbXHSVPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 17:15:05 -0400
Received: from aputeaux-153-1-37-169.w82-124.abo.wanadoo.fr ([82.124.129.169] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IMs6z-000346-1i
	for git@vger.kernel.org; Sun, 19 Aug 2007 23:15:05 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IMs6Y-0000vM-0l
	for git@vger.kernel.org; Sun, 19 Aug 2007 23:14:38 +0200
Content-Disposition: inline
In-Reply-To: <20070819210317.GA3202@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56149>

On Sun, Aug 19, 2007 at 11:03:17PM +0200, Mike Hommey <mh@glandium.org> wrote:
> Still insert a ".ft C" before and ".ft" after, but do it in a way as to
> avoid them to get escaped with "\&", which makes the manpages look pretty
> bad. Do it in a more docbook-xsl'ish way.

Actually, the escape thing seems to be a regression in docbook 1.72
which is supposed to be fixed in 1.73...

Anyways, I think it'd still be better to do this in the .xsl file.

Mike
