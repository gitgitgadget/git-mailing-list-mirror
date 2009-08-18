From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Tue, 18 Aug 2009 13:31:49 +0200
Message-ID: <c77435a80908180431k2f91e1ffye25aa8895908ddb7@mail.gmail.com>
References: <op.uys3qwlmtdk399@sirnot.private>
	 <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 13:32:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdMv3-0008IU-J4
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059AbZHRLbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 07:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZHRLbw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:31:52 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:51820 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZHRLbw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 07:31:52 -0400
Received: by ewy3 with SMTP id 3so1496830ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=akN5vL8SId9Eh7+vXFGFHMRqQBDH+/5saMegQG5nRZo=;
        b=oMjXkYoLceesJ6J2B+k0eppQM4DXZAfmBPoYvAZoIAIVeFkyMOK4yPXvMrrS7Ui19I
         ckmNzSQQsoBR20+P1KGkvR74VbgMx0Hhg+3P95fj/J3W5/TWyFxy90h5kQwvCsKrL/Rc
         Dt/L1/wuIVv9d3N3WUIShPsNJCuFFHOjgrUp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qEzRXHftE5HX0IE4osg9cxc1XZ3TZZPzzL6J+wyCiAgnz7NQRqXApxlbpkkZrDERzy
         YSFVNt+GTUni2A7vgcL0jA2kWGwkYv7rOvEUduPM1ewydv0wvPp5DcZBX19t5rMAUmQx
         bZT6nPGHDmInXNIvtn9TpX1fDbTz45I3X7ExE=
Received: by 10.216.4.80 with SMTP id 58mr1188095wei.173.1250595109335; Tue, 
	18 Aug 2009 04:31:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126376>

AARGH scheissgepoops I'm so sorry :-(

> BOOM! =A0:-( =A0And now half of the git commands are just as helpful =
with
> segmentation faults, including 'git log'.
>
> Here's a backtrace from gdb:

I swear I must've been on drugs or something b/c I managed removed the
PROT_WRITE access permission from mmap :-/  cygwin didn't seem to
notice either.  And there's also your explanation of my idiotic
directory permissions choice.

You're also right about the command output; I've added a bit in the
docs explaining the output of each command.

I'll reply to *these* posts with everything fixed.  Then after that
hopefully I can just make patches for the patchset (yo dawg) and save
everyone a lot of bandwidth.

 - Nick
