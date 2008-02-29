From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when
	not running verbosely
Date: Fri, 29 Feb 2008 23:58:16 +0100
Organization: glandium.org
Message-ID: <20080229225816.GA24892@glandium.org>
References: <1204323805-23185-1-git-send-email-mh@glandium.org> <20080229225331.GA8440@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVE8e-0007kH-3V
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbYB2Wy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbYB2Wy6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:54:58 -0500
Received: from vuizook.err.no ([194.24.252.247]:51658 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbYB2Wy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:54:58 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVE7q-0007Wc-Li; Fri, 29 Feb 2008 23:54:53 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVEBE-0006U5-9T; Fri, 29 Feb 2008 23:58:16 +0100
Content-Disposition: inline
In-Reply-To: <20080229225331.GA8440@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75585>

On Fri, Feb 29, 2008 at 05:53:31PM -0500, Jeff King wrote:
> On Fri, Feb 29, 2008 at 11:23:25PM +0100, Mike Hommey wrote:
> 
> >  test_expect_success "virtual trees were processed" "git diff expect out"
> >  
> > -git reset --hard
> > +git reset --hard >&3 2>&4
> >  test_expect_success 'refuse to merge binary files' '
> >  	printf "\0" > binary-file &&
> >  	git add binary-file &&
> 
> Should this perhaps just be:
> 
>   test_expect_success 'reset state' 'git reset --hard'

Is it really about testing git reset ?

Mike
