From: Theodore Tso <tytso@mit.edu>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 18:35:50 -0400
Message-ID: <20070927223550.GC8688@thunk.org>
References: <7vhclfubh5.fsf@gitster.siamese.dyndns.org> <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com> <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org> <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com> <7v8x6ru97z.fsf@gitster.siamese.dyndns.org> <7vwsubsuh1.fsf@gitster.siamese.dyndns.org> <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com> <94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com> <7vmyv7sshv.fsf@gitster.siamese.dyndns.org> <7vir5vss58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kelvie Wong <kelvie@ieee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1xh-0007ew-CT
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbXI0Wfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758762AbXI0Wfz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:35:55 -0400
Received: from thunk.org ([69.25.196.29]:44655 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193AbXI0Wfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:35:54 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ib272-00016Q-53; Thu, 27 Sep 2007 18:45:40 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Ib1xW-0005ip-Ff; Thu, 27 Sep 2007 18:35:50 -0400
Content-Disposition: inline
In-Reply-To: <7vir5vss58.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59346>

On Thu, Sep 27, 2007 at 02:41:23PM -0700, Junio C Hamano wrote:
> When mergetool is run from a subdirectory, "ls-files -u" nicely
> limits the output to conflicted files in that directory, but
> we need to give the full path to cat-file plumbing to grab the
> contents of stages.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: "Theodore Ts'o" <tytso@mit.edu>

						- Ted
