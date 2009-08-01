From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 09:43:39 +0200
Message-ID: <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <4A714F5C.70000@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Aug 01 09:43:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MX9G0-00045G-HC
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 09:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbZHAHnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbZHAHnk
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 03:43:40 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33946 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZHAHnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 03:43:40 -0400
Received: by bwz19 with SMTP id 19so1556107bwz.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7h5dc34ISNV9yQ8qmbJqCLk/NBWKyunDmlC1Ko7XX94=;
        b=EVmLdV+IgsksUYH3uaQBFh9JbtUu8RinG9aP3dU6kQrLiD8a6EoLJC3563rkx7hmf4
         XMgGHOpXP+xzbf098vQ8kccDSN99FAL0oRoHY49PnK0VVrRnSwY16Hv+NckLglZiwrYg
         oOD9+So6s2mLdgK4jANnaKg+zzoBAL2TJEMcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hx006KW9w0ffxs2hUNOialz5eMSj1M/eU9dky0Y0QBFnXqD7e40FZtkiYhdnvjstc5
         64wenj8tIyKuBrpu0Sd++U8/oiOocQJt1Pm7HuaaTkGDYafNLMAqpkENFulUONJ/F1eA
         j3MbDmgBdky6DaqnM0IS2U6RjZsgd1BEJWlfI=
Received: by 10.204.121.131 with SMTP id h3mr4038520bkr.172.1249112619356; 
	Sat, 01 Aug 2009 00:43:39 -0700 (PDT)
In-Reply-To: <4A714F5C.70000@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124608>

On Thu, Jul 30, 2009 at 09:44, J.H.<warthog19@eaglescrag.net> wrote:
> Don't use 'lzma' the command, use 'xz' ( http://tukaani.org/xz/ ) as =
it uses

The host seems to be down.

> the lzma2 format which is, by far, preferable to what 'lzma' outputs.=
 =C2=A0Same
> compression (lzma) just different file format.

And the whole project seems to be very young (listen on ohloh since 200=
7).
And it is not in current stable distributions. Exotic thing.
