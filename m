From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked branch
Date: Sat, 21 Mar 2009 00:20:21 +0100
Message-ID: <fabb9a1e0903201620l456bfc39n2422dcb1e738eb37@mail.gmail.com>
References: <200903181448.50706.agruen@suse.de> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> 
	<alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> 
	<20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org> 
	<alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> 
	<7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:23:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lko3F-0006Se-0c
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 00:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762479AbZCTXUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 19:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762458AbZCTXUl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 19:20:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45234 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762043AbZCTXUj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 19:20:39 -0400
Received: by fxm2 with SMTP id 2so1095235fxm.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CPFOAh7TJvJQXYVEDLY6FVI5jKzrWQNNepbomcc0aVs=;
        b=G3GZgOMJFVTdlT+D0aE8snAJnAcvKC3ZsqVhrPbnSjWTlX4fdnRQ5DwwJ96YFoPl/V
         UehX4IcdrLZ1XDPBmdkn0VMHtsYZA3EhucJjd1AfqFrl2cR2wDl2citbnAsraR/t+7pM
         /iO6p89SHe9H+qrXszzr3D4wLrJPDYBtKpJ1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oJ8y9U7ELQcevVntYrKamzHQn5Zd1ShTMQMiF3LBuoShgzeRLY29syxNFpVS2T/DaP
         35C3I1AfV2BRUIafeJLWI5tnHCNNhXktNinKEcAWhHAGVI7ehkkoa4vSMoxJJ8L26N9k
         Y2G7zuJullBfk3sxegAzUmCW3lzFi1dij4DOc=
In-Reply-To: <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
Received: by 10.103.171.20 with SMTP id y20mr1938360muo.122.1237591236252; 
	Fri, 20 Mar 2009 16:20:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114016>

Heya,

On Sat, Mar 21, 2009 at 00:08, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> =A0git branch -m "'%master" percent-master

Which kinda defeats the purpose of having a short-and-easy-to-write
refname, no? "'%master" is not that easy to type, I at least get my
fingers mixed up in the "'% sequence. Perhaps we should reserve these
special characters now, and deprecate their use? Junio seemed to be
open to that (quoted below)...

> Just be honest and say "You may have a branch whose name begins with =
a '%'
> and you cannot refer to it anymore in certain contexts.  Too bad.  Do=
n't
> do it next time you create a new branch".  I _can_ buy that argument.

--=20
Cheers,

Sverre Rabbelier
