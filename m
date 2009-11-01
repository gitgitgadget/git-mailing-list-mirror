From: Mike Hommey <mh@glandium.org>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 1 Nov 2009 09:19:04 +0100
Message-ID: <20091101081904.GC28095@glandium.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samium Gromoff <_deepfire@feelingofgreen.ru>
X-From: git-owner@vger.kernel.org Sun Nov 01 09:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Veo-0005qh-SO
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 09:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZKAITN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 03:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbZKAITM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 03:19:12 -0500
Received: from vuizook.err.no ([85.19.221.46]:38888 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbZKAITM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 03:19:12 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1N4VeZ-0005s0-CX; Sun, 01 Nov 2009 09:19:14 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1N4VeS-0007VG-OB; Sun, 01 Nov 2009 09:19:04 +0100
Content-Disposition: inline
In-Reply-To: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131867>

On Sun, Nov 01, 2009 at 01:07:02AM +0300, Samium Gromoff wrote:
> Good day folks,
> 
> Attached is the SEGV bugreport I sent to debian.
> 
> I tried to convince ld to use /usr/lib/debug, via LD_LIBRARY_PATH,
> and run the thing under gdb 7.0, but it won't use debug libraries
> for some reason.

You don't need to point to /usr/lib/debug, for two reasons:
- The files there are empty nutshells as far as binaries are concerned.
  They only contain the debugging symbols.
- gdb is going to load files from there automatically for each file it
  has loaded and doesn't contain debugging symbols.

Mike
