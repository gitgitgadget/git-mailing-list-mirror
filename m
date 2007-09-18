From: Mike Hommey <mh@glandium.org>
Subject: Re: git-fsck/lost-found's speed vs git-prune's
Date: Tue, 18 Sep 2007 11:50:49 +0200
Organization: glandium.org
Message-ID: <20070918095049.GA9388@glandium.org>
References: <20070918090926.GA8927@glandium.org> <7v4phswcuj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZkE-0002eT-Bu
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbXIRJvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbXIRJvp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:51:45 -0400
Received: from vawad.err.no ([85.19.200.177]:43460 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505AbXIRJvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:51:45 -0400
Received: from aputeaux-153-1-18-194.w82-124.abo.wanadoo.fr ([82.124.60.194] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IXZk7-0001yi-SB; Tue, 18 Sep 2007 11:51:46 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IXZjF-0002S1-4o; Tue, 18 Sep 2007 11:50:49 +0200
Content-Disposition: inline
In-Reply-To: <7v4phswcuj.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58565>

On Tue, Sep 18, 2007 at 02:18:44AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > I was wondering if that was to be expected for git-fsck to be
> > significantly slower than git-prune (by several orders of magnitude) ?
> 
> fsck validates objects are correct and sane.  prune only looks
> at reachability.

Now, the speed difference makes sense, but I wouldn't expect lost-found
to actually bother validating objects...

Mike
