From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Wed, 18 Mar 2009 06:42:29 +0100
Message-ID: <fabb9a1e0903172242v6f67aa9er40fe0ae2a2db7bc3@mail.gmail.com>
References: <200903171953.23650.ogoffart@kde.org>
	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
	 <20090318004056.GB25454@coredump.intra.peff.net>
	 <7vsklbod0l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 06:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljofi-0002w2-EI
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbZCRFsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 01:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZCRFsp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:48:45 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59706 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbZCRFso convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 01:48:44 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2009 01:48:44 EDT
Received: by fxm2 with SMTP id 2so343625fxm.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TJ7L3Kl/QVzmp2dQOP8r4m9X//kkPqgzrCsVnB+CMK8=;
        b=mKBSADi8CvQcD0EEUfwor11cQFVrmaD3HuWdZQmnDw0qsjfnfFOATJ4vAJ7jYnKCAw
         Nlyge7iwBBL6I5jKJlET8jGh3y9TLvQYgTMsKlbckJv6a0Jadga61mrWTu+ADir8RUUx
         zxKmZPwAW6mDe5YNMaMt1UonHj/zOqpLMcm5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BULV/mIw9i2wdWPPN5D/84cNhHK/NBlqsBEGzT8YAQF6FmVMpY3Fu4LrntkXjzorS0
         p+LLuS9kduogudyCodBQ6IinVPO2kIVfDcDwDBMkM2dnteDCawr6dzvDzU/IgAuX6jj7
         qm9W1sSp9rlnRwTRi9HZdgu6hN0LnmLsKRhjo=
Received: by 10.103.171.20 with SMTP id y20mr375175muo.19.1237354949532; Tue, 
	17 Mar 2009 22:42:29 -0700 (PDT)
In-Reply-To: <7vsklbod0l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113581>

Heya,

On Wed, Mar 18, 2009 at 02:06, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jeff King <peff@peff.net> writes:
> I am not quite sure what rephrase is buying us. =A0Do we also want to
> introduce retree that allows you to muck with the tree object recorde=
d
> without giving you a chance to clobber the commit log message?

Is that a common operation? Rephrase is, at least to me...

--=20
Cheers,

Sverre Rabbelier
