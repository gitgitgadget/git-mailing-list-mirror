From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 1 Nov 2007 11:53:18 +0100
Organization: glandium.org
Message-ID: <20071101105318.GA4744@glandium.org>
References: <1193861145-20357-1-git-send-email-mh@glandium.org> <fcaeb9bf0710311809o41703bc5hda36a9d44a538eeb@mail.gmail.com> <7vejfag40g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 11:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InXhg-0000kU-NB
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 11:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423AbXKAKyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 06:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757356AbXKAKyl
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 06:54:41 -0400
Received: from vawad.err.no ([85.19.200.177]:34582 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346AbXKAKyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 06:54:40 -0400
Received: from aputeaux-153-1-31-123.w82-124.abo.wanadoo.fr ([82.124.1.123] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InXgw-0004xw-3r; Thu, 01 Nov 2007 11:54:28 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1InXfq-0001cA-5p; Thu, 01 Nov 2007 11:53:18 +0100
Content-Disposition: inline
In-Reply-To: <7vejfag40g.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62934>

On Wed, Oct 31, 2007 at 06:15:27PM -0700, Junio C Hamano wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> 
> > BTW, you have workaround for git-merge also? It uses cpio to save/restore state.
> 
> Why do people want "workaround"?  Is installing cpio such a
> hassle?

Note that to do what git-merge does with cpio, i wonder if it wouldn't
be sensible to use git stash, now.

Mike
