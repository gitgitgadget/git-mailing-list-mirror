From: Mike Hommey <mh@glandium.org>
Subject: Re: Rewriting history with git-filter-branch and leaking objects
	(?)
Date: Fri, 17 Aug 2007 20:31:15 +0200
Organization: glandium.org
Message-ID: <20070817183115.GA15653@glandium.org>
References: <20070817171851.GB13891@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 20:31:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM6bw-0008FA-3q
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 20:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbXHQSbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbXHQSbt
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 14:31:49 -0400
Received: from vawad.err.no ([85.19.200.177]:43711 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbXHQSbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 14:31:48 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM6bq-0006pe-7h
	for git@vger.kernel.org; Fri, 17 Aug 2007 20:31:48 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM6bL-00047G-5W
	for git@vger.kernel.org; Fri, 17 Aug 2007 20:31:15 +0200
Content-Disposition: inline
In-Reply-To: <20070817171851.GB13891@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56080>

On Fri, Aug 17, 2007 at 07:18:51PM +0200, Mike Hommey <mh@glandium.org> wrote:
> $ rm .git/logs/refs/heads/master 
> $ rm .git/logs/HEAD

git-reflog expire --expire-unreachable=$(date +%s) --all

is cleaner, but git prune -n still misses a tree.

Mike
