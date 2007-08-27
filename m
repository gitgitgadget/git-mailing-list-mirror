From: Mike Hommey <mh@glandium.org>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 16:16:00 +0200
Organization: glandium.org
Message-ID: <20070827141600.GA11000@glandium.org>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org> <vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org> <Pine.LNX.4.64.0708271440500.28586@racer.site> <866431rser.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPfOo-0004r8-KL
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 16:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbXH0OQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 10:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbXH0OQ7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 10:16:59 -0400
Received: from vawad.err.no ([85.19.200.177]:47934 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbXH0OQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 10:16:58 -0400
Received: from aputeaux-153-1-29-74.w82-124.abo.wanadoo.fr ([82.124.191.74] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IPfOd-0004UL-DF; Mon, 27 Aug 2007 16:16:54 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IPfNo-0002rz-7u; Mon, 27 Aug 2007 16:16:00 +0200
Content-Disposition: inline
In-Reply-To: <866431rser.fsf@lola.quinscape.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56843>

On Mon, Aug 27, 2007 at 03:58:04PM +0200, David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 27 Aug 2007, Mike Hommey wrote:
> >
> >> BTW, wouldn't it be more efficient to store the odf files unzipped ?
> >
> > Efficient how?  Speed-wise: no.  Space-wise: yes.
> 
> Huh?  At least the "Space-wise: yes" seems rather nonsensical.

A zipped file will be 100% different at each revision.
The unzipped counterpart may be similar for 90% or more between revisions.

Mike
