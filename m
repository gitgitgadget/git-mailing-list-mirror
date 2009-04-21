From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2] Allow git-shell to be used as a ssh forced-command
Date: Tue, 21 Apr 2009 11:09:39 +0200
Message-ID: <20090421090939.GA6788@glandium.org>
References: <20090418063100.GA18568@glandium.org> <1240292586-28192-1-git-send-email-mh@glandium.org> <7vbpqqa0gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwC16-0007ol-Nc
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbZDUJJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbZDUJJv
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:09:51 -0400
Received: from vuizook.err.no ([85.19.221.46]:60663 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbZDUJJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:09:51 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LwBz5-0005h6-0q; Tue, 21 Apr 2009 11:09:45 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LwBz1-0001nA-RG; Tue, 21 Apr 2009 11:09:39 +0200
Content-Disposition: inline
In-Reply-To: <7vbpqqa0gy.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117113>

On Tue, Apr 21, 2009 at 01:13:17AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> > variable to what would otherwise be passed to $SHELL -c. When this
> > variable is set and git-shell was given no argument, we use it.
> 
> I might be being extremely slow, but I had an impression that I saw only
> the downsides discussed in the earlier thread and did not see what use
> case this is supposed to help.
> 
> Is it a valid question to ask "what's wrong with gitosis"?

Why use gitosis where all you need is git-shell?

Mike
