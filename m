From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees 
	with various fanout schemes
Date: Thu, 27 Aug 2009 20:05:31 -0700
Message-ID: <fabb9a1e0908272005i4bf9b906xba08a711d384dd83@mail.gmail.com>
References: <1251337437-16947-1-git-send-email-johan@herland.net> 
	<20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org> 
	<200908280103.06015.johan@herland.net> <20090827233900.GA7347@coredump.intra.peff.net> 
	<7viqg8hj98.fsf@alter.siamese.dyndns.org> <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com> 
	<7vocq0d86p.fsf@alter.siamese.dyndns.org> <fabb9a1e0908271951t1f2db976jb1de1e7687ad9791@mail.gmail.com> 
	<7v4orsbpzd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 05:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgrmr-0001We-E9
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 05:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbZH1DFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 23:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZH1DFu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 23:05:50 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56603 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZH1DFu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 23:05:50 -0400
Received: by ewy2 with SMTP id 2so1788776ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=7gb2A+DEjBF3wvSg0T/92i5wpVPSZxZVgEQS108nvUk=;
        b=SU12jeJXhdS6sjlli0kePhvf3392IGLHspNC6qHUnI53b+L2Mtd/iJuq9h5uwMh2RF
         wB8WauTkXn0BtTCfuT677Oi3yS7xYCXiLIDRdhZ49SE5lFOQ5vfupSed1pN1ZwYVou+5
         G/sTe5KykhGpym8z/occjkBhjsHJKRBJw482E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SGae14AWlhb/IeB2ktUv9M1/td9b8zLde8jDj4Vdwj4/ThZcupDPLe3YYAPxBZ2d7V
         9l973H9eKX04kFfwhxGFVpIjEY6DTh5uDwBKH/O/sOOX4jb+X+zmJh1THWRWR3VC8xkK
         oZG1eUJtkQ6KULCHDxTKm8iezx5gw8e3VsU5M=
Received: by 10.216.88.79 with SMTP id z57mr123363wee.22.1251428751096; Thu, 
	27 Aug 2009 20:05:51 -0700 (PDT)
In-Reply-To: <7v4orsbpzd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127248>

Heya,

On Thu, Aug 27, 2009 at 20:02, Junio C Hamano<gitster@pobox.com> wrote:
> In such a case would you rather want to see the commit itself first, or at
> least, commit _and_ notes _together_?

Assuming you do download all notes, I think it would be nice to be
able to read the note; and since there's no way to download the commit
separately it would require one to guess which head the commit belongs
to and fetch the entire branch...?

-- 
Cheers,

Sverre Rabbelier
