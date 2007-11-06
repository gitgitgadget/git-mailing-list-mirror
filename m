From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Tue, 6 Nov 2007 22:02:10 +0100
Organization: glandium.org
Message-ID: <20071106210210.GA32159@glandium.org>
References: <20071106201518.GA6361@ins.uni-bonn.de> <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVaL-00010m-GO
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbXKFVD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbXKFVD3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:03:29 -0500
Received: from vawad.err.no ([85.19.200.177]:50462 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbXKFVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:03:28 -0500
Received: from aputeaux-153-1-78-131.w81-249.abo.wanadoo.fr ([81.249.108.131] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IpVZy-0002j4-NG; Tue, 06 Nov 2007 22:03:25 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IpVYo-0008Ow-Kd; Tue, 06 Nov 2007 22:02:10 +0100
Content-Disposition: inline
In-Reply-To: <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63724>

On Tue, Nov 06, 2007 at 12:46:35PM -0800, Junio C Hamano wrote:
> [5/5] Again, have you covered all of them?  I am not opposed to
>       this one, although I am a bit curious who lacks -a/-o in
>       practice.

Solaris's /bin/sh, but it already doesn't support $() and other stuff
used all over the place in git, so it's not like it's changing anything.

Maybe some other obscure old crappy shell ?

Mike
