From: Mike Hommey <mh@glandium.org>
Subject: Re: git-svn tags and branches
Date: Mon, 27 Aug 2007 17:31:38 +0200
Organization: glandium.org
Message-ID: <20070827153138.GA12936@glandium.org>
References: <faulrb$483$1@sea.gmane.org> <867inhqaj9.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 17:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgaf-0001EH-Sm
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbXH0PdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbXH0PdR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:33:17 -0400
Received: from vawad.err.no ([85.19.200.177]:54601 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbXH0PdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:33:17 -0400
Received: from aputeaux-153-1-29-74.w82-124.abo.wanadoo.fr ([82.124.191.74] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IPgZu-0003e2-GW; Mon, 27 Aug 2007 17:33:03 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IPgZ0-0003NX-AE; Mon, 27 Aug 2007 17:31:38 +0200
Content-Disposition: inline
In-Reply-To: <867inhqaj9.fsf@lola.quinscape.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56848>

On Mon, Aug 27, 2007 at 05:09:30PM +0200, David Kastrup <dak@gnu.org> wrote:
> I actually don't see how one can safely make them tags at all (rather
> than branches) since Subversion does not enforce the members of a
> "tags" subdirectory to remain unchanged after the initial copy.
> Basically, tags are not different from branches in Subversion from
> what you can do with them.

Well, git-svn could make tags when the tag/branch is created in subversion,
and then create a branch on the first commit on top of that tag/branch in
svn.

Mike
