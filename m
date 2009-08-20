From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Thu, 20 Aug 2009 14:48:29 +0700
Message-ID: <fcaeb9bf0908200048v4c918a16o6c0e0fb545742f2@mail.gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908192142.51384.jnareb@gmail.com> 
	<alpine.LFD.2.00.0908191552020.6044@xanadu.home> <200908200937.05412.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 09:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me2OJ-0006KV-B5
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 09:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbZHTHst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 03:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbZHTHss
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 03:48:48 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:43579 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZHTHss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 03:48:48 -0400
Received: by yxe5 with SMTP id 5so6087168yxe.33
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4IWMeV5+b7hYmKg1h9dd31B5xJP4z6mTcswQsIedMtw=;
        b=G+GB2yuEup8fiu0UloWUx2XddHKnJS+M9Iu9eUvGJc0xBmTJ8/QhXaU8DKSgFk8704
         OW1Wiktzzt78rzwqdCg72WZMVvMm27hgUgk4rXD6vNY57s8xQfZ5aQQ0XsmFVUkFy0O3
         1WMEOFkifxEwsrYLvgUd9d4fwbmhJP1h/64BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JbT1OQPT3GFN2zZWUyFCkZ0JfTjiN7x4+6JEtdOyUL0FChdc1ATDBgWxWF4t8MqJ9u
         5O4rl+rSWuCKdEuWilJuAajza1h2TolIeG3H29NzBfHKnuEGIFpgaHiOGwD9hhlcxDru
         TjkJpTh1p21odH4MDUC6XlhDmOgdECbkPl/JQ=
Received: by 10.101.81.10 with SMTP id i10mr8216082anl.123.1250754529079; Thu, 
	20 Aug 2009 00:48:49 -0700 (PDT)
In-Reply-To: <200908200937.05412.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126613>

On Thu, Aug 20, 2009 at 2:37 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> *NEW IDEA*
>
> Another solution would be to try to come up with some sort of stable
> sorting of objects so that packfile generated for the same parameters
> (endpoints) would be always byte-for-byte the same. =C2=A0But that mi=
ght be
> difficult, or even impossible.

Isn't it the idea of commit reels [1] from git-torrent?

[1] http://gittorrent.utsl.gen.nz/rfc.html#org-reels
--=20
Duy
