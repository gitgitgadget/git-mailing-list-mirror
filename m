From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 22:00:39 -0700
Message-ID: <fabb9a1e0908242200v22057a72ta4998633701c408b@mail.gmail.com>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> 
	<alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> 
	<alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> 
	<alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:01:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfo9e-00079g-Dm
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbZHYFA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 01:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbZHYFA7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:00:59 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:39974 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbZHYFA6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 01:00:58 -0400
Received: by ey-out-2122.google.com with SMTP id 22so750357eye.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 22:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=L97qSNOJ/btDG089hh0XBeequBF4P4edyTOZaucua80=;
        b=vfduqKJmuArh0umLxcv4SzjZ6kamZACk7MLVzAt1kYs6CK6VP+P5YjRnaU6+FJ3AzL
         +oeQnwoWBLAKv2Q8kmzqB3vIf3pGHyVavIZ/JZSAWauoEjTQOtKU3SP9le6ZRvE5cQof
         U+m2as8Ml/KWQAWLO0ZvuQxXOFFUxRcDevBK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oqlyI1G9IucJIWlgZ+6aSi4ltHviyAhjMAYgLuj1S2AmyZ5+1p5iFXquMXNsTQG1sH
         kVRA/9KtgHJ5lwbeNElLAj6XAy9EQt52Bqadm9q+NmYwRmCgkHag+3ZTrT1wbTUZ0QYh
         01C1w8MsYCkJa0vRaD/Ck7Tdq3SGMpgvBCu5c=
Received: by 10.216.90.6 with SMTP id d6mr1147613wef.95.1251176459142; Mon, 24 
	Aug 2009 22:00:59 -0700 (PDT)
In-Reply-To: <20090825021223.GE1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127001>

Heya,

On Mon, Aug 24, 2009 at 19:12, Shawn O. Pearce<spearce@spearce.org> wro=
te:
> =A0git fetch --uploadpack=3D'git upload-pack --ref refs/changes/88/44=
88/2' URL refs/changes/88/4488/2
>
> Personally I'd prefer extending the protocol, because making the
> end user supply information twice is stupid.

$ git fetch --unadvertised URL refs/changes/88/4488/2

And we expand that to the above behind the screens?

--=20
Cheers,

Sverre Rabbelier
