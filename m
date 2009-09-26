From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found 
	by the clang static analyzer
Date: Sat, 26 Sep 2009 20:34:22 +0200
Message-ID: <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
References: <87ab0hepcn.fsf@master.homenet> <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de> 
	<871vltefdj.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 20:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrc6j-0003UL-MQ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 20:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbZIZSej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 14:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbZIZSej
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 14:34:39 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:64961 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZIZSej convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 14:34:39 -0400
Received: by ewy7 with SMTP id 7so3388402ewy.17
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wXpVmUce4VoY2+mjbvv7OFkVi92FLYAMM/NccAu5/bY=;
        b=g5BwLRERZF9jKkmXj0kg50/bGD3S3JPYMXdbtSUll/SejfG8PtFtuXXbJc9X0YNBr6
         TAOdKKBTnratisLXmuYXx1WPFURojOacVMV00CNoAJBopRrz5zesBrTxUIfCUuw4qOMT
         +TRm2aqihgQBbGFhvM8xGzj2QQPhnHHfYk17g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v/dk9ilPuUBgWysYqUTK7tQGx/au4B0Qe3VVw0/NMXRQdMvgpeByMMVP/HcJQ54Tf0
         QnIXWSix3P6GMlT9wdCrT/lFerx/y1GDpLTWPABpsEgmtAFG8oZB2yeAHlFsBmDBCmRg
         bagHeOn3WedgBa6poW1Iv9XPV+tA2JfXr/EY4=
Received: by 10.216.22.211 with SMTP id t61mr338179wet.217.1253990082117; Sat, 
	26 Sep 2009 11:34:42 -0700 (PDT)
In-Reply-To: <871vltefdj.fsf@master.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129165>

Heya,

On Sat, Sep 26, 2009 at 20:21, Giuseppe Scrivano <gscrivano@gnu.org> wr=
ote:
> probably this is not the only case to leave as it is. =A0I just clean=
ed
> anything clang reported.

Then it would probably have been better to say so by at least marking
your patch as RFC and including such a remark in the cover letter, no?
Also, now that this has been pointed out, you shouldn't expect it to
be included until someone either takes your patch and cleans it up (as
in, checks all statements manually), or until you do so yourself.

--=20
Cheers,

Sverre Rabbelier
