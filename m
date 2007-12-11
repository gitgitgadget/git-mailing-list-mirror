From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 6/5] Move fetch_ref from http-push.c and http-walker.c
	to http.c
Date: Tue, 11 Dec 2007 07:21:29 +0100
Organization: glandium.org
Message-ID: <20071211062129.GA8372@glandium.org>
References: <1197322571-25023-5-git-send-email-mh@glandium.org> <1197328105-4843-1-git-send-email-mh@glandium.org> <7vve75hl72.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yVI-0007gc-9w
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbXLKGVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXLKGVn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:21:43 -0500
Received: from vuizook.err.no ([85.19.215.103]:52123 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbXLKGVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:21:43 -0500
Received: from aputeaux-153-1-79-219.w81-249.abo.wanadoo.fr ([81.249.109.219] helo=namakemono.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1J1yVT-0001bH-TE; Tue, 11 Dec 2007 07:22:22 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1yUj-0002Co-2p; Tue, 11 Dec 2007 07:21:29 +0100
Content-Disposition: inline
In-Reply-To: <7vve75hl72.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.2): Yes, score=5.2 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67800>

On Mon, Dec 10, 2007 at 09:09:05PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Make the necessary changes to be ok with their difference, and rename the
> > function http_fetch_ref.
> 
> Sorry, but I cannot parse "ok with their difference" part...

What about "to fit with their difference" ?

Mike
