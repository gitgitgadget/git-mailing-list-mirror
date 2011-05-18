From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 21:05:23 -0400
Message-ID: <BANLkTinaP8G3Kt0bMZ6QEW6SFNau7dRLMA@mail.gmail.com>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
	<1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
	<7vei3zoab9.fsf@alter.siamese.dyndns.org>
	<BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com>
	<20110516070047.GA26270@elie>
	<7vei3xgsy3.fsf@alter.siamese.dyndns.org>
	<7vtyctf142.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 03:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMVCb-0006Ky-De
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 03:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab1ERBFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 21:05:24 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:55958 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab1ERBFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 21:05:23 -0400
Received: by pxi16 with SMTP id 16so730918pxi.4
        for <git@vger.kernel.org>; Tue, 17 May 2011 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yBr8I3OoyAZYMxoFzGQVJ42P6rzSTJPy9iU/bodhwxA=;
        b=M3BwMeHGgEkCUuOtjS0yr8GpnMMrrLFRSXg437UjtPZ2OsNCSCV6L5qGW8A+To6PTf
         G0+hDfv58SR1ZRUR4Rl6a1s7/Yx1LD67kV3kD01xi0BkI0ls5P1InHSrheyVumVb16Eg
         zH+MnOx7KHVdVRiZuBrK2DSq3CM7WgMMSG3rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iFciH/visPkv71yjtiN9u+vQ/ZQv4/hHSugeZ5MPIc63tD04d9dmX7P32ufOw8g77w
         WVNJDL0v8xfCSp1OJBbz3o2JW5UyxhdxUbvbPIrfaFhxZ2AsplqQfUsRFlZccRwi7bh3
         xZjOgHI4eYNBKNtre/0+Prd/NeqF6XzxNmzdw=
Received: by 10.142.147.10 with SMTP id u10mr836121wfd.112.1305680723467; Tue,
 17 May 2011 18:05:23 -0700 (PDT)
Received: by 10.142.200.15 with HTTP; Tue, 17 May 2011 18:05:23 -0700 (PDT)
In-Reply-To: <7vtyctf142.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173833>

On Tue, May 17, 2011 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I haven't applied v3 (nor my fix-up in the discussion) yet, as this is not
> my itch, but have you tested all commands from "log" family with your
> patch, including "git reflog"?

Gah. Thank you for catching that, I had checked it (I think) with v1.
I should've added a test then, which I've done for v4. Sending
shortly.

j.
