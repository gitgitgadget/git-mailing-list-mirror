From: Mike Hommey <mh@glandium.org>
Subject: Re: More on git over HTTP POST
Date: Sun, 3 Aug 2008 08:43:38 +0200
Organization: glandium.org
Message-ID: <20080803064338.GA3686@glandium.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 08:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPXL1-0007ck-HU
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 08:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYHCGnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 02:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYHCGnt
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 02:43:49 -0400
Received: from vuizook.err.no ([194.24.252.247]:51899 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbYHCGns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 02:43:48 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KPXJb-0001RZ-4y; Sun, 03 Aug 2008 08:43:45 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KPXJa-00019j-7y; Sun, 03 Aug 2008 08:43:38 +0200
Content-Disposition: inline
In-Reply-To: <20080803025602.GB27465@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91209>

On Sat, Aug 02, 2008 at 07:56:02PM -0700, Shawn O. Pearce wrote:
> Smart HTTP transfer protocols
> =============================
> 
> Git supports two HTTP based transfer protocols.  A "dumb" protocol
> which requires only a standard HTTP server on the server end of the
> connection, and a "smart" protocol which requires a Git aware CGI
> (or server module).  This document describes the "smart" protocol.

If you want, I have a patch series that introduces a small API to make
HTTP requests easier to make.

Mike
