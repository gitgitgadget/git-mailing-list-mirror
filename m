From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Tue, 13 Oct 2009 21:05:54 -0400
Message-ID: <76718490910131805o42e8321ama85b90b7e901dc7d@mail.gmail.com>
References: <0016e68fd0123a175304754694b4@google.com>
	 <200910130836.57011.trast@student.ethz.ch>
	 <7vljjf226t.fsf@alter.siamese.dyndns.org>
	 <200910131051.47117.trast@student.ethz.ch>
	 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
	 <20091013220640.GB12603@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 03:13:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxsQc-0007WX-P1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 03:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761244AbZJNBGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 21:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760223AbZJNBGd
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 21:06:33 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:53250 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZJNBGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 21:06:32 -0400
Received: by vws41 with SMTP id 41so5514779vws.4
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cHtAhCDutGSL2VSRjv2kWUGWnSxbhJzRc27xLL+npDs=;
        b=gp9PWIY7MC85KEfrWx8N7Qy9w6n9HoQhnrj7XmDjdzGE0aMUOUHQkFE1pWFbegLFjX
         B2dWfzpZ6gwI0VmvXDtiJbFS2caPrCyM+hXc196ybAFYRon8WT1Y8A797R0DohlvD5ak
         MqSluKlV7lVHsUM0wgbtUHM2gFlygzWmvmY5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mzCgorGMAULW4fFdKLxjgHLf6thU17McWp9XM/bpRrwJ4u9JEa3NldiYwPMmE/GBEh
         yJYMvLi6g4f9E4gHikCp8fjFhBw9IjEP8KdVYjPfr6rFwW3wewM4IqIrDcoiaMj2lnD1
         +fL/2UnzfIPyTKXlvtp8Cda8aj1us0fiDy6bc=
Received: by 10.220.107.226 with SMTP id c34mr1533993vcp.69.1255482354480; 
	Tue, 13 Oct 2009 18:05:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130233>

On Tue, Oct 13, 2009 at 7:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> At some point, trying to educate the user is not helpful but annoying=
=2E =C2=A0If
> Git already knows what I want, why does it not do it already? =C2=A0_=
That_ is
> the question I already hear in my ears.

Modify checkout so that the first commit while detached automatically
creates a branch. Perhaps the name is derived from the branch point,
or the user is prompted for a name.

This doesn't help with the original problem, which was that a user
attempted to checkout refs/remotes/origin/<name> by just saying 'git
checkout <name>' which I happen to think should work. A lot of what I
keep hearing in this thread seems to be in the vein of the perfect
being the enemy of the good.

That rambled a bit. Sorry.

j.
