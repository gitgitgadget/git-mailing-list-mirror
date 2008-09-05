From: Mike Hommey <mh@glandium.org>
Subject: Re: How can i write a new protocol for git
Date: Fri, 5 Sep 2008 11:47:46 +0200
Organization: glandium.org
Message-ID: <20080905094746.GA26820@glandium.org>
References: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sky Patrick <patricksky852@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 11:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbXwK-000339-Qv
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 11:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYIEJsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 05:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbYIEJsA
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 05:48:00 -0400
Received: from vuizook.err.no ([194.24.252.247]:48723 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbYIEJr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 05:47:59 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KbXuw-0004lN-F5; Fri, 05 Sep 2008 11:47:56 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KbXus-00076J-Mf; Fri, 05 Sep 2008 11:47:46 +0200
Content-Disposition: inline
In-Reply-To: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95005>

On Fri, Sep 05, 2008 at 05:22:57PM +0800, Sky Patrick wrote:
> Hi,
> 
> If i want to write a new protocol for file transfer and would like to
> to integrate it with git. Is it possible and easy to integrate it ?
> Currently, i know that jgit may achieve it, but it is a Java
> implementation and may not work with git command line program that
> written in C.

First, it would depend if you need this new protocol to be a dumb
protocol (like rsync and http) or "native" (git or ssh).

I've been meaning to refactor the dumb protocol "stack" for a while, but
haven't gone much further than ideas in my mind (i.e. no code). I also
have some start of http code recfactoring, that is waiting for this dumb
protocol rework to be completed.

Mike
