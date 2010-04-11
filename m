From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 17:48:28 +0200
Message-ID: <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 17:48:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0zP4-0008N6-Or
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 17:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab0DKPsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 11:48:50 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:40030 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab0DKPst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 11:48:49 -0400
Received: by yxe1 with SMTP id 1so2136839yxe.33
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=F+EXHIXGPZ8CAFDwavk4YTQf7qDbBwiRDvdtgH3/WvQ=;
        b=MJ1vxF+UGCeUTWohiF9HnJbPwjcicXL2oiyo57/A1Lat2QzZ5a2tK+5k7stNGhIbSj
         mYHbg9uPwQDNl4TlqzLGsggc/p/GP1gBRaVYp9kBdQUhXfme3qjM1pDi+oAutrW2VfwY
         X+j+FUkjtoPXXcx3KiqUIBn2yoLn24+xoIEfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gg4U31d1XXtL63YpYLLtalsWGZ4s08UOhmsRbjvKmeRIXzA6D5/ewKRWUv9AWkg4rV
         HgXRhvUOWWsVam/McdtjNxj3uAKWQ2DSa5OsNHVcxZXnnZXn754REPbNmLCJYdMyWAFx
         u0dp0LRBMeUoVvDRzwRzMr748O5Ttr+B7H61Y=
Received: by 10.100.206.13 with HTTP; Sun, 11 Apr 2010 08:48:28 -0700 (PDT)
In-Reply-To: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
Received: by 10.101.101.2 with SMTP id d2mr4583023anm.240.1271000928420; Sun, 
	11 Apr 2010 08:48:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144653>

Heya,

On Sun, Apr 11, 2010 at 13:37, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> Here is an attempt at making a format agnostic structured output libr=
ary. =C2=A0The
> idea being that the command doing the output doesn't have to care wha=
t the
> actual output format is, it just uses the abstract notion of objects =
and arrays.

How easy is it to add support for this to other commands using the
infrastructure this command adds? I assume that we'd want to do this
for all/most plumbing commands, so I think it's important that we make
sure it's easy to add for other commands other than 'git status', no?

--=20
Cheers,

Sverre Rabbelier
