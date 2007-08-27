From: Mike Hommey <mh@glandium.org>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 15:03:46 +0200
Organization: glandium.org
Message-ID: <20070827130346.GA8821@glandium.org>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org> <vpqtzql17gd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPeIA-0003Zq-MM
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbXH0NFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbXH0NFi
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:05:38 -0400
Received: from vawad.err.no ([85.19.200.177]:48223 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbXH0NFi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:05:38 -0400
Received: from aputeaux-153-1-29-74.w82-124.abo.wanadoo.fr ([82.124.191.74] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IPeH3-0001HM-WD; Mon, 27 Aug 2007 15:05:15 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IPeFu-0002IX-JH; Mon, 27 Aug 2007 15:03:46 +0200
Content-Disposition: inline
In-Reply-To: <vpqtzql17gd.fsf@bauges.imag.fr>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56826>

On Mon, Aug 27, 2007 at 02:35:14PM +0200, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> >
> >> Remarks are welcome (I'll post some remarks about Git's custom diff
> >> driver in a separate thread).
> >
> > Good.
> >
> > I think creation/deletion will get /dev/null as the temporary
> > file name, so as long as odt2txt knows how to deal with
> > /dev/null you would not have to worry much about them.
> 
> But odt2txt doesn't know how to deal with /dev/null. New version of
> git-oodiff that manages it correctly online and below.

BTW, wouldn't it be more efficient to store the odf files unzipped ?

Mike
