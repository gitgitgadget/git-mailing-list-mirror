From: Mike Hommey <mh@glandium.org>
Subject: Re: http git clone fails while ssh git clone works
Date: Thu, 3 Apr 2008 20:28:15 +0200
Organization: glandium.org
Message-ID: <20080403182815.GA23341@glandium.org>
References: <cc723f590804030440t14a8e4fdw77c4449dc2a4dbb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhUBl-0001CR-0r
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 20:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYDCS2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 14:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYDCS2p
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 14:28:45 -0400
Received: from vuizook.err.no ([194.24.252.247]:34190 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbYDCS2o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 14:28:44 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JhUAt-0006ZI-Re; Thu, 03 Apr 2008 20:28:42 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JhUAZ-0006K6-Ik; Thu, 03 Apr 2008 20:28:15 +0200
Content-Disposition: inline
In-Reply-To: <cc723f590804030440t14a8e4fdw77c4449dc2a4dbb8@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78767>

On Thu, Apr 03, 2008 at 05:10:07PM +0530, Aneesh Kumar wrote:
> git clone http://myhost...
> 
> ot 0bc8afe5e1f16a6c56bc677a6c85148455a474b3
> got ee425b0b7fccd9cdea38ef781b76f034e0228391
> error: Unable to find 31053805b6981918e1f39e7149f62d2a0068732a under
> http://myhost.....
> Cannot obtain needed commit 31053805b6981918e1f39e7149f62d2a0068732a
> while processing commit 56933610fa9a36ea3fc053e02bd7442b55db85dd.
> 
> while git clone ssh://myhost... works fine.

Can you try again with GIT_CURL_VERBOSE set ? It will probably show you
what http request is failing and why.

Mike
