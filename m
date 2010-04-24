From: Mike Hommey <mh@glandium.org>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 17:11:03 +0200
Message-ID: <20100424151103.GA19272@glandium.org>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <201004241348.49397.jnareb@gmail.com>
 <20100424142848.GA4461@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Apr 24 17:11:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5h0m-0005Hk-UL
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 17:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab0DXPLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 11:11:11 -0400
Received: from vuizook.err.no ([85.19.221.46]:59181 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0DXPLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 11:11:10 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1O5h0a-0005Rf-U4; Sat, 24 Apr 2010 17:11:07 +0200
Received: from mh by glandium.org with local (Exim 4.71)
	(envelope-from <mh@glandium.org>)
	id 1O5h0Z-00057M-T0; Sat, 24 Apr 2010 17:11:03 +0200
Content-Disposition: inline
In-Reply-To: <20100424142848.GA4461@gnu.kitenet.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 2.5): No, score=2.5 required=5.0 tests=DNS_FROM_OPENWHOIS,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145683>

On Sat, Apr 24, 2010 at 10:28:48AM -0400, Joey Hess wrote:
> Jakub Narebski wrote:
> > What you cant recover by undoing commit is the state of index before
> > accidental 'git commit -a' instead of 'git commit'.
> 
> Has a reflog equivilant for the index, to allow resetting it to a
> previous state, ever been discussed? 
> 
> I don't grok its data structure -- could that be done efficiently?

Updating the index creates blobs, so the file states are definitely
already kept. What is missing is trees that could be referred to by a
log.

Mike
